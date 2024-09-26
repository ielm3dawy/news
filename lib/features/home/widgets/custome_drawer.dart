import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/colors_palette.dart';
import '../pages/setting_screen.dart';

class CustomDrawer extends StatelessWidget {
  final void Function() onCategoryDrawerClicked;

  const CustomDrawer({
    super.key,
    required this.onCategoryDrawerClicked,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      width: mediaQuery.size.width * 0.7,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.center,
            height: mediaQuery.size.height * 0.2,
            width: double.infinity,
            color: ColorPalette.primaryColor,
            child: Text(
              Intl.message('News App !', name: 'newsAppTitle'),
              style: const TextStyle(
                  fontFamily: "Exo",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                onCategoryDrawerClicked();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.list,
                    size: 40,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    Intl.message('Categories', name: 'categories'),
                    style: const TextStyle(
                        fontFamily: "Exo",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    Intl.message('Settings', name: 'settings'),
                    style: const TextStyle(
                        fontFamily: "Exo",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}