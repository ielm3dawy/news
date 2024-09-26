import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/colors_palette.dart';
import '../../../models/sources_model.dart';

class TabBarItem extends StatelessWidget {
  final bool isSelected;
  final Source source;

  const TabBarItem({
    super.key,
    required this.source,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6.0),
      decoration: BoxDecoration(
        color: isSelected ? ColorPalette.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: ColorPalette.primaryColor,
        ),
      ),
      child: Text(
        source.name.isNotEmpty
            ? source.name
            : Intl.message('No Name Available'),
        style: TextStyle(
          fontFamily: "Exo",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : ColorPalette.primaryColor,
        ),
      ),
    );
  }
}