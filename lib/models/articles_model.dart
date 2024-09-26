class ArticlesModel {
  final String status;
  final List<Article> articles;

  ArticlesModel({
    required this.status,
    required this.articles,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
      status: json["status"] ?? '',
      articles: (json["articles"] as List)
          .map((item) => Article.fromJson(item))
          .toList(),
    );
  }
}

class Article {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String? publishedAt;

  Article({
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json["author"],
      title: json["title"] ?? 'No Title',
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"],
    );
  }

  get content => null;

  


}