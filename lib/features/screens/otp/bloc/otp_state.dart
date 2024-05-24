part of 'otp_bloc.dart';

class OtpState extends Equatable {
  final StateStatus stateStatus;
  final String otp;

  const OtpState(this.stateStatus, this.otp);

  static OtpState initial() => const OtpState(StateStatus.loading, '');

  OtpState copyWith({StateStatus? stateStatus, String? otp}) =>
      OtpState(stateStatus ?? this.stateStatus, otp ?? this.otp);

  @override
  List<Object?> get props => [stateStatus,otp];
}
