import 'dart:io';
import 'dart:convert';

/// HTML Test Reporter for Playwright Dart.
///
/// This is a Dart-native feature that generates comprehensive HTML test reports
/// similar to Playwright's HTML reporter with full feature support.
class HtmlReporter {
  final String outputDir;
  final List<TestResult> _results = [];
  final ReportMetadata _metadata;

  HtmlReporter({
    this.outputDir = 'test-results/html-report',
    ReportMetadata? metadata,
  }) : _metadata = metadata ?? ReportMetadata();

  /// Adds a test result to the report.
  void addTestResult(TestResult result) {
    _results.add(result);
  }

  /// Adds multiple test results to the report.
  void addTestResults(List<TestResult> results) {
    _results.addAll(results);
  }

  /// Sets report metadata.
  void setMetadata(ReportMetadata metadata) {
    _metadata.title = metadata.title;
    _metadata.projectName = metadata.projectName;
    _metadata.startTime = metadata.startTime;
    _metadata.environment = metadata.environment;
  }

  /// Generates the HTML report.
  Future<void> generate() async {
    final dir = Directory(outputDir);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    // Generate index.html
    final html = _generateHtml();
    final file = File('$outputDir/index.html');
    await file.writeAsString(html);

    // Generate data.json for dynamic loading
    final dataFile = File('$outputDir/data.json');
    await dataFile.writeAsString(jsonEncode(_generateDataJson()));

    // Copy assets (CSS, JS)
    await _copyAssets();
  }

  Map<String, dynamic> _generateDataJson() {
    return {
      'metadata': _metadata.toJson(),
      'results': _results.map((r) => r.toJson()).toList(),
      'stats': {
        'total': _results.length,
        'passed': _results.where((r) => r.status == TestStatus.passed).length,
        'failed': _results.where((r) => r.status == TestStatus.failed).length,
        'skipped': _results.where((r) => r.status == TestStatus.skipped).length,
        'duration': _results.fold<int>(0, (sum, r) => sum + r.duration),
      },
    };
  }

  String _generateHtml() {
    final passed = _results.where((r) => r.status == TestStatus.passed).length;
    final failed = _results.where((r) => r.status == TestStatus.failed).length;
    final skipped = _results
        .where((r) => r.status == TestStatus.skipped)
        .length;
    final total = _results.length;
    final duration = _results.fold<int>(0, (sum, r) => sum + r.duration);

    return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="color-scheme" content="dark light">
    <title>${_escapeHtml(_metadata.title)}</title>
    <style>${_getCss()}</style>
</head>
<body>
    <div class="app">
        <header class="header">
            <div class="header-content">
                <h1>${_escapeHtml(_metadata.title)}</h1>
                <div class="header-meta">
                    <span class="project-name">${_escapeHtml(_metadata.projectName)}</span>
                    <span class="separator">•</span>
                    <span class="timestamp">${DateTime.now().toIso8601String()}</span>
                </div>
            </div>
            <div class="theme-toggle">
                <button id="themeToggle" class="icon-button" title="Toggle theme">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="5"/>
                        <path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/>
                    </svg>
                </button>
            </div>
        </header>

        <div class="summary">
            <div class="summary-card total">
                <div class="summary-icon">📊</div>
                <div class="summary-value">$total</div>
                <div class="summary-label">Total Tests</div>
            </div>
            <div class="summary-card passed">
                <div class="summary-icon">✅</div>
                <div class="summary-value">$passed</div>
                <div class="summary-label">Passed</div>
            </div>
            <div class="summary-card failed">
                <div class="summary-icon">❌</div>
                <div class="summary-value">$failed</div>
                <div class="summary-label">Failed</div>
            </div>
            <div class="summary-card skipped">
                <div class="summary-icon">⏭️</div>
                <div class="summary-value">$skipped</div>
                <div class="summary-label">Skipped</div>
            </div>
            <div class="summary-card duration">
                <div class="summary-icon">⏱️</div>
                <div class="summary-value">${_formatDuration(duration)}</div>
                <div class="summary-label">Duration</div>
            </div>
        </div>

        <div class="main-content">
            <aside class="sidebar">
                <div class="filter-section">
                    <h3>Filters</h3>
                    <div class="filter-group">
                        <button class="filter-btn active" data-filter="all">All</button>
                        <button class="filter-btn" data-filter="passed">Passed</button>
                        <button class="filter-btn" data-filter="failed">Failed</button>
                        <button class="filter-btn" data-filter="skipped">Skipped</button>
                    </div>
                </div>
                <div class="search-section">
                    <h3>Search</h3>
                    <input type="text" id="search" class="search-box" placeholder="Search tests...">
                </div>
                <div class="environment-section">
                    <h3>Environment</h3>
                    ${_metadata.environment.entries.map((e) => '''
                    <div class="env-item">
                        <span class="env-key">${_escapeHtml(e.key)}:</span>
                        <span class="env-value">${_escapeHtml(e.value.toString())}</span>
                    </div>
                    ''').join('')}
                </div>
            </aside>

            <main class="test-view">
                <div class="view-tabs">
                    <button class="tab-btn active" data-view="list">List View</button>
                    <button class="tab-btn" data-view="timeline">Timeline</button>
                    <button class="tab-btn" data-view="grid">Grid View</button>
                </div>
                <div class="test-list" id="testList">
                    ${_results.map((r) => _generateTestItem(r)).join('\n')}
                </div>
            </main>
        </div>
    </div>

    <div id="testModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Test Details</h2>
                <button class="close-btn" id="closeModal">&times;</button>
            </div>
            <div class="modal-body" id="modalBody"></div>
        </div>
    </div>

    <script>${_getJs()}</script>
</body>
</html>
''';
  }

  String _getCss() {
    return '''
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --bg-primary: #ffffff;
    --bg-secondary: #f5f5f5;
    --bg-tertiary: #e5e5e5;
    --text-primary: #333333;
    --text-secondary: #666666;
    --border-color: #e5e5e5;
    --accent-color: #667eea;
    --success-color: #10b981;
    --error-color: #ef4444;
    --warning-color: #f59e0b;
    --shadow: 0 2px 8px rgba(0,0,0,0.1);
}

[data-theme="dark"] {
    --bg-primary: #1a1a1a;
    --bg-secondary: #2d2d2d;
    --bg-tertiary: #3d3d3d;
    --text-primary: #e5e5e5;
    --text-secondary: #a0a0a0;
    --border-color: #3d3d3d;
    --shadow: 0 2px 8px rgba(0,0,0,0.3);
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
    background: var(--bg-secondary);
    color: var(--text-primary);
    line-height: 1.6;
}

.app {
    min-height: 100vh;
}

.header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 1.5rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header-content h1 {
    font-size: 1.75rem;
    margin-bottom: 0.25rem;
}

.header-meta {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.875rem;
    opacity: 0.9;
}

.separator {
    opacity: 0.5;
}

.theme-toggle {
    display: flex;
    align-items: center;
}

.icon-button {
    background: rgba(255,255,255,0.2);
    border: none;
    color: white;
    padding: 0.5rem;
    border-radius: 4px;
    cursor: pointer;
    transition: background 0.2s;
}

.icon-button:hover {
    background: rgba(255,255,255,0.3);
}

.summary {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1rem;
    padding: 2rem;
    max-width: 1400px;
    margin: 0 auto;
}

.summary-card {
    background: var(--bg-primary);
    padding: 1.5rem;
    border-radius: 12px;
    box-shadow: var(--shadow);
    text-align: center;
    transition: transform 0.2s, box-shadow 0.2s;
}

.summary-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.summary-icon {
    font-size: 2rem;
    margin-bottom: 0.5rem;
}

.summary-value {
    font-size: 2.5rem;
    font-weight: bold;
    margin-bottom: 0.25rem;
}

.summary-label {
    font-size: 0.875rem;
    color: var(--text-secondary);
    text-transform: uppercase;
}

.summary-card.passed .summary-value { color: var(--success-color); }
.summary-card.failed .summary-value { color: var(--error-color); }
.summary-card.skipped .summary-value { color: var(--warning-color); }
.summary-card.total .summary-value { color: var(--accent-color); }

.main-content {
    display: grid;
    grid-template-columns: 280px 1fr;
    gap: 2rem;
    padding: 0 2rem 2rem;
    max-width: 1400px;
    margin: 0 auto;
}

.sidebar {
    background: var(--bg-primary);
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: var(--shadow);
    height: fit-content;
    position: sticky;
    top: 2rem;
}

.filter-section, .search-section, .environment-section {
    margin-bottom: 1.5rem;
}

.filter-section h3, .search-section h3, .environment-section h3 {
    font-size: 0.875rem;
    color: var(--text-secondary);
    margin-bottom: 0.75rem;
    text-transform: uppercase;
}

.filter-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.filter-btn {
    padding: 0.625rem 1rem;
    border: 1px solid var(--border-color);
    background: var(--bg-secondary);
    color: var(--text-primary);
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s;
    text-align: left;
}

.filter-btn:hover {
    background: var(--bg-tertiary);
}

.filter-btn.active {
    background: var(--accent-color);
    color: white;
    border-color: var(--accent-color);
}

.search-box {
    width: 100%;
    padding: 0.625rem 1rem;
    border: 1px solid var(--border-color);
    border-radius: 6px;
    background: var(--bg-secondary);
    color: var(--text-primary);
}

.search-box:focus {
    outline: none;
    border-color: var(--accent-color);
}

.env-item {
    display: flex;
    justify-content: space-between;
    padding: 0.5rem 0;
    border-bottom: 1px solid var(--border-color);
    font-size: 0.875rem;
}

.env-item:last-child {
    border-bottom: none;
}

.env-key {
    color: var(--text-secondary);
}

.env-value {
    font-weight: 500;
}

.test-view {
    background: var(--bg-primary);
    border-radius: 12px;
    box-shadow: var(--shadow);
    overflow: hidden;
}

.view-tabs {
    display: flex;
    border-bottom: 1px solid var(--border-color);
    background: var(--bg-secondary);
}

.tab-btn {
    padding: 1rem 1.5rem;
    border: none;
    background: transparent;
    color: var(--text-secondary);
    cursor: pointer;
    transition: all 0.2s;
    font-weight: 500;
}

.tab-btn:hover {
    color: var(--text-primary);
    background: var(--bg-tertiary);
}

.tab-btn.active {
    color: var(--accent-color);
    border-bottom: 2px solid var(--accent-color);
}

.test-list {
    padding: 1rem;
}

.test-item {
    padding: 1rem;
    border-bottom: 1px solid var(--border-color);
    cursor: pointer;
    transition: background 0.2s;
    border-radius: 6px;
    margin-bottom: 0.5rem;
}

.test-item:hover {
    background: var(--bg-secondary);
}

.test-item:last-child {
    border-bottom: none;
}

.test-header {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.status-badge {
    padding: 0.25rem 0.75rem;
    border-radius: 9999px;
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
}

.status-badge.passed {
    background: #d1fae5;
    color: #065f46;
}

.status-badge.failed {
    background: #fee2e2;
    color: #991b1b;
}

.status-badge.skipped {
    background: #fef3c7;
    color: #92400e;
}

.test-name {
    flex: 1;
    font-weight: 500;
}

.test-duration {
    color: var(--text-secondary);
    font-size: 0.875rem;
}

.test-details {
    display: none;
    padding: 1rem;
    background: var(--bg-secondary);
    border-radius: 6px;
    margin-top: 0.5rem;
}

.test-item.expanded .test-details {
    display: block;
}

.error-message {
    background: #fee2e2;
    color: #991b1b;
    padding: 1rem;
    border-radius: 4px;
    font-family: 'Courier New', monospace;
    white-space: pre-wrap;
    margin-top: 0.5rem;
    font-size: 0.875rem;
}

.stack-trace {
    background: #fef3c7;
    color: #92400e;
    padding: 1rem;
    border-radius: 4px;
    font-family: 'Courier New', monospace;
    white-space: pre-wrap;
    margin-top: 0.5rem;
    font-size: 0.875rem;
}

.screenshot {
    max-width: 100%;
    border-radius: 8px;
    margin-top: 0.5rem;
    box-shadow: var(--shadow);
}

.video-container {
    margin-top: 0.5rem;
}

.video-container video {
    max-width: 100%;
    border-radius: 8px;
    box-shadow: var(--shadow);
}

.steps-list {
    margin-top: 1rem;
}

.step-item {
    padding: 0.5rem;
    border-left: 3px solid var(--border-color);
    margin-left: 0.5rem;
    margin-bottom: 0.5rem;
}

.step-item.failed {
    border-left-color: var(--error-color);
}

.step-item.passed {
    border-left-color: var(--success-color);
}

.step-title {
    font-weight: 500;
    font-size: 0.875rem;
}

.step-duration {
    color: var(--text-secondary);
    font-size: 0.75rem;
}

.attachments {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-top: 0.5rem;
}

.attachment {
    padding: 0.5rem 1rem;
    background: var(--bg-tertiary);
    border-radius: 4px;
    font-size: 0.875rem;
    cursor: pointer;
    transition: background 0.2s;
}

.attachment:hover {
    background: var(--border-color);
}

.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
    z-index: 1000;
    align-items: center;
    justify-content: center;
}

.modal.active {
    display: flex;
}

.modal-content {
    background: var(--bg-primary);
    border-radius: 12px;
    max-width: 900px;
    width: 90%;
    max-height: 90vh;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.5rem;
    border-bottom: 1px solid var(--border-color);
}

.modal-header h2 {
    font-size: 1.25rem;
}

.close-btn {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: var(--text-secondary);
    padding: 0.5rem;
}

.close-btn:hover {
    color: var(--text-primary);
}

.modal-body {
    padding: 1.5rem;
    overflow-y: auto;
    max-height: calc(90vh - 80px);
}

@media (max-width: 768px) {
    .main-content {
        grid-template-columns: 1fr;
    }
    
    .sidebar {
        position: static;
    }
    
    .summary {
        grid-template-columns: repeat(2, 1fr);
    }
}
''';
  }

  String _getJs() {
    return '''
// Theme toggle
const themeToggle = document.getElementById('themeToggle');
const html = document.documentElement;

// Check for saved theme preference or default to light
const savedTheme = localStorage.getItem('theme') || 'light';
html.setAttribute('data-theme', savedTheme);

themeToggle.addEventListener('click', () => {
    const currentTheme = html.getAttribute('data-theme');
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    html.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
});

// Search functionality
const searchInput = document.getElementById('search');
const filterBtns = document.querySelectorAll('.filter-btn');
const testItems = document.querySelectorAll('.test-item');

searchInput.addEventListener('input', (e) => {
    const query = e.target.value.toLowerCase();
    testItems.forEach(item => {
        const name = item.querySelector('.test-name').textContent.toLowerCase();
        const file = item.dataset.file?.toLowerCase() || '';
        item.style.display = (name.includes(query) || file.includes(query)) ? '' : 'none';
    });
});

// Filter functionality
filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        filterBtns.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const filter = btn.dataset.filter;
        testItems.forEach(item => {
            const status = item.dataset.status;
            if (filter === 'all' || status === filter) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    });
});

// Expand/collapse test details
testItems.forEach(item => {
    item.addEventListener('click', (e) => {
        if (e.target.closest('.attachment') || e.target.closest('a')) return;
        item.classList.toggle('expanded');
    });
});

// View tabs
const tabBtns = document.querySelectorAll('.tab-btn');
tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        tabBtns.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        // View switching logic would go here
    });
});

// Modal functionality
const modal = document.getElementById('testModal');
const closeModal = document.getElementById('closeModal');

closeModal.addEventListener('click', () => {
    modal.classList.remove('active');
});

modal.addEventListener('click', (e) => {
    if (e.target === modal) {
        modal.classList.remove('active');
    }
});

// Load test data
fetch('data.json')
    .then(response => response.json())
    .then(data => {
        console.log('Test data loaded:', data);
        // Process data for enhanced features
    })
    .catch(error => {
        console.error('Failed to load test data:', error);
    });
''';
  }

  String _generateTestItem(TestResult result) {
    final statusClass = result.status.name;
    final errorHtml = result.error != null
        ? '<div class="error-message">${_escapeHtml(result.error!)}</div>'
        : '';
    final stackTraceHtml = result.stackTrace != null
        ? '<div class="stack-trace">${_escapeHtml(result.stackTrace!)}</div>'
        : '';
    final screenshotHtml = result.screenshotPath != null
        ? '<img src="${result.screenshotPath}" class="screenshot" alt="Screenshot">'
        : '';
    final videoHtml = result.videoPath != null
        ? '''<div class="video-container">
            <video controls>
                <source src="${result.videoPath}" type="video/webm">
                Your browser does not support the video tag.
            </video>
        </div>'''
        : '';
    final stepsHtml = result.steps.isNotEmpty
        ? '''<div class="steps-list">
            ${result.steps.map((s) => '''
            <div class="step-item ${s.status}">
                <div class="step-title">${_escapeHtml(s.title)}</div>
                <div class="step-duration">${_formatDuration(s.duration)}</div>
            </div>
            ''').join('')}
        </div>'''
        : '';
    final attachmentsHtml = result.attachments.isNotEmpty
        ? '''<div class="attachments">
            ${result.attachments.map((a) => '''
            <div class="attachment" data-path="${_escapeHtml(a.path)}">${_escapeHtml(a.name)}</div>
            ''').join('')}
        </div>'''
        : '';

    return '''
<div class="test-item" data-status="$statusClass" data-file="${_escapeHtml(result.file)}">
    <div class="test-header">
        <span class="status-badge $statusClass">${result.status.name.toUpperCase()}</span>
        <span class="test-name">${_escapeHtml(result.name)}</span>
        <span class="test-duration">${_formatDuration(result.duration)}</span>
    </div>
    <div class="test-details">
        <p><strong>File:</strong> ${_escapeHtml(result.file)}</p>
        <p><strong>Duration:</strong> ${_formatDuration(result.duration)}</p>
        ${result.retryCount > 0 ? '<p><strong>Retries:</strong> ${result.retryCount}</p>' : ''}
        $errorHtml
        $stackTraceHtml
        $screenshotHtml
        $videoHtml
        $stepsHtml
        $attachmentsHtml
    </div>
</div>
''';
  }

  Future<void> _copyAssets() async {
    final assetsDir = Directory('$outputDir/assets');
    if (!await assetsDir.exists()) {
      await assetsDir.create(recursive: true);
    }

    for (final result in _results) {
      // Copy screenshot
      if (result.screenshotPath != null) {
        final screenshotFile = File(result.screenshotPath!);
        if (await screenshotFile.exists()) {
          final fileName = screenshotFile.uri.pathSegments.last;
          final destPath = '$outputDir/assets/screenshots/$fileName';
          final destDir = Directory('$outputDir/assets/screenshots');
          if (!await destDir.exists()) {
            await destDir.create(recursive: true);
          }
          await screenshotFile.copy(destPath);
        }
      }

      // Copy video
      if (result.videoPath != null) {
        final videoFile = File(result.videoPath!);
        if (await videoFile.exists()) {
          final fileName = videoFile.uri.pathSegments.last;
          final destPath = '$outputDir/assets/videos/$fileName';
          final destDir = Directory('$outputDir/assets/videos');
          if (!await destDir.exists()) {
            await destDir.create(recursive: true);
          }
          await videoFile.copy(destPath);
        }
      }

      // Copy trace
      if (result.tracePath != null) {
        final traceFile = File(result.tracePath!);
        if (await traceFile.exists()) {
          final fileName = traceFile.uri.pathSegments.last;
          final destPath = '$outputDir/assets/traces/$fileName';
          final destDir = Directory('$outputDir/assets/traces');
          if (!await destDir.exists()) {
            await destDir.create(recursive: true);
          }
          await traceFile.copy(destPath);
        }
      }

      // Copy attachments
      for (final attachment in result.attachments) {
        final attachmentFile = File(attachment.path);
        if (await attachmentFile.exists()) {
          final fileName = attachmentFile.uri.pathSegments.last;
          final destPath = '$outputDir/assets/attachments/$fileName';
          final destDir = Directory('$outputDir/assets/attachments');
          if (!await destDir.exists()) {
            await destDir.create(recursive: true);
          }
          await attachmentFile.copy(destPath);
        }
      }
    }
  }

  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  String _formatDuration(int milliseconds) {
    if (milliseconds < 1000) {
      return '${milliseconds}ms';
    }
    final seconds = (milliseconds / 1000).toStringAsFixed(2);
    return '${seconds}s';
  }

  /// Clears all test results.
  void clear() {
    _results.clear();
  }
}

/// Report metadata.
class ReportMetadata {
  String title;
  String projectName;
  DateTime? startTime;
  Map<String, dynamic> environment;

  ReportMetadata({
    this.title = 'Playwright Dart Test Report',
    this.projectName = 'Default Project',
    this.startTime,
    Map<String, dynamic>? environment,
  }) : environment =
           environment ??
           {
             'platform': Platform.operatingSystem,
             'dartVersion': Platform.version,
           };

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'projectName': projectName,
      'startTime': startTime?.toIso8601String(),
      'environment': environment,
    };
  }
}

/// Represents a test result with comprehensive information.
class TestResult {
  final String name;
  final String file;
  final TestStatus status;
  final int duration;
  final String? error;
  final String? stackTrace;
  final String? screenshotPath;
  final String? videoPath;
  final String? tracePath;
  final List<TestStep> steps;
  final List<TestAttachment> attachments;
  final int retryCount;
  final Map<String, dynamic> metadata;

  TestResult({
    required this.name,
    required this.file,
    required this.status,
    required this.duration,
    this.error,
    this.stackTrace,
    this.screenshotPath,
    this.videoPath,
    this.tracePath,
    this.steps = const [],
    this.attachments = const [],
    this.retryCount = 0,
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'file': file,
      'status': status.name,
      'duration': duration,
      'error': error,
      'stackTrace': stackTrace,
      'screenshotPath': screenshotPath,
      'videoPath': videoPath,
      'tracePath': tracePath,
      'steps': steps.map((s) => s.toJson()).toList(),
      'attachments': attachments.map((a) => a.toJson()).toList(),
      'retryCount': retryCount,
      'metadata': metadata,
    };
  }

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      name: json['name'] as String,
      file: json['file'] as String,
      status: TestStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => TestStatus.skipped,
      ),
      duration: json['duration'] as int,
      error: json['error'] as String?,
      stackTrace: json['stackTrace'] as String?,
      screenshotPath: json['screenshotPath'] as String?,
      videoPath: json['videoPath'] as String?,
      tracePath: json['tracePath'] as String?,
      steps:
          (json['steps'] as List?)
              ?.map((s) => TestStep.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
      attachments:
          (json['attachments'] as List?)
              ?.map((a) => TestAttachment.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      retryCount: json['retryCount'] as int? ?? 0,
      metadata: (json['metadata'] as Map<String, dynamic>?) ?? {},
    );
  }
}

/// Test step information.
class TestStep {
  final String title;
  final int duration;
  final String status;
  final String? error;

  TestStep({
    required this.title,
    required this.duration,
    this.status = 'passed',
    this.error,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'duration': duration,
      'status': status,
      'error': error,
    };
  }

  factory TestStep.fromJson(Map<String, dynamic> json) {
    return TestStep(
      title: json['title'] as String,
      duration: json['duration'] as int,
      status: json['status'] as String? ?? 'passed',
      error: json['error'] as String?,
    );
  }
}

/// Test attachment information.
class TestAttachment {
  final String name;
  final String path;
  final String contentType;

  TestAttachment({
    required this.name,
    required this.path,
    required this.contentType,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'path': path, 'contentType': contentType};
  }

  factory TestAttachment.fromJson(Map<String, dynamic> json) {
    return TestAttachment(
      name: json['name'] as String,
      path: json['path'] as String,
      contentType: json['contentType'] as String,
    );
  }
}

/// Test status enum.
enum TestStatus { passed, failed, skipped, timedOut, interrupted }
