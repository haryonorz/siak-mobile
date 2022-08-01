class ErrorResponse {
  ErrorResponse({
    required this.message,
  });

  String message;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        message: json["message"],
      );
}
