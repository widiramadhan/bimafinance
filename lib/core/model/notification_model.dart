class NotificationModel {
  int? notification_id;
  String? notification_title;
  String? notification_description;
  String? created_date;
  String? created_time;
  String? notification_images;
  int? notification_read;


  NotificationModel({
      this.notification_id,
      this.notification_title,
      this.notification_description,
      this.created_date,
      this.created_time,
      this.notification_read,
      this.notification_images,});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notification_id = json['notification_id'];
    notification_title = json['notification_title'];
    notification_description = json['notification_description'];
    created_date = json['created_date'];
    created_time = json['created_time'];
    notification_images = json['notification_images'];
    notification_read = json['notification_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic> ();
    data['notification_id'] = this.notification_id;
    data['notification_title'] = this.notification_title;
    data['notification_description'] = this.notification_description;
    data['created_date'] = this.created_date;
    data['created_time'] = this.created_time;
    data['notification_images'] = this.notification_images;
    data['notification_read'] = this.notification_read;
    return data;
  }
}
