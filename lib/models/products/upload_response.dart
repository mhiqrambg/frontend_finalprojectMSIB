class UploadResponse {
  UploadResponse({
    required this.data,
  });

  late final Data data;

  UploadResponse.fromJson(Map<String, dynamic> json) {
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
    required this.createdate,
    required this.updatedate,
    required this.id,
    required this.name,
    required this.qty,
    required this.categoryId,
    required this.urlImage,
    required this.createdBy,
    this.updateBy,
  });

  late final String createdate;
  late final String updatedate;
  late final int id;
  late final String name;
  late final int qty;
  late final int categoryId;
  late final String urlImage;
  late final String createdBy;
  late final Null updateBy;

  Data.fromJson(Map<String, dynamic> json) {
    createdate = json['createdate'];
    updatedate = json['updatedate'];
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    categoryId = json['category_id'];
    urlImage = json['url_image'];
    createdBy = json['created_by'];
    updateBy = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdate'] = createdate;
    _data['updatedate'] = updatedate;
    _data['id'] = id;
    _data['name'] = name;
    _data['qty'] = qty;
    _data['category_id'] = categoryId;
    _data['url_image'] = urlImage;
    _data['created_by'] = createdBy;
    _data['update_by'] = updateBy;
    return _data;
  }
}
