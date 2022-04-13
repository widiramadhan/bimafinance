class UserModel {
  int? user_id;
  String? fullname;
  String? email;
  String? phone;
  String? url_images;
  String? password;
  String? user_nik;

  UserModel(this.user_id, this.fullname, this.email, this.phone, this.url_images, this.user_nik); //this.nik

  UserModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'] ?? null;
    fullname = json['fullname'] ?? "";
    email = json['email'] ?? "";
    phone = json['phone'] ?? null;
    url_images = json['url_images'] ?? null;
    user_nik = json['user_nik'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['url_images'] = this.url_images;
    data['user_nik'] = this.user_nik;
    return data;
  }
}
