import 'package:flutter/material.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/utils/toast.dart';
import 'package:pedo/utils/validation.dart';
import 'package:pedo/views/screens/page_switcher.dart';
import 'package:pedo/views/screens/register_page.dart';
import 'package:pedo/views/widgets/loading_button.dart';
import 'package:pedo/views/widgets/text_input_container.dart';
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

  bool isLoading = false, validator = false;
  Map<String, dynamic> validatorMessage = {
    'email': '',
    'password': '',
  };

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
      setState(() {
        isLoading = true;
        validator = false;
        validatorMessage['email'] = '';
        validatorMessage['password'] = '';
      });

      String email = _emailController.text, password = _passwordController.text;

      if (email.isEmpty) {
        setState(() {
          validator = true;
          validatorMessage['email'] = 'E-mail tidak boleh kosong';
          isLoading = false;
        });
      } else if (!Validation.emailValidate(email)) {
        setState(() {
          validator = true;
          validatorMessage['email'] = 'E-mail tidak valid';
          isLoading = false;
        });
      }

      if (password.isEmpty) {
        setState(() {
          validator = true;
          validatorMessage['password'] = 'Password tidak boleh kosong';
          isLoading = false;
        });
      } else if (!Validation.passwordLength(password)) {
        setState(() {
          validator = true;
          validatorMessage['password'] = 'Password harus lebih dari 8 karakter';
          isLoading = false;
        });
      }

      if (!validator) {
        var response = await authProvider.login(email, password);

        if (response['code'] == 200) {
          setState(() {
            isLoading = false;
          });

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PageSwitcher()),
          );
        } else {
          Toast.showError(context, response['message']);

          setState(() {
            isLoading = false;
          });
        }
      }
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
                image: AssetImage('assets/images/login.png'),
                fit: BoxFit.contain,
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
            textAlign: TextAlign.center,
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
            Navigator.of(context).pushNamed(RegisterPage.route);
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
            validator && validatorMessage['email'] != ''
                ? Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      validatorMessage['email'],
                      style: primaryTextStyle.copyWith(color: colorDanger),
                    ),
                  )
                : Container(),
            passwordInput(),
            validator && validatorMessage['password'] != ''
                ? Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      validatorMessage['password'],
                      style: primaryTextStyle.copyWith(color: colorDanger),
                    ),
                  )
                : Container(),
            isLoading ? LoadingButton() : signInButton(),
          ],
        ),
      ),
    );
  }
}
