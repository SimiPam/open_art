class ApiResponse<T> {
  ApiResponse({
    this.error = false,
    this.message,
    this.data,
  });

  bool error;
  String message;
  T data;
}
