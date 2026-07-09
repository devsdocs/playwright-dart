enum BrowserPermission {
  accelerometer('accelerometer'),
  ambientLightSensor('ambient-light-sensor'),
  backgroundSync('background-sync'),
  camera('camera'),
  clipboardRead('clipboard-read'),
  clipboardWrite('clipboard-write'),
  geolocation('geolocation'),
  gyroscope('gyroscope'),
  localFonts('local-fonts'),
  localNetworkAccess('local-network-access'),
  magnetometer('magnetometer'),
  microphone('microphone'),
  midiSysex('midi-sysex'),
  midi('midi'),
  notifications('notifications'),
  paymentHandler('payment-handler'),
  storageAccess('storage-access'),
  screenWakeLock('screen-wake-lock');

  final String value;
  const BrowserPermission(this.value);
}
