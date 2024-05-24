import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.onPress,
      this.backgroundColor,
      this.height,
      this.width,
      this.buttonText,
      this.textColor,
      this.src,this.isShowIcon,this.enableButton});

  void Function()? onPress;
  dynamic backgroundColor;
  dynamic height;
  dynamic width;
  dynamic buttonText;
  dynamic textColor;
  dynamic src;
  bool?isShowIcon;
  bool?enableButton;

  @override
  Widget build(BuildContext context) {
    return _customButton(
        onPress, backgroundColor, height, width, buttonText, textColor, src,isShowIcon,enableButton);
  }
}

Widget _customButton(void Function()? onPress, backgroundColor, height, width,
    buttonText, textColor, src,isShowIcon,enableButton) {
  return ElevatedButton(
    onPressed: enableButton==true?onPress:null,
    style: ElevatedButton.styleFrom(
      // Text color
      backgroundColor: backgroundColor,
      elevation: 0.0, // Elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Rounded corners
      ),
      padding: const EdgeInsets.symmetric(vertical: 15.0), // Button padding
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(visible: isShowIcon??false, child: Image.asset(src ?? '')),
        SizedBox(width: 8.0),
        Text(buttonText ?? '', style: TextStyle(color: textColor ?? '')),
      ],
    ),
  );
}
