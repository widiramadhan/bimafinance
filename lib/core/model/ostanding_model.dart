class OstandingModel {
  String? nikKtp;
  int? total;

  OstandingModel({this.nikKtp, this.total});

  OstandingModel.fromJson(Map<String, dynamic> json) {
    nikKtp = json['nik_ktp'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nik_ktp'] = this.nikKtp;
    data['total'] = this.total;
    return data;
  }
}