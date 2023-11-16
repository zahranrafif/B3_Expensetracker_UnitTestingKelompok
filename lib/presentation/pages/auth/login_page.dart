import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensetracker/config/color.dart';
import 'package:expensetracker/config/style.dart';
import 'package:expensetracker/presentation/pages/auth/bloc/auth_bloc.dart';
import 'package:expensetracker/presentation/pages/auth/register_page.dart';
import 'package:expensetracker/presentation/pages/home_page.dart';
import 'package:expensetracker/presentation/widgets/buttons/button_screen.dart';
import 'package:expensetracker/presentation/widgets/inputs/input_email.dart';
import 'package:expensetracker/presentation/widgets/inputs/input_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc _authBloc = AuthBloc();

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  final _formLoginKey = GlobalKey<FormState>();

  Widget _buildInputEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Email", style: labelStyle),
        const SizedBox(height: 10.0),
        InputEmail(
            prefixIcon: const Icon(Icons.email_outlined, color: Colors.white),
            labelText: "Masukkan email",
            style: 1,
            controller: _emailCtrl)
      ],
    );
  }

  Widget _buildInputPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Password", style: labelStyle),
        const SizedBox(height: 10.0),
        InputPassword(
            prefixIcon: const Icon(Icons.key_outlined, color: Colors.white),
            labelText: "Masukkan password",
            style: 1,
            controller: _passwordCtrl)
      ],
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const RegisterPage())),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Daftar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthLoginLoaded) {
            if (state.response.status) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            } else {
              showDialogError(state.response.message);
            }
          }
          if(state is AuthError){
            showDialogError(state.error);
          }
        },
        child: Scaffold(
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Stack(
                children: <Widget>[
                  Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [mainLightBlue, mainDarkBlue]))),
                  SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        top: 100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Image(
                            image: AssetImage("assets/img/logo4.png"),
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            "Masuk",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Form(
                            key: _formLoginKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                _buildInputEmail(),
                                const SizedBox(height: 10),
                                _buildInputPassword(),
                                const SizedBox(height: 10),
                                ButtonScreen(
                                  isLoading: (state is AuthLoginLoading) ? true : false,
                                  text: 'MASUK',
                                  action: () {
                                    if (_formLoginKey.currentState!.validate()) {
                                      _formLoginKey.currentState!.save();

                                      _authBloc.add(AuthLogin(
                                        email: _emailCtrl.text, password: _passwordCtrl.text
                                      ));
                                    } else {
                                      debugPrint("Not Validate");
                                    }
                                  }
                                ),
                              ],
                            ),
                          ),
                          _buildSignupBtn(),
                          const SizedBox(height: 40,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const[
                              Text('ExpenseTracker ©2023', style: displayFooterStyle,),
                              Text('by Abdil Tegar Arifin', style: displayFooterStyle,),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  showDialogError(String message){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Gagal'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: const Text('OK'),
            ),
          ],
        );
      }
    );
  }
}
