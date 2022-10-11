import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/views/screens/home_page.dart';
import 'package:pedo/views/screens/page_switcher.dart';
import 'package:pedo/views/widgets/text_field_container.dart';
import 'package:pedo/constant/themes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String route = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
          TextEditingController(text: ''),
      _passwordController = TextEditingController(text: '');

  @override
  void dispose() {
    _emailController;
    _passwordController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    void signInHandle() async {
      var email = _emailController.text, password = _passwordController.text;

      var response = await authProvider.login(
        email: email,
        password: password,
      );

      if (response != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: colorDanger,
            content: Text(response),
          ),
        );

        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PageSwitcher()),
      );
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
            style: subtitleTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ],
      );
    }

    Widget emailInput() {
      return TextInputContainer(
        icons: Icon(Icons.email, color: colorPrimary),
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
        icons: Icon(Icons.lock, color: colorPrimary),
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
            backgroundColor: colorPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: signInHandle,
          child: Text(
            "Masuk",
            style: primaryTextStyle.copyWith(
              color: colorDark,
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    Widget registerButton() {
      return Container(
        width: screenWidth,
        height: 40,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/register');
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum punya akun? ',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              Text(
                'Daftar',
                style: primaryTextStyle.copyWith(
                  color: colorPrimary,
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: registerButton(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            header(),
            emailInput(),
            passwordInput(),
            signInButton(),
          ],
        ),
      ),
    );
  }
}
