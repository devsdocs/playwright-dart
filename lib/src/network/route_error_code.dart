enum RouteErrorCode {
  aborted('aborted'),
  accessDenied('accessdenied'),
  addressUnreachable('addressunreachable'),
  blockedByClient('blockedbyclient'),
  blockedByResponse('blockedbyresponse'),
  connectionAborted('connectionaborted'),
  connectionClosed('connectionclosed'),
  connectionFailed('connectionfailed'),
  connectionRefused('connectionrefused'),
  connectionReset('connectionreset'),
  internetDisconnected('internetdisconnected'),
  nameNotResolved('namenotresolved'),
  timedOut('timedout'),
  failed('failed');

  final String value;
  const RouteErrorCode(this.value);
}
