import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/views/screens/more_page.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return SliverAppBar(
      toolbarHeight: 60,
      backgroundColor: background,
      floating: true,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                MorePage.route,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: authProvider.getUser?.image != null
                        ? Image.network(
                            authProvider.getUser!.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                        : const Text('No Image'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo,',
                        style: subtitleTextStyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        authProvider.getUser?.name != null
                            ? "${authProvider.getUser?.name.split(RegExp(r'\s+'))[0]} 👋"
                            : 'Guest',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: primaryTextStyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: colorSubtitle,
              ),
            ),
          ],
        ),
      ),
      leading: null,
    );
  }
}
