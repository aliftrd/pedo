import 'package:flutter/material.dart';
import 'package:pedo/views/widgets/text_field_container.dart';
import 'package:pedo/constant/themes.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    goToLogin() {
      Navigator.pushReplacementNamed(context, '/login');
    }

    registerHandle() {
      return goToLogin();
    }

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 250,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cat_register.gif'),
              ),
            ),
          ),
          Text(
            "Bergabunglah di PEDO!",
            style: primaryTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 20,
            ),
          ),
          Text(
            "Ayo bergabung, banyak hewan lucu menunggumu!",
            style: subTitleTextStyle.copyWith(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget nameInput() {
      return TextInputContainer(
        icons: Icon(Icons.person, color: primaryColor),
        label: "Nama",
        textFormField: TextFormField(
          style: primaryTextStyle,
          decoration: InputDecoration.collapsed(
            hintText: "Masukkan nama",
            hintStyle: hintTextStyle,
          ),
        ),
      );
    }

    Widget emailInput() {
      return TextInputContainer(
        margin: const EdgeInsets.only(top: 15),
        icons: Icon(Icons.email, color: primaryColor),
        label: "E-mail",
        textFormField: TextFormField(
          style: primaryTextStyle,
          decoration: InputDecoration.collapsed(
            hintText: "E-mail",
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
          obscureText: true,
          style: primaryTextStyle,
          decoration: InputDecoration.collapsed(
            hintText: "Password",
            hintStyle: hintTextStyle,
          ),
        ),
      );
    }

    Widget signUpButton() {
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
          onPressed: registerHandle,
          child: Text(
            "Daftar",
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
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: width,
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              children: [
                header(),
                nameInput(),
                emailInput(),
                passwordInput(),
                signUpButton(),
                GestureDetector(
                  onTap: goToLogin,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text.rich(
                      TextSpan(
                        text: "Sudah punya akun? ",
                        style: subTitleTextStyle.copyWith(
                          color: darkColor,
                        ),
                        children: [
                          TextSpan(
                            text: "Masuk",
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
