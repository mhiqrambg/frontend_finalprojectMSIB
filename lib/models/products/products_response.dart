class ProductsResponse {
  late final List<Result> result;

  ProductsResponse({
    required this.result,
  });

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    result = List.from(json['result']).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Result {
  final int id;
  final int categoryId;
  final String name;
  final String urlImage;
  final int qty;

  Result({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.urlImage,
    required this.qty,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      urlImage: json['url_image'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'url_image': urlImage,
      'qty': qty,
    };
  }
}
