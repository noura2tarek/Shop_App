import 'package:flutter/material.dart';
import 'package:shop_app/Styles/colors.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/pages/login/login_screen.dart';
import 'package:shop_app/shared/reusable_components/reusable_components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../shared/components/build_boarding_item.dart';
import '../network/static/lists.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  var boardController = PageController();

  void submitToLogin() {
    CacheHelper.savaData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndRemove(context: context, widget: LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, //default back leading arrow
        actions: [
          TextButton(
            onPressed: submitToLogin,
            child: const Text('SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return buildBoardingItem(model: boardingList[index]);
                },
                itemCount: boardingList.length,
                onPageChanged: (index) {
                  if (index == (boardingList.length - 1)) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boardingList.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 12.0,
                    dotWidth: 12.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submitToLogin();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
