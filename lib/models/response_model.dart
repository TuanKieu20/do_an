class ResponseModel {
  final bool isSuccess;
  final String message;
  final dynamic data;
  final dynamic subData;
  final String exception;

  ResponseModel(
      {required this.isSuccess,
      required this.message,
      this.data,
      this.subData,
      this.exception = ''});
}
