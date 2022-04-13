class CreditModel {
  int? product_id;
  String? product_name;
  int? loan_amount;
  int? price;
  int? tenor;
  int? dp;
  int? interest_per_month;
  int? total_interest;
  int? total_debt;
  int? branch_id;
  String? branch_name;
  int? instalment;
  // int? branch_id;
  // String? branch_name;
  List<DataInstalment>? data_instalment;


  CreditModel({
    this.product_id,
    this.product_name,
    this.loan_amount,
    this.price,
    this.tenor,
    this.dp,
    this.interest_per_month,
    this.total_interest,
    this.total_debt,
    this.branch_id,
    this.branch_name,
    this.instalment,
  
    this.data_instalment});

  CreditModel.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    product_name = json['product_name'];
    loan_amount = json['loan_amount'];
    price = json['price'];
    tenor = json['tenor'];
    dp = json['dp'];
    interest_per_month = json['interest_per_month'];
    total_interest = json['total_interest'];
    total_debt = json['total_debt'];
    branch_id = json['branch_id'];
    branch_name = json ['branch_name'];
    instalment = json['instalment'];
    // branch_id = json['branch_id'];
    // branch_name = json ['branch_name'];
    if (json['data_instalment'] != null) {
      data_instalment = [];
      json['data_instalment'].forEach((v) {
        data_instalment!.add(new DataInstalment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['product_name'] = this.product_name;
    data['loan_amount'] = this.loan_amount;
    data['price'] = this.price;
    data['tenor'] = this.tenor;
    data['dp'] = this.dp;
    data['interest_per_month'] = this.interest_per_month;
    data['total_interest'] = this.total_interest;
    data['total_debt'] = this.total_debt;
    data['branch_id'] = this.branch_id;
    data['branch_name'] = this.branch_name;
    data['instalment'] = this.instalment;
    // data['branch_id'] = this.branch_id;
    // data['branch_name'] = this.branch_name;
    data['data_instalment'] = this.data_instalment;
    return data;
  }
}

class DataInstalment {
  int? month;
  int? instalment;

  DataInstalment({this.month, this.instalment});

  DataInstalment.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    instalment = json['instalment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['instalment'] = this.instalment;
    return data;
  }
}
