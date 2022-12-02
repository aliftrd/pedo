import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/core/services/auth_service.dart';
import 'package:pedo/utils/toast.dart';
import 'package:pedo/utils/validation.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:pedo/views/widgets/loading_button.dart';
import 'package:pedo/views/widgets/text_input_container.dart';
import 'package:pedo/constant/themes.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static String route = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController(text: ''),
      _emailController = TextEditingController(text: ""),
      _passwordController = TextEditingController(text: "");

  bool isLoading = false, validator = false;
  Map<String, dynamic> validatorMessage = {
    'name': '',
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    _nameController;
    _emailController;
    _passwordController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    void registerHandle() async {
      setState(() {
        isLoading = true;
        validator = false;
        validatorMessage['name'] = '';
        validatorMessage['email'] = '';
        validatorMessage['password'] = '';
      });

      String name = _nameController.text,
          email = _emailController.text,
          password = _passwordController.text;

      if (name.isEmpty) {
        setState(() {
          isLoading = false;
          validator = true;
          validatorMessage['name'] = 'Nama tidak boleh kosong';
        });
      }

      if (email.isEmpty) {
        setState(() {
          isLoading = false;
          validator = true;
          validatorMessage['email'] = 'E-mail tidak boleh kosong';
        });
      } else if (!Validation.emailValidate(email)) {
        setState(() {
          isLoading = false;
          validator = true;
          validatorMessage['email'] = 'E-mail tidak valid';
        });
      }

      if (password.isEmpty) {
        setState(() {
          isLoading = false;
          validator = true;
          validatorMessage['password'] = 'Password tidak boleh kosong';
        });
      } else if (!Validation.passwordLength(password)) {
        setState(() {
          isLoading = false;
          validator = true;
          validatorMessage['password'] = 'Password harus lebih dari 8 karakter';
        });
      }

      if (!validator) {
        var response = await authProvider.register(name, email, password);

        if (response['code'] == 201) {
          setState(() {
            isLoading = false;
          });

          Toast.showSuccess(context, response['message']);

          Navigator.pushReplacementNamed(context, LoginPage.route);
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
            margin: const EdgeInsets.only(top: 10),
            width: 225,
            height: 225,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/register.png'),
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
            style: subtitleTextStyle.copyWith(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget nameInput() {
      return TextInputContainer(
        icons: Icon(Icons.person, color: colorPrimary),
        label: "Nama",
        textFormField: TextFormField(
          controller: _nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "NULL BANG";
            }
            return null;
          },
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
        icons: Icon(Icons.email, color: colorPrimary),
        label: "E-mail",
        textFormField: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
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
        icons: Icon(Icons.lock, color: colorPrimary),
        label: "Password",
        textFormField: TextFormField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
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
            backgroundColor: colorPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: registerHandle,
          child: Text(
            "Daftar",
            style: primaryTextStyle.copyWith(
              color: colorDark,
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    Widget signInButton() {
      return Container(
        width: screenWidth,
        height: 40,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sudah punya akun? ',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              Text(
                'Login',
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
      bottomNavigationBar: signInButton(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          physics: const BouncingScrollPhysics(),
          children: [
            header(),
            nameInput(),
            validator && validatorMessage['name'] != ''
                ? Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      validatorMessage['name'],
                      style: primaryTextStyle.copyWith(color: colorDanger),
                    ),
                  )
                : Container(),
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
            isLoading ? LoadingButton() : signUpButton(),
          ],
        ),
      ),
    );
  }
}
