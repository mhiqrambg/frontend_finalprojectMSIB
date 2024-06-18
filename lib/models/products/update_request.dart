class UpdateProductRequest {
  UpdateProductRequest({
    required this.categoryId,
    required this.name,
    required this.urlImage,
    required this.qty,
    required this.updateBy,
  });

  late final int categoryId;
  late final String name;
  late final String urlImage;
  late final int qty;
  late final String updateBy;

  UpdateProductRequest.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    urlImage = json['url_image'];
    qty = json['qty'];
    updateBy = json['update_by'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category_id'] = categoryId;
    _data['name'] = name;
    _data['url_image'] = urlImage;
    _data['qty'] = qty;
    _data['update_by'] = updateBy;
    return _data;
  }
}
