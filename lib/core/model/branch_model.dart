class BranchModel {
  int? branch_id;
  String? branch_name;
  String? branch_description;
  String? branch_address;
  String? branch_phone_number;
  String? branch_images;
  double? branch_latitude;
  double? branch_longitude;


  BranchModel({
      this.branch_id,
      this.branch_name,
      this.branch_description,
      this.branch_address,
      this.branch_phone_number,
      this.branch_images,
      this.branch_latitude,
      this.branch_longitude});

  BranchModel.fromJson(Map<String, dynamic> json) {
    branch_id = json['branch_id'];
    branch_name = json['branch_name'];
    branch_description = json['branch_description'];
    branch_address = json['branch_address'];
    branch_phone_number = json['branch_phone_number'];
    branch_images = json['branch_images'];
    branch_latitude = json['branch_latitude'];
    branch_longitude = json['branch_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branch_id;
    data['branch_name'] = this.branch_name;
    data['branch_description'] = this.branch_description;
    data['branch_address'] = this.branch_address;
    data['branch_phone_number'] = this.branch_phone_number;
    data['branch_images'] = this.branch_images;
    data['branch_latitude'] = this.branch_latitude;
    data['branch_longitude'] = this.branch_longitude;
    return data;
  }
}
