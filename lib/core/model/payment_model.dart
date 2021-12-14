class PaymentModel {
  int? payment_id;
  String? payment_name;
  String? payment_instruction;
  String? payment_logo;


  PaymentModel({
      this.payment_id,
      this.payment_name,
      this.payment_instruction,
      this.payment_logo,});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    payment_id = json['payment_id'];
    payment_name = json['payment_name'];
    payment_instruction = json['payment_instruction'];
    payment_logo = json['payment_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_id'] = this.payment_id;
    data['payment_name'] = this.payment_name;
    data['payment_instruction'] = this.payment_instruction;
    data['payment_logo'] = this.payment_logo;
    return data;
  }
}
