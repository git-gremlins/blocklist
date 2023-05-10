import 'package:flutter/material.dart';
import 'dart:math';
import 'package:frontend/screens/splash_screen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  static const List<String> backgroundImages = [
    'assets/p5.jpg',
    // 'assets/p2.jpg',
    // 'assets/p3.jpg'
  ];

  String _getRandomBackgroundImage() {
    final random = Random();
    return backgroundImages[random.nextInt(backgroundImages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  _getRandomBackgroundImage(),
                ),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Center(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  "Welcome to BlockList",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SplashPage()),
                  );
                },
                icon: Icon(Icons.login),
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
