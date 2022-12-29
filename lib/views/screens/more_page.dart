import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/utils/ensure.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:pedo/views/screens/profile_page.dart';
import 'package:provider/provider.dart';

class MorePage extends StatelessWidget {
  static String route = '/more';

  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: background,
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
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ProfilePage.route);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(authProvider.getUser?.name != null
                                      ? authProvider.getUser!.name
                                      : 'Guest'),
                                  Text(authProvider.getUser?.email != null
                                      ? EnsureSafe.safeEmail(
                                          authProvider.getUser!.email)
                                      : 'Guest'),
                                ],
                              ),
                            ],
                          ),
                          Icon(Icons.edit, color: colorDark),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                        vertical: 15,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: colorDark),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              'Keluar',
                              style: primaryTextStyle.copyWith(
                                color: colorDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      authProvider.logout();

                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, LoginPage.route);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
