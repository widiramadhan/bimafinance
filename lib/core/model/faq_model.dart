class FaqModel {
  int? faq_id;
  String? faq_name;
  String? faq_instruction;
  String? faq_logo;


  FaqModel({
      this.faq_id,
      this.faq_name,
      this.faq_instruction,
      this.faq_logo,});

  FaqModel.fromJson(Map<String, dynamic> json) {
    faq_id = json['faq_id'];
    faq_name = json['faq_name'];
    faq_instruction = json['faq_instruction'];
    faq_logo = json['faq_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faq_id'] = this.faq_id;
    data['faq_name'] = this.faq_name;
    data['faq_instruction'] = this.faq_instruction;
    data['faq_logo'] = this.faq_logo;
    return data;
  }
}
