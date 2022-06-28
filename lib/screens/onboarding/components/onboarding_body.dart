import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/screens/homepage/homepage_screen.dart';
import 'package:lezemed_mobile_app/screens/onboarding/components/onboarding_content.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';

class OnBoardingScreenBody extends StatefulWidget {
  const OnBoardingScreenBody({Key key}) : super(key: key);

  @override
  _OnBoardingScreenBodyState createState() => _OnBoardingScreenBodyState();
}

class _OnBoardingScreenBodyState extends State<OnBoardingScreenBody> {
  int currentPage = 0;
  PageController _onBoardingPageController = PageController(initialPage: 0);
  PageView myPageView;
  List<Map<String, String>> onBoardingData = [
    {
      "image": "assets/images/illustration1.png",
      "title": "FREE DELIVERY",
      "description": "Fast and on-time delivery at your prefered delivery date"
    },
    {
      "image": "assets/images/illustration2.png",
      "title": "ON TIME DELIVERY",
      "description": "You Mention Your Time, We Delivery On-Time"
    },
    {
      "image": "assets/images/illustration3.png",
      "title": "SECURE PAYEMENT",
      "description":
          "Accept Payment for All Credit Cards via Stripe and Also PayPal Integration"
    },
    {
      "image": "assets/images/illustration4.png",
      "title": "24/7 SUPPORT",
      "description":
          "Our Support Center is 24/7 Open for the Questions You Have"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(70),
            ),
            Expanded(
              flex: 7,
              child: pageViewBuilder(),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(top: getProportionateScreenHeight(50)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onBoardingData.length,
                    (index) => buildDot(index: index),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(40),
              ),
              child: buildSkip(),
            ),
            // Spacer(),
            SizedBox(
              height: getProportionateScreenHeight(70),
            )
          ],
        ),
      ),
    );
  }

  PageView pageViewBuilder() {
    return PageView.builder(
      controller: _onBoardingPageController,
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      itemCount: onBoardingData.length,
      itemBuilder: (context, index) => OnBoardingContent(
        title: onBoardingData[index]["title"],
        description: onBoardingData[index]["description"],
        image: onBoardingData[index]["image"],
      ),
    );
  }

  Row buildSkip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Routes().navigation(context, HomePageScreen());
          },
          child: Text(
            AppStrings.skip,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
        ),
        IconButton(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          onPressed: () {
            _onBoardingPageController.nextPage(
              duration: kAnimationDuration,
              curve: Curves.easeInSine,
            );
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            color: kSecondaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 7),
      height: getProportionateScreenHeight(7),
      width: currentPage == index ? 27 : 14,
      decoration: BoxDecoration(
          color: currentPage == index ? kSecondaryColor : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 0.6, style: BorderStyle.solid)),
    );
  }
}
