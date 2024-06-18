class UploadRequest {
  late final int categoryId;
  late final String name;
  late final String urlImage;
  late final int qty;
  late final String createdBy;

  UploadRequest({
    required this.categoryId,
    required this.name,
    required this.urlImage,
    required this.qty,
    required this.createdBy,
  });

  UploadRequest.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    urlImage = json['url_image'];
    qty = json['qty'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category_id'] = categoryId;
    _data['name'] = name;
    _data['url_image'] = urlImage;
    _data['qty'] = qty;
    _data['created_by'] = createdBy;
    return _data;
  }
}