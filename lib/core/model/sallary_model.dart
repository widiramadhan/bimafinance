class SallaryModel {
  int? sallary_id;
  String? sallary_title;


  SallaryModel({
      this.sallary_id,
      this.sallary_title,});

  SallaryModel.fromJson(Map<String, dynamic> json) {
    sallary_id = json['sallary_id'];
    sallary_title = json['sallary_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sallary_id'] = this.sallary_id;
    data['sallary_title'] = this.sallary_title;
    return data;
  }
}
