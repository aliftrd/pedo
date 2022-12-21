import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/views/screens/pet/pet_detail.dart';

class PetList extends StatefulWidget {
  const PetList({super.key});
  static String route = '/petList';

  @override
  State<PetList> createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              backgroundColor: background,
              elevation: 0,
              title: Text(
                'Pet List',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: defaultMargin),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorDark,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: defaultMargin),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_alt,
                      color: colorDark,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                margin: const EdgeInsets.only(bottom: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    crossAxisSpacing: 20,
                    childAspectRatio: 3 / 4.35,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: 7,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetDetail(),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                'assets/images/kucing.png',
                                width: 129,
                                height: 129,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: subtitleTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Rp 350.000',
                              maxLines: 1,
                              style: primaryTextStyle.copyWith(
                                fontWeight: semibold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: colorSubtitle,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Jember',
                                  style: subtitleTextStyle.copyWith(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
