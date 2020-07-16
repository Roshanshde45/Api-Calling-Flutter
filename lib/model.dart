class NewsModel {
  String title;
  String description;
  String imageUrl;

  NewsModel({this.title, this.description, this.imageUrl});

  factory NewsModel.fromJSON(Map<String, dynamic> json) {
    return NewsModel(
      title: json["title"],
      description: json["description"],
      imageUrl: json["urlToImage"]
    );
  }
}