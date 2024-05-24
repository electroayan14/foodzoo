import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodzoo/features/screens/otp/bloc/otp_bloc.dart';
import 'package:foodzoo/features/utils/enums/enums.dart';
import 'package:foodzoo/routes/constants.dart';
import 'package:pinput/pinput.dart';

import '../../../widgets/custom_button.dart';
import '../../utils/colors.dart';
import '../../utils/image_constants.dart';

//ignore:must_be_immutable
class OTPScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();
  bool enableVerifyOtp = false;

  OTPScreen({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          switch (state.stateStatus) {
            case StateStatus.loading:
            // TODO: Handle this case.
            case StateStatus.success:
              enableVerifyOtp = true;
            case StateStatus.failed:
              enableVerifyOtp = false;
          }
        },
        builder: (context, state) {
          return otpInputField(context, () =>  Navigator.pushNamed(context, locationScreen));
        },
      ),
    );
  }

  otpInputField(context, void Function()? onVerifyOTP) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(ImageConstant.splashImage),
              const Text(
                'Enter 4-digit OTP sent to your given mobile number',
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 8.0),
              buildOTPDigitField(
                  context),
              const SizedBox(height: 8.0),
              CustomButton(
                onPress: onVerifyOTP,
                enableButton: enableVerifyOtp,
                backgroundColor: AppColors.appThemeColor,
                height: 56.0,
                width: 350.0,
                buttonText: 'Verify OTP',
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOTPDigitField(
      context) {
    return Pinput(
      length: 4,
      validator: (s) {
        return "";
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      pinAnimationType: PinAnimationType.rotation,
      showCursor: true,
      onChanged: (value) => validateCredential(context, value),
    );
  }

  validateCredential(context, otp) {
    print("otpvalue!!!!!$otp");
    BlocProvider.of<OtpBloc>(context).add(ValidateVerifyButton(otp.toString()));
  }
}
