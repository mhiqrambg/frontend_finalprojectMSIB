class DeleteProductResponse {
  DeleteProductResponse({
    required this.message,
  });
  late final String message;

  DeleteProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    return _data;
  }
}
