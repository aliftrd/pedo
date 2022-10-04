import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pedo/views/widgets/text_field_container.dart';
import 'package:pedo/constant/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController(text: ''),
      _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    signInHandle() async {
      Navigator.pushReplacementNamed(context, '/home');
    }

    goToRegister() {
      Navigator.pushReplacementNamed(context, '/register');
    }

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 273,
            height: 273,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cat_login.gif'),
              ),
            ),
          ),
          Text(
            "Selamat datang di PEDO!",
            style: primaryTextStyle.copyWith(
              fontSize: 20,
              fontWeight: medium,
            ),
          ),
          Text(
            "Dapatkan peliharaanmu sekarang!",
            style: subTitleTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ],
      );
    }

    Widget emailInput() {
      return TextInputContainer(
        icons: Icon(Icons.email, color: primaryColor),
        label: "E-mail",
        textFormField: TextFormField(
          controller: _emailController,
          style: primaryTextStyle,
          decoration: InputDecoration.collapsed(
            hintText: "Masukkan email",
            hintStyle: hintTextStyle,
          ),
        ),
      );
    }

    Widget passwordInput() {
      return TextInputContainer(
        margin: const EdgeInsets.only(top: 15),
        icons: Icon(Icons.lock, color: primaryColor),
        label: "Password",
        textFormField: TextFormField(
          controller: _passwordController,
          style: primaryTextStyle,
          obscureText: true,
          decoration: InputDecoration.collapsed(
            hintText: "Password",
            hintStyle: hintTextStyle,
          ),
        ),
      );
    }

    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: signInHandle,
          child: Text(
            "Masuk",
            style: primaryTextStyle.copyWith(
              color: darkColor,
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColorPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: defaultMargin),
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: width,
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              children: [
                header(),
                emailInput(),
                passwordInput(),
                signInButton(),
                GestureDetector(
                  onTap: goToRegister,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text.rich(
                      TextSpan(
                        text: "Belum punya akun? ",
                        style: subTitleTextStyle.copyWith(
                          color: darkColor,
                        ),
                        children: [
                          TextSpan(
                            text: "Daftar",
                            style: primaryTextStyle.copyWith(
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
