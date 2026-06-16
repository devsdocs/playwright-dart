/// DOM node type hierarchy sourced from [package:html](https://pub.dev/packages/html).
///
/// `package:html` is the official Dart HTML5 parser (maintained by the Dart
/// team).  Its `dom.dart` library exposes [Node], [Element], [Document],
/// [Text], etc. — a proper W3C-compliant DOM type hierarchy that compiles on
/// every platform (VM, web, native) without depending on `dart:html`.
///
/// We re-export the most commonly needed types so that the rest of the
/// playwright-dart source only needs to import this one file:
///
/// ```dart
/// import '../infrastructure/html_node.dart';
/// ```
///
/// ## Why this matters for ElementHandle
///
/// In the TypeScript Playwright client,
/// `ElementHandle<T extends Node = Node> extends JSHandle<T>` uses the DOM
/// `Node` interface as the upper bound on the generic parameter.  We mirror
/// that using `package:html`'s [Node] class as the bound, so Dart callers get
/// the same expressive typing:
///
/// ```dart
/// // Generic element handle (default bound — any DOM node):
/// final ElementHandle<Node> handle = await page.querySelector('div');
///
/// // Narrowed to Element:
/// final ElementHandle<Element> el = handle as ElementHandle<Element>;
/// print(el.asElement()); // non-null
/// ```
library;

export 'package:html/dom.dart'
    show
        Node,
        Element,
        Document,
        DocumentFragment,
        DocumentType,
        Text,
        Comment,
        NodeList;
