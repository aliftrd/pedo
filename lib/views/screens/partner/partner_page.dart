import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/partner_provider.dart';
import 'package:pedo/views/screens/partner/partner_post_page.dart';
import 'package:pedo/views/widgets/errors.dart';
import 'package:pedo/views/widgets/partner_animal_card.dart';
import 'package:pedo/views/widgets/partner_animal_skeleton_card.dart';
import 'package:provider/provider.dart';

class PartnerPage extends StatefulWidget {
  const PartnerPage({super.key});

  @override
  State<PartnerPage> createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  ScrollController scrollController = ScrollController();
  int selectedItem = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      onScrollEvent();
      fetchData(isRefresh: true);
    });
  }

  void onScrollEvent() {
    PartnerProvider partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (partnerProvider.animals.isNotEmpty &&
            partnerProvider.isLastPage != true) {
          partnerProvider.getPartnerAnimal(
              status: tabItems[selectedItem]['value']);
        }
      }
    });
  }

  fetchData({bool isRefresh = false}) async {
    PartnerProvider partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    await partnerProvider.getPartnerAnimal(
      isRefresh: isRefresh,
      status: tabItems[selectedItem]['value'],
    );
  }

  @override
  Widget build(BuildContext context) {
    PartnerProvider partnerProvider = Provider.of<PartnerProvider>(context);

    Widget buildAnimalPartnerList() {
      return SliverToBoxAdapter(
        child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, index) => const SizedBox(height: 20),
            itemCount: partnerProvider.animals.length,
            itemBuilder: (context, index) => PartnerAnimalCard(
                  status: tabItems[selectedItem]['value'],
                  animalId: partnerProvider.animals[index].id,
                  margin: EdgeInsets.only(
                    top: partnerProvider.animals.first ==
                            partnerProvider.animals[index]
                        ? defaultMargin
                        : 0,
                    bottom: partnerProvider.animals.last ==
                            partnerProvider.animals[index]
                        ? defaultMargin
                        : 0,
                    left: defaultMargin,
                    right: defaultMargin,
                  ),
                )),
      );
    }

    return Scaffold(
      backgroundColor: background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, PartnerPostPage.route),
        backgroundColor: colorPrimary,
        elevation: 0,
        highlightElevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => fetchData(isRefresh: true),
          child: CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                centerTitle: true,
                floating: true,
                backgroundColor: background,
                elevation: 0,
                title: Text(
                  'Kemitraan Saya',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    SizedBox(width: defaultMargin),
                    ...tabItems
                        .map(
                          (tabItem) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedItem = tabItem['id'];
                              });
                              fetchData(isRefresh: true);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: selectedItem == tabItems.indexOf(tabItem)
                                    ? colorHint
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                tabItem['title'],
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                  color:
                                      selectedItem == tabItems.indexOf(tabItem)
                                          ? colorLight
                                          : colorDark,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    SizedBox(width: defaultMargin),
                  ]),
                ),
              ),
              partnerProvider.isLoading && partnerProvider.animals.isEmpty
                  ? SliverToBoxAdapter(
                      child: Column(
                        children: List.generate(
                          3,
                          (index) => PartnerAnimalSkeletonCard(
                            margin: EdgeInsets.only(
                              top: index.bitLength == 0 ? defaultMargin : 0,
                              bottom: index.bitLength == 2 ? defaultMargin : 10,
                              left: defaultMargin,
                              right: defaultMargin,
                            ),
                          ),
                        ),
                      ),
                    )
                  : partnerProvider.animals.isEmpty
                      ? SliverFillRemaining(
                          child: Errors.noDataFound(),
                        )
                      : buildAnimalPartnerList(),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> tabItems = [
  {
    'id': 0,
    'value': 'pending',
    'title': 'Pending',
  },
  {
    'id': 1,
    'value': 'accepted',
    'title': 'Diterbitkan',
  },
  {
    'id': 2,
    'value': 'adopted',
    'title': 'Teradopsi',
  },
  {
    'id': 3,
    'value': 'rejected',
    'title': 'Ditolak',
  },
];
