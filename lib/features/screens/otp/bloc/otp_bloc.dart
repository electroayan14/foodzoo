import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodzoo/features/utils/enums/enums.dart';

part 'otp_event.dart';
part 'otp_state.dart';



class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpState.initial()) {
    on<ValidateVerifyButton>(_onValidateOtp);
  }


  Future<void>_onValidateOtp(
      ValidateVerifyButton event, Emitter<OtpState> emit
      )async{
    try{
      if(event.otp.toString().length>3){
        print("otpLengthView!!!! ${event.otp}");
        emit(state.copyWith(stateStatus: StateStatus.success,otp: event.otp));
      }else{
        emit(state.copyWith(stateStatus: StateStatus.failed,otp: event.otp));
      }
    }catch(e){
      emit(state.copyWith(stateStatus: StateStatus.failed));
    }
  }
}
