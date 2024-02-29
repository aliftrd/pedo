import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/views/widgets/badge.dart';

class CustomTabView extends StatelessWidget {
  const CustomTabView({
    super.key,
    required this.selectedTab,
    required this.onTap,
    required this.item,
    required this.itemCount,
    this.padding,
    this.scrollController,
  });

  final int selectedTab;
  final Function(dynamic) onTap;
  final List<Map<String, dynamic>> item;
  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: padding,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          itemCount,
          (index) => InkWell(
            onTap: () => onTap(item[index]['id']),
            child: CustomBadge(
              text: item[index]['title'],
              borderColor: selectedTab == index ? colorSubtitle : null,
              textColor: selectedTab == index ? colorLight : colorSubtitle,
            ),
          ),
        ),
      ),
    );
  }
}
