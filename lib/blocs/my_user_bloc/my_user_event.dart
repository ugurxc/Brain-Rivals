part of 'my_user_bloc.dart';

abstract class MyUserEvent extends Equatable {
  const MyUserEvent();

  @override
  List<Object> get props => [];
}

class GetMyUser extends MyUserEvent{
  final String myUserId;

  const GetMyUser( {required this.myUserId});

  @override
  List<Object> get props=> [myUserId];

}
class LogoutUser extends MyUserEvent{}

class UpdateUserPicture extends MyUserEvent {
  final String userId;
  final String newPicture;

  const UpdateUserPicture({required this.userId, required this.newPicture});

  @override
  List<Object> get props => [userId, newPicture];
}