class UpdateProductsResponse {
  UpdateProductsResponse({
    required this.data,
  });

  late final Data data;

  UpdateProductsResponse.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.urlImage,
    required this.qty,
    required this.createdBy,
    required this.updateBy,
    required this.createdate,
    required this.updatedate,
  });

  late final int id;
  late final int categoryId;
  late final String name;
  late final String urlImage;
  late final int qty;
  late final String createdBy;
  late final String updateBy;
  late final String createdate;
  late final String updatedate;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    urlImage = json['url_image'];
    qty = json['qty'];
    createdBy = json['created_by'];
    updateBy = json['update_by'];
    createdate = json['createdate'];
    updatedate = json['updatedate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_id'] = categoryId;
    _data['name'] = name;
    _data['url_image'] = urlImage;
    _data['qty'] = qty;
    _data['created_by'] = createdBy;
    _data['update_by'] = updateBy;
    _data['createdate'] = createdate;
    _data['updatedate'] = updatedate;
    return _data;
  }
}
