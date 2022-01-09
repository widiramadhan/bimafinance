class ContractModel {
  String? appNo;
  int? statusId;
  String? statusName;
  String? nik;
  String? dob;
  String? gender;
  String? address;
  String? province;
  String? city;
  String? subDistrict;
  String? postalCode;
  String? phoneNumber;
  String? motherName;
  String? emergencyContact;
  String? companyName;
  String? companyPhoneNumber;
  int? jobId;
  String? jobName;
  int? sallaryId;
  String? sallaryTitle;
  int? productId;
  String? productName;
  int? amount;
  int? tenor;
  int? downPayment;
  int? interestPerMonth;
  int? totalInterest;
  int? totalDebt;
  int? instalment;
  String? createdDate;


  ContractModel({this.appNo,
    this.statusId,
    this.statusName,
    this.nik,
    this.dob,
    this.gender,
    this.address,
    this.province,
    this.city,
    this.subDistrict,
    this.postalCode,
    this.phoneNumber,
    this.motherName,
    this.emergencyContact,
    this.companyName,
    this.companyPhoneNumber,
    this.jobId,
    this.jobName,
    this.sallaryId,
    this.sallaryTitle,
    this.productId,
    this.productName,
    this.amount,
    this.tenor,
    this.downPayment,
    this.interestPerMonth,
    this.totalInterest,
    this.totalDebt,
    this.instalment,
    this.createdDate});

  ContractModel.fromJson(Map<String, dynamic> json) {
    appNo = json['app_no'];
    statusId = json['status_id'];
    statusName = json['status_name'];
    nik = json['nik'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    province = json['province'];
    city = json['city'];
    subDistrict = json['sub_district'];
    postalCode = json['postal_code'];
    phoneNumber = json['phone_number'];
    motherName = json['mother_name'];
    emergencyContact = json['emergency_contact'];
    companyName = json['company_name'];
    companyPhoneNumber = json['company_phone_number'];
    jobId = json['job_id'];
    jobName = json['job_name'];
    sallaryId = json['sallary_id'];
    sallaryTitle = json['sallary_title'];
    productId = json['product_id'];
    productName = json['product_name'];
    amount = json['amount'];
    tenor = json['tenor'];
    downPayment = json['down_payment'];
    interestPerMonth = json['interest_per_month'];
    totalInterest = json['total_interest'];
    totalDebt = json['total_debt'];
    instalment = json['instalment'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_no'] = this.appNo;
    data['status_id'] = this.statusId;
    data['status_name'] = this.statusName;
    data['nik'] = this.nik;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['province'] = this.province;
    data['city'] = this.city;
    data['sub_district'] = this.subDistrict;
    data['postal_code'] = this.postalCode;
    data['phone_number'] = this.phoneNumber;
    data['mother_name'] = this.motherName;
    data['emergency_contact'] = this.emergencyContact;
    data['company_name'] = this.companyName;
    data['company_phone_number'] = this.companyPhoneNumber;
    data['job_id'] = this.jobId;
    data['job_name'] = this.jobName;
    data['sallary_id'] = this.sallaryId;
    data['sallary_title'] = this.sallaryTitle;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['amount'] = this.amount;
    data['tenor'] = this.tenor;
    data['down_payment'] = this.downPayment;
    data['interest_per_month'] = this.interestPerMonth;
    data['total_interest'] = this.totalInterest;
    data['total_debt'] = this.totalDebt;
    data['instalment'] = this.instalment;
    data['created_date'] = this.createdDate;
    return data;
  }
}
