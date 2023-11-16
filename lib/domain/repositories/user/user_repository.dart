import 'package:expensetracker/domain/interactors/firebase/user/user_interactor.dart';
import 'package:expensetracker/domain/models/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository{
  final UserInteractor userInteractor = UserInteractor();

  Future<UserModel?> get() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await userInteractor.get(prefs.getString('uid')!, prefs.getString('email'));
  }
}