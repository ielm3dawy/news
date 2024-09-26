import 'package:flutter/material.dart';
import '/core/network/api_manager.dart';
import '/core/theme/colors_palette.dart';
import '/models/category_data.dart';
import '../../../models/sources_model.dart';
import 'categoryView.dart';

class SelectedCategoryView extends StatefulWidget {
  final CategoryData categoryData;

  const SelectedCategoryView({
    Key? key,
    required this.categoryData,
  }) : super(key: key);

  @override
  State<SelectedCategoryView> createState() => _SelectedCategoryViewState();
}

class _SelectedCategoryViewState extends State<SelectedCategoryView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Source>>(
      future: ApiManager.fetchSourcesList(widget.categoryData.categoryID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error fetching data: ${snapshot.error}",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorPalette.primaryColor,
            ),
          );
        }

        List<Source> sourcesList = snapshot.data ?? [];

        if (sourcesList.isEmpty) {
          return Center(
            child: Text(
              "No sources available",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return CategoryView(
          sourcesList: sourcesList,
          categoryName: widget.categoryData.categoryName,
        );
      },
    );
  }
}