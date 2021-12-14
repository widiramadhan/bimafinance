class JobModel {
  int? job_id;
  String? job_name;


  JobModel({
      this.job_id,
      this.job_name,});

  JobModel.fromJson(Map<String, dynamic> json) {
    job_id = json['job_id'];
    job_name = json['job_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.job_id;
    data['job_name'] = this.job_name;
    return data;
  }
}
