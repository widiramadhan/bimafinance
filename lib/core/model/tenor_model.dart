class TenorModel {
  int? tenor_id;
  String? tenor_value;
  String? created_date;


  TenorModel({
      this.tenor_id,
      this.tenor_value,
      this.created_date,});

  TenorModel.fromJson(Map<String, dynamic> json) {
    tenor_id = json['tenor_id'];
    tenor_value = json['tenor_value'];
    created_date = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenor_id'] = this.tenor_id;
    data['tenor_value'] = this.tenor_value;
    data['created_date'] = this.created_date;
    return data;
  }
}
