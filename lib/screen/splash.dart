import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:task/constant/constent.dart';
import 'package:task/screen/sign%20in.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA7AA),
      body: Stack(
        children: [
          Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              child: Center(
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  repeatForever: false,
                  animatedTexts: [
                    FadeAnimatedText('Task'),
                    FadeAnimatedText('From Mohammed \nAlazmeh'),
                    FadeAnimatedText('For NanoHealth'),
                  ],
                  onFinished: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Signin()),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Signin(),
                ));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 10,
                      color: Colors.white,
                    )
                  ],
                  color: Colors.white,
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(color: klabelTextColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
