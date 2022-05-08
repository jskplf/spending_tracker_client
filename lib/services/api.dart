/// This is the OCR API client
/// it has methods to connect to the fastapi endpoints of the api
Future<dynamic> getFakeRequest() async {
  /// Fake http request returns a Map after 4 seconds
  await Future.delayed(const Duration(seconds: 4));
  return {
    "status_code": 200,
    "data": ['some data...']
  };
}
