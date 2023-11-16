import 'package:firebase_auth/firebase_auth.dart';
import 'package:expensetracker/domain/models/auth/auth_login_model.dart';
import 'package:expensetracker/domain/models/auth/auth_register_model.dart';

class AuthInteractor {

  Future<AuthLoginModel> login(String email, String password) async {

    AuthLoginModel res = AuthLoginModel(status: false, message: 'Internal Server Error', data: null);

    try{
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      res = AuthLoginModel(status: true, message: 'Login Success', data: AuthLoginData(
        uid: credential.user!.uid,
        email: credential.user!.email
      ));
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        res = AuthLoginModel(status: false, message: 'Akun belum terdaftar', data: null);
      } else if(e.code == 'wrong-password'){
        res = AuthLoginModel(status: false, message: 'Password salah', data: null);
      }
    }

    return res;

  }

  Future<AuthRegisterModel> register(String email, String password) async {
    AuthRegisterModel res = AuthRegisterModel(status: false, message: '', data: null);
    
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      res = AuthRegisterModel(status: true,message: 'Berhasil mendaftar', data: AuthRegisterData(
        uid: credential.user!.uid,
        email: credential.user!.email,
      ));
    } on FirebaseAuthException catch (e) {
      res = AuthRegisterModel(
        status: false,
        message: 'Gagal mendaftar',
        data: null
      );
    }
    
    return res;
  }

}