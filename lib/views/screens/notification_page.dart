import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/notification_provider.dart';
import 'package:pedo/views/widgets/errors.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  static String route = '/notification';

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Delayed to avoid error
    Future.delayed(Duration.zero, () {
      onScrollEvent();
      fetchData(isRefresh: true);
    });
  }

  void onScrollEvent() {
    NotificationProvider notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (notificationProvider.notifications.isNotEmpty &&
            notificationProvider.isLastPage != true) {
          notificationProvider.getNotifications();
        }
      }
    });
  }

  fetchData({bool isRefresh = false}) async {
    NotificationProvider notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    await notificationProvider.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider =
        Provider.of<NotificationProvider>(context);

    Widget buildCard() {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kamu mendapatkan notifikasi baru!'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(notificationProvider.notifications[index].description),
                  ],
                ),
              );
            },
            separatorBuilder: (_, index) {
              const SizedBox(
                height: 10,
              );
              return const Divider(
                thickness: 1.2,
              );
            },
            itemCount: notificationProvider.notifications.length,
          ),
        ),
      );
    }

    Widget buildSkeleton() {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: colorHint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 20,
                  decoration: BoxDecoration(
                    color: colorHint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await fetchData(isRefresh: true);
          },
          child: CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: background,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'Notifikasi',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                leading: Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: colorDark,
                    ),
                  ),
                ),
              ),
              notificationProvider.isLoading
                  ? buildSkeleton()
                  : notificationProvider.notifications.isEmpty
                      ? SliverFillRemaining(
                          child: Errors.noDataFound(),
                        )
                      : buildCard(),
            ],
          ),
        ),
      ),
    );
  }
}
