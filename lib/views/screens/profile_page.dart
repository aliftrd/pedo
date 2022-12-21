import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/controller/image_controller.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/utils/ensure.dart';
import 'package:pedo/views/widgets/loading_button.dart';
import 'package:pedo/views/widgets/input_container.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static String route = '/profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController(),
      _confirmPasswordController = TextEditingController();
  File? profile;
  bool isLoading = false, validator = false;
  Map<String, dynamic> validatorMessage = {
    'confirm_password': '',
  };

  @override
  void dispose() {
    _nameController;
    _confirmPasswordController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ImageController imageController = Provider.of<ImageController>(context);

    void updateProfileHandle() async {
      setState(() {
        isLoading = true;
        validator = false;
        validatorMessage['confirm_password'] = '';
      });

      String confirmPassword = _confirmPasswordController.text;
      if (confirmPassword.isEmpty) {
        setState(() {
          validator = true;
          validatorMessage['confirm_password'] =
              'Konfirmasi password tidak boleh kosong';
          isLoading = false;
        });
      }

      if (!validator) {
        var response = await authProvider.updateProfile(
          name: _nameController.text,
          image: profile,
          passwordConfirmation: _confirmPasswordController.text,
        );

        if (response['code'] == 200) {
          Navigator.pop(context);
        } else {
          setState(() {
            validator = true;
            validatorMessage['confirm_password'] = response['message'];
            isLoading = false;
          });
        }
      }
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: background,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Profile',
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
                    imageController.removeImage();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorDark,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: (profile != null)
                                  ? Image.file(
                                      profile!,
                                      height: 125,
                                      width: 125,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      authProvider.getUser!.image,
                                      height: 125,
                                      width: 125,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 0,
                              child: InkWell(
                                onTap: () async {
                                  await imageController.pickImage();
                                  if (imageController.pickedImage != null) {
                                    setState(() {
                                      profile = imageController.takeImage();
                                    });
                                  }
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: colorPrimary,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: colorDark,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Informasi Akun',
                          style: primaryTextStyle.copyWith(fontSize: 16),
                        ),
                      ]),
                    ),
                    InputContainer(
                      icons: Icon(Icons.email, color: colorPrimary),
                      label: "Nama",
                      widget: TextFormField(
                        controller: _nameController
                          ..text = _nameController.text != ''
                              ? _nameController.text
                              : authProvider.getUser!.name,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: "Masukkan nama",
                          hintStyle: hintTextStyle,
                        ),
                      ),
                    ),
                    InputContainer(
                      icons: Icon(Icons.email, color: colorPrimary),
                      backgroundInputColor: disableBackgroundInput,
                      label: "E-mail",
                      widget: TextFormField(
                        enabled: false,
                        initialValue: EnsureSafe.safeEmail(
                          authProvider.getUser!.email,
                        ),
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: "Masukkan email",
                          hintStyle: hintTextStyle,
                        ),
                      ),
                    ),
                    InputContainer(
                      icons: Icon(Icons.email, color: colorPrimary),
                      label: "Konfirmasi Password",
                      widget: TextFormField(
                        obscureText: true,
                        style: primaryTextStyle,
                        controller: _confirmPasswordController,
                        decoration: InputDecoration.collapsed(
                          hintText: "Konfirmasi Password",
                          hintStyle: hintTextStyle,
                        ),
                      ),
                    ),
                    validator && validatorMessage['confirm_password'] != ''
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              validatorMessage['confirm_password'],
                              style:
                                  primaryTextStyle.copyWith(color: colorDanger),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: isLoading
            ? LoadingButton()
            : Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: updateProfileHandle,
                  child: Text(
                    "Simpan",
                    style: primaryTextStyle.copyWith(
                      color: colorDark,
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
