import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:physical_fitness_planner/models/onborading_model.dart';
import 'package:physical_fitness_planner/screens/WelcomeScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('FFE5B4'),
      body: PageView.builder(
          controller: _controller,
          itemCount: contents.length,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        contents[index].image,
                        height: 360,
                        width: double.maxFinite,
                      ),
                      Text(
                        contents[index].title,
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          contents[index].discription,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (currentIndex == contents.length - 1) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => const LandingScreen())));
                      }
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.decelerate);
                    },
                    child: Text(currentIndex == contents.length - 1
                        ? 'Continue'
                        : "Next"))
              ],
            );
          })),
    );
  }
}
