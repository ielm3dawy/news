import 'package:flutter/material.dart';
import 'package:news/models/category_data.dart';
import 'package:intl/intl.dart';

class CategoryItemWidget extends StatelessWidget {
  final int index;
  final CategoryData categoryData;
  final void Function(CategoryData) onCategoryClicked;

  const CategoryItemWidget({
    super.key,
    required this.index,
    required this.categoryData,
    required this.onCategoryClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCategoryClicked(categoryData);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: categoryData.categoryBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
            bottomLeft: index % 2 == 0
                ? const Radius.circular(25)
                : const Radius.circular(0),
            bottomRight: index % 2 == 0
                ? const Radius.circular(0)
                : const Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(categoryData.categoryImage),
            ),
            Text(
              Intl.message(categoryData.categoryName),
              style: const TextStyle(
                fontFamily: "Exo",
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}