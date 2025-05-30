import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:user_repository/user_repository.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
  final UserRepository _userRepository;
  MyUserBloc({
    required UserRepository myUserRepository
  }) :_userRepository=myUserRepository,
   super(const MyUserState.loading()) {
    on<GetMyUser>((event, emit) async {
      
      try {
        MyUser myUser = await _userRepository.getMyUser(event.myUserId);
        emit(MyUserState.succsess(myUser));
      } catch (e) {
        log(e.toString());
        emit(const MyUserState.failure());
      }
    });
     on<LogoutUser>((event, emit) {
      emit(const MyUserState.loading());  // State'i temizleyip sıfırla
    });on<UpdateUserPicture>((event, emit) async {
  emit(const MyUserState.loading());
  try {
    // Firestore'da avatar bilgisini güncelle
    await _userRepository.updateUserPicture(event.userId, event.newPicture);

    // Kullanıcıyı yeniden yükle
    MyUser updatedUser = await _userRepository.getMyUser(event.userId);
    emit(MyUserState.succsess(updatedUser));
  } catch (e) {
    log(e.toString());
    emit(const MyUserState.failure());
  }
});

  
  }
}
