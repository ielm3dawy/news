import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/articles_model.dart';
import '../../../core/theme/colors_palette.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Intl.message('News Details')),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              Image.network(
                article.urlToImage!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                  );
                },
              ),
            const SizedBox(height: 10),
            Text(
              article.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (article.description != null && article.description!.isNotEmpty)
              Text(
                article.description!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              article.publishedAt != null
                  ? Intl.message('Published: ${article.publishedAt}')
                  : Intl.message('Publication date not available'),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            if (article.content != null && article.content!.isNotEmpty)
              Text(
                article.content!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
          ],
        ),
      ),
    );
  }
}