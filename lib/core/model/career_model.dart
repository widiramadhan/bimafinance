class CareerModel {
  int? career_id;
  String? career_title;
  String? career_description;
  String? created_date;


  CareerModel({
      this.career_id,
      this.career_title,
      this.career_description,
      this.created_date});

  CareerModel.fromJson(Map<String, dynamic> json) {
    career_id = json['career_id'];
    career_title = json['career_title'];
    career_description = json['career_description'];
    created_date = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['career_id'] = this.career_id;
    data['career_title'] = this.career_title;
    data['career_description'] = this.career_description;
    data['created_date'] = this.created_date;
    return data;
  }
}
