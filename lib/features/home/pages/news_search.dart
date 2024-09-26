import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/network/api_manager.dart';
import '../../../models/articles_model.dart';
import '../pages/news_detail_screen.dart';

class NewsSearchDelegate extends SearchDelegate {
  Future<List<Article>> fetchSearchResults(String query) async {
    try {
      return await ApiManager.fetchNews(query);
    } catch (e) {
      print('Error fetching search results: $e');
      return [];
    }
  }

  Future<List<Article>> fetchSuggestedArticles() async {
    try {
      return await ApiManager.fetchNews("top headlines");
    } catch (e) {
      print('Error fetching suggested articles: $e');
      return [];
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildArticleList(fetchSearchResults(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildArticleList(fetchSuggestedArticles());
  }

  Widget _buildArticleList(Future<List<Article>> articlesFuture) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Article>>(
        future: articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(Intl.message('Error fetching articles')));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text(Intl.message('No articles found')));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailScreen(article: articles[index]),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (articles[index].urlToImage != null)
                          ClipRRect(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              articles[index].urlToImage!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: Colors.white,
                                  child: Icon(Icons.broken_image,
                                      size: 60, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                articles[index].title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                articles[index].description ??
                                    Intl.message(
                                        'No Description available'),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),
                              Text(
                                articles[index].publishedAt != null
                                    ? Intl.message(
                                    'Published at: ${articles[index].publishedAt}')
                                    : Intl.message('Unknown Date'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}