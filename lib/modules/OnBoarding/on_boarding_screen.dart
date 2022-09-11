// ignore_for_file: camel_case_types, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:experiences_app/modules/Login/login_screen.dart';
import 'package:experiences_app/shared/components/components.dart';
import 'package:experiences_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageViewController = PageController();

  bool isLastPage = false;

  Color? colorChange = Colors.blueAccent.shade400;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true)
        .then((value) => navigateAndFinish(context, ShopLoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(bottom: 130),
        child: PageView(
          allowImplicitScrolling: true,
          controller: pageViewController,
          onPageChanged: (index) {
            if (index == 0) {
              colorChange = Colors.blueAccent.shade400;
            } else if (index == 1) {
              colorChange = Colors.redAccent.shade200;
            }
            setState(() => isLastPage = index == 2);
          },
          physics: const BouncingScrollPhysics(),
          children: [
            buildPageOnBoardingScreen(
              color: Colors.white,
              colorText: Colors.blueAccent.shade400,
              urlImage: 'assets/images/ShopSlider1.jpg',
              title: 'Online Shpopping',
              subtitle:
                  'Online shopping is a form of electronic commerce which allows consumers to directly buy goods or services from a seller over the Internet\n using a mobile ..',
            ),
            buildPageOnBoardingScreen(
              color: Colors.white,
              colorText: Colors.redAccent.shade200,
              urlImage: 'assets/images/ShopSlider2.jpg',
              title: 'Fast Delivery',
              subtitle:
                  'Check out our fast delivery selection for the\n very best in unique or custom, handmade\n pieces from our shops ..',
            ),
            buildPageOnBoardingScreen(
              color: Colors.white,
              colorText: Colors.deepPurple,
              urlImage: 'assets/images/ShopSlider3.jpg',
              title: 'Easy Payment',
              subtitle:
                  'We are a payment platform with +240\n payment solutions & fraud prevention',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    key: UniqueKey(),
                    style: TextButton.styleFrom(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      primary: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(330, 75),
                    ),
                    //  submit() : Use this method when finish to editing this a screen ...
                    // that don't show onBoarding screen again
                    onPressed: () async {
                      if (isLastPage) {
                        submit();
                      }
                    },

                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    key: UniqueKey(),
                    onPressed: () => pageViewController.jumpToPage(2),
                    child: Text('SKIP',
                        style: TextStyle(
                          color: colorChange,
                          fontSize: 15,
                          fontFamily: '',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageViewController,
                      count: 3,
                      onDotClicked: (index) => pageViewController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutQuart,
                      ),
                      effect: WormEffect(
                        dotHeight: 8,
                        dotWidth: 17,
                        spacing: 13,
                        activeDotColor: colorChange!,
                        type: WormType.thin,
                        // strokeWidth: 50,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'next',
                    backgroundColor: colorChange,
                    onPressed: () {
                      pageViewController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: OnBoardingUi(
//           slides: [
//             SliderModel.Slider(
//               sliderHeading: "Online Order",
//               sliderSubHeading:
//                   "Lorem ipsum dolor sit amet,\nAenean commodo ligula eget dolor.",
//               sliderImageUrl: 'assets/images/ShopSlider1.jpg',
//             ),
//             SliderModel.Slider(
//               sliderHeading: "Fast Delivery",
//               sliderSubHeading:
//                   "Lorem ipsum dolor sit amet,\nConsectetur adipiscing elit, sed do eiusmod.",
//               sliderImageUrl: 'assets/images/ShopSlider2.jpg',
//             ),
//             SliderModel.Slider(
//               sliderHeading: "Online Shopping",
//               sliderSubHeading:
//                   "Lorem ipsum dolor sit amet,\nAenean commodo ligula eget dolor.",
//               sliderImageUrl: 'assets/images/ShopSlider3.jpg',
//             )
//           ],
//           onFinish: () {
//             CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
//               if (value) {
//                 navigateAndFinish(context, ShopLoginScreen());
//               }
//             });
//           }),
//     );
//   }
// }
