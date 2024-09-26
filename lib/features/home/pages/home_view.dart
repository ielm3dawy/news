import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/category_data.dart';
import '../widgets/category_item_widget.dart';
import '../widgets/custome_drawer.dart';
import '../widgets/selected_category_view.dart';
import '../pages/news_search.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<CategoryData> categoriesDataList = [
    CategoryData(
      categoryID: "sports",
      categoryName: Intl.message('Sport'),
      categoryImage: "assets/icons/sports_icn.png",
      categoryBackgroundColor: const Color(0xFFC91C22),
    ),
    CategoryData(
      categoryID: "general",
      categoryName: Intl.message('Politics'),
      categoryImage: "assets/icons/politics_icn.png",
      categoryBackgroundColor: const Color(0xFF003E90),
    ),
    CategoryData(
      categoryID: "health",
      categoryName: Intl.message('Health'),
      categoryImage: "assets/icons/health_icn.png",
      categoryBackgroundColor: const Color(0xFFED1E79),
    ),
    CategoryData(
      categoryID: "business",
      categoryName: Intl.message('Business'),
      categoryImage: "assets/icons/bussines_icn.png",
      categoryBackgroundColor: const Color(0xFFCF7E48),
    ),
    CategoryData(
      categoryID: "environment",
      categoryName: Intl.message('Environment'),
      categoryImage: "assets/icons/environment_icn.png",
      categoryBackgroundColor: const Color(0xFF4882CF),
    ),
    CategoryData(
      categoryID: "science",
      categoryName: Intl.message('Science'),
      categoryImage: "assets/icons/science_icn.png",
      categoryBackgroundColor: const Color(0xFFF2D352),
    ),
  ];

  CategoryData? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
            "assets/images/pattern.png",
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            selectedCategory == null
                ? Intl.message('News App')
                : selectedCategory!.categoryName,
          ),
          actions: [
            if (selectedCategory != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NewsSearchDelegate(),
                    );
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        drawer: CustomDrawer(
          onCategoryDrawerClicked: onCategoryDrawerClick,
        ),
        body: selectedCategory == null
            ? Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Intl.message('Pick your category \n of interest'),
                style: TextStyle(
                  fontFamily: "Exo",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F5A69),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) => CategoryItemWidget(
                    onCategoryClicked: onCategoryClick,
                    index: index,
                    categoryData: categoriesDataList[index],
                  ),
                  itemCount: categoriesDataList.length,
                ),
              ),
            ],
          ),
        )
            : SelectedCategoryView(
          categoryData: selectedCategory!,
        ),
      ),
    );
  }

  void onCategoryClick(CategoryData data) {
    setState(() {
      selectedCategory = data;
    });
  }

  void onCategoryDrawerClick() {
    setState(() {
      selectedCategory = null;
    });
    Navigator.pop(context);
  }
}