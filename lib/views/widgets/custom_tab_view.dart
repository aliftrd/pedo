import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

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
    return SizedBox(
      height: 20,
      child: ListView.separated(
        controller: scrollController,
        padding: padding,
        separatorBuilder: (context, index) => Container(
          width: defaultMargin,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => onTap(item[index]['id']),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: selectedTab == index ? colorSubtitle : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  item[index]['status'],
                  style: primaryTextStyle.copyWith(
                    color: selectedTab == index ? colorLight : colorSubtitle,
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
