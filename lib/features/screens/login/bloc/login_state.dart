part of 'login_bloc.dart';

class LoginState extends Equatable {
  final StateStatus stateStatus;
  final dynamic userName;
  final dynamic password;
  final dynamic mobileNo;

  const LoginState(
      this.stateStatus, this.userName, this.password, this.mobileNo);

  static LoginState initial() =>
      const LoginState(StateStatus.loading, '', '', '');

  LoginState copyWith(
          {StateStatus? stateStatus,
          dynamic userName,
          dynamic password,
          dynamic mobileNo}) =>
      LoginState(stateStatus ?? this.stateStatus, userName ?? this.userName,
          password ?? this.password, mobileNo ?? this.mobileNo);

  @override
  // TODO: implement props
  List<Object?> get props => [stateStatus, userName, password, mobileNo];
}
