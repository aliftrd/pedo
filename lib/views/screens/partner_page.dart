import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/views/widgets/custom_appbar.dart';
import 'package:pedo/views/widgets/custom_tab_view.dart';

class PartnerPage extends StatefulWidget {
  @override
  State<PartnerPage> createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  int selectedTab = 0;
  String selectedItem = 'Pending';

  List<Map<String, dynamic>> tabItems = [
    {
      'id': 0,
      'status': 'Pending',
    },
    {
      'id': 1,
      'status': 'Diterbitkan',
    },
    {
      'id': 2,
      'status': 'Teradopsi',
    },
    {
      'id': 3,
      'status': 'Ditolak',
    },
    {
      'id': 4,
      'status': 'Diarsipkan',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            CustomAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: defaultMargin),
                child: Column(
                  children: [
                    CustomTabView(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      selectedTab: selectedTab,
                      onTap: (value) {
                        setState(() {
                          selectedTab = value;
                          selectedItem = validator(value);
                        });
                        // getData();
                        pageController.animateToPage(value,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      },
                      itemCount: tabItems.length,
                      item: tabItems,
                    ),
                    Container(
                      height: 400,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 197,
                      ),
                      child: PageView.builder(
                        controller: pageController,
                        onPageChanged: (value) {
                          setState(() {
                            selectedTab = value;
                            selectedItem = validator(selectedTab);
                          });
                        },
                        itemCount: tabItems.length,
                        itemBuilder: (context, index) => Container(
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              selectedItem,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

validator(int i) {
  switch (i) {
    case 1:
      return 'Diterbitkan';
    case 2:
      return 'Teradopsi';
    case 3:
      return 'Ditolak';
    case 4:
      return 'Diarsipkan';
    default:
      return 'Pending';
  }
}
