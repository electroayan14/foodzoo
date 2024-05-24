import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodzoo/features/utils/colors.dart';
import 'package:foodzoo/features/utils/enums/enums.dart';
import 'package:foodzoo/features/utils/image_constants.dart';

import '../../../routes/constants.dart';
import '../../../widgets/alerdialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import 'bloc/login_bloc.dart';

//ignore:must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  bool enableButton = false;

  TextEditingController mobileNumberController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  dynamic usernameValue;
  dynamic passwordValue;
  dynamic mobileNoValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state.stateStatus) {
          case StateStatus.loading:
          case StateStatus.success:
            enableButton = true;
          case StateStatus.failed:
            enableButton = false;
        }
      },
      builder: (context, state) {
        return _loginForm(context);
      },
    );
  }

  Widget _loginForm(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(ImageConstant.logo),
            Visibility(
              visible: true,
              child: Column(
                children: [
                  CustomTextFormField(
                      textController: userNameController,
                      hintText: 'example@gmail.com',
                      labelText: 'Username',
                      validatorText: 'Please enter username ',
                      onChanged: (value) => {
                            usernameValue = value.toString(),
                            validateCredential(
                                context, value, passwordValue, mobileNoValue),
                          }),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                      textController: passwordController,
                      obscureText: true,
                      labelText: 'Password',
                      validatorText: 'Please enter password',
                      onChanged: (value) => {
                            passwordValue = value.toString(),
                            validateCredential(
                                context, usernameValue, value, mobileNoValue),
                          }),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Visibility(
              visible: true,
              child: CustomTextFormField(
                  textController: mobileNumberController,
                  hintText: 'Enter mobile no',
                  labelText: 'Mobile number',
                  validatorText: 'Please enter mobile number',
                  onChanged: (value) => {
                        mobileNoValue = value.toString(),
                        validateCredential(
                            context, usernameValue, passwordValue, value),
                      }),
            ),
            const SizedBox(height: 10.0),
            CustomButton(
              onPress: () => Navigator.pushReplacementNamed(context, otpScreen),
              enableButton: enableButton,
              backgroundColor: AppColors.appThemeColor,
              height: 56.0,
              width: 350.0,
              buttonText: 'Continue',
              textColor: Colors.black,
            ),
            const SizedBox(height: 20.0),
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Don’t have an account? ',
                    ),
                    TextSpan(
                      text: ' Sign up',
                      style: TextStyle(
                        color: AppColors.appThemeColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          // Handle your click event here
                          await appAlertDialog(
                              context, () => Navigator.pop(context));
                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  validateCredential(context, username, password, mobileNo) {
    BlocProvider.of<LoginBloc>(context).add(CredentialValidateEvent(
        username.toString(), password.toString(), mobileNo.toString()));
  }
}
