import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensetracker/config/color.dart';
import 'package:expensetracker/config/style.dart';
import 'package:expensetracker/presentation/pages/auth/bloc/auth_bloc.dart';
import 'package:expensetracker/presentation/pages/auth/login_page.dart';
import 'package:expensetracker/presentation/pages/profile/bloc/profile_bloc.dart';
import 'package:expensetracker/presentation/widgets/profile_pics/profile_pic.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profileBloc = ProfileBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileBloc..add(GetDataProfile()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainLightBlue,
          title: const Text(''),
          actions: [
            IconButton(
              tooltip: 'Logout',
              icon:
                  const Icon(Icons.logout_rounded, color: mainBackgroundWhite),
              onPressed: () {
                showLogoutDialog(context);
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [mainLightBlue, mainDarkBlue]
                )
              )
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if(state is ProfileLoaded){
                  return _profileView(state.data.name, state.data.email);
                }else{
                  return _profileView('-', '-');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _profileView(String firstName, String email){
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 80,
                  child: ProfilePic(
                    backgroundColor: mainDarkBlue,
                    firstName: firstName,
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  firstName,
                  style: displayProfileNameStyle,
                ),
                const SizedBox(height: 15),
                Text(email, style: displayProfileEmailStyle,),
                const SizedBox(height: 15)
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const[
                Text('ExpenseTracker ©2023', style: displayFooterStyle,),
                Text('by Abdil Tegar Arifin', style: displayFooterStyle,),
              ],
            )
          )
        ],
      ),
    );
  }
}

showLogoutDialog(BuildContext context) {
  final AuthBloc authBloc = AuthBloc();

  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Batalkan"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Logout", style: TextStyle(color: Colors.red),),
    onPressed: () {
      authBloc.add(AuthLogout());
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Apakah anda yakin?"),
    content: const Text("Sesi login anda akan diakhiri"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => authBloc,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthLogoutLoaded) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return alert;
            },
          ),
        ),
      );
    },
  );
}
