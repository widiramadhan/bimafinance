class PromoModel {
  int? promo_id;
  String? promo_title;
  String? promo_description;
  String? created_date;
  String? promo_images;


  PromoModel({
      this.promo_id,
      this.promo_title,
      this.promo_description,
      this.created_date,
      this.promo_images,});

  PromoModel.fromJson(Map<String, dynamic> json) {
    promo_id = json['promo_id'];
    promo_title = json['promo_title'];
    promo_description = json['promo_description'];
    created_date = json['created_date'];
    promo_images = json['promo_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promo_id'] = this.promo_id;
    data['promo_title'] = this.promo_title;
    data['promo_description'] = this.promo_description;
    data['created_date'] = this.created_date;
    data['promo_images'] = this.promo_images;
    return data;
  }
}
