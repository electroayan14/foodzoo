import 'package:flutter/material.dart';
import 'package:foodzoo/features/utils/colors.dart';
import 'package:foodzoo/features/utils/image_constants.dart';
import 'package:foodzoo/routes/constants.dart';
import 'package:foodzoo/widgets/custom_button.dart';

class SilderScreen extends StatefulWidget {
  @override
  _SilderScreenState createState() => _SilderScreenState();
}

class _SilderScreenState extends State<SilderScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<String> images = [
    ImageConstant.firstImage,
    ImageConstant.secondImage,
    ImageConstant.thirdImage,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 800.0,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                      }
                      return Center(
                        child: SizedBox(
                          height: Curves.easeInOut.transform(value) * 300,
                          width: Curves.easeInOut.transform(value) * 300,
                          child: child,
                        ),
                      );
                    },
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            _buildIndicatorRow(),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPress: () => onClickContinue(),
                enableButton: true,
                backgroundColor: AppColors.appThemeColor,
                height: 56.0,
                buttonText: 'Continue',
                textColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPress: () =>Navigator.of(context)
                    .pushNamedAndRemoveUntil(login, (Route<dynamic> route) => false),
                backgroundColor: Colors.grey[100],
                height: 56.0,
                enableButton: true,
                buttonText: 'Skip',
                textColor: AppColors.appThemeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images.map((String image) {
        int index = images.indexOf(image);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == index ? AppColors.appThemeColor : Colors.grey,
          ),
        );
      }).toList(),
    );
  }



  onClickContinue(){
    if (_currentPage < images.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
