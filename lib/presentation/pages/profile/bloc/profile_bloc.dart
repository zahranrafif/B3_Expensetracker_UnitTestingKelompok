import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/domain/models/user/user_model.dart';
import 'package:expensetracker/domain/repositories/user/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    final userRepository = UserRepository();

    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetDataProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final response = await userRepository.get();

        var user = UserModel(
          id: '', 
          uid: '', 
          name: '', 
          email: '', 
          balance: 0
        );
        if(response != null){
          user = UserModel(id: response.id, uid: response.uid, name: response.name, email: response.email, balance: response.balance);
        }
          
        emit(ProfileLoaded(data: user));
      } catch (e) {
        emit(ProfileError(error: e.toString()));
      }
    });
  }
}
