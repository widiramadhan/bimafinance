class NewsModel {
  int? news_id;
  String? news_title;
  String? news_description;
  String? created_date;
  String? news_images;


  NewsModel({
      this.news_id,
      this.news_title,
      this.news_description,
      this.created_date,
      this.news_images,});

  NewsModel.fromJson(Map<String, dynamic> json) {
    news_id = json['news_id'];
    news_title = json['news_title'];
    news_description = json['news_description'];
    created_date = json['created_date'];
    news_images = json['news_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.news_id;
    data['news_title'] = this.news_title;
    data['news_description'] = this.news_description;
    data['created_date'] = this.created_date;
    data['news_images'] = this.news_images;
    return data;
  }
}
