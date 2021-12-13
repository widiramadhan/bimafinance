class ProductModel {
  int? product_id;
  String? product_name;
  String? product_description;
  String? product_thumbnail;
  String? product_banner;


  ProductModel({
      this.product_id,
      this.product_name,
      this.product_description,
      this.product_thumbnail,
      this.product_banner,});

  ProductModel.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    product_name = json['product_name'];
    product_description = json['product_description'];
    product_thumbnail = json['product_thumbnail'];
    product_banner = json['product_banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['product_name'] = this.product_name;
    data['product_description'] = this.product_description;
    data['product_thumbnail'] = this.product_thumbnail;
    data['product_banner'] = this.product_banner;
    return data;
  }
}
