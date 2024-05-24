import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodzoo/features/utils/enums/enums.dart';
import 'package:foodzoo/features/utils/extensions/extensions.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<CredentialValidateEvent>(_onValidateCredential);
  }

  Future<void> _onValidateCredential(
      CredentialValidateEvent event, Emitter<LoginState> emit) async {
    try {
      if (event.userName.toString().isValidEmail &&
          event.password.toString().length > 9 &&
          event.mobileNo!.length > 9) {
        emit(state.copyWith(stateStatus: StateStatus.success));
      } else {
        emit(state.copyWith(stateStatus: StateStatus.failed));
      }
    } catch (e) {
      emit(state.copyWith(stateStatus: StateStatus.failed));
    }
  }
}
