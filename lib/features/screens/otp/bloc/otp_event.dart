part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//ignore:must_be_immutable
class ValidateVerifyButton extends OtpEvent {
  String? otp;

  ValidateVerifyButton(this.otp);
}
