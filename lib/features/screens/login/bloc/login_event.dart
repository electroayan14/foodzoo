part of 'login_bloc.dart';

//ignore:must_be_immutable
class LoginEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//ignore:must_be_immutable
class CredentialValidateEvent extends LoginEvent {
  String? userName;
  String? password;
  String? mobileNo;

  CredentialValidateEvent(this.userName, this.password, this.mobileNo);
}
