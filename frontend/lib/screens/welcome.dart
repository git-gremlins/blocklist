import 'package:flutter/material.dart';
import 'dart:math';
import 'package:frontend/screens/splash_screen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  // static const List<String> backgroundImages = ['assets/greyback.jpg'];

  static const List<String> backgroundImages = [
    // 'https://i.seadn.io/gae/0jPQNCjX-zkP8NjDnlmOTlQsrgE5mO8o4m4Seotr6JSFr4SLeRZilyp_dB5K430x59PiNe6xT37Docg7jZ1Xeaf-1GIMcvBrc2Qmeg?auto=format&w=1000',
    'https://i.seadn.io/gae/w5XoKsN9vXLP0_cKIPM4bB5cJSGfgKt241MMl1FxD4IhcnTlzkhBN3HAVVhSqCfib_3_iUB0t_tTzhak-hlQ_oOVv0frCMkJFlbKwQ?auto=format&w=1200',
  ];

  // [
  //   // 'https://i.seadn.io/gae/0jPQNCjX-zkP8NjDnlmOTlQsrgE5mO8o4m4Seotr6JSFr4SLeRZilyp_dB5K430x59PiNe6xT37Docg7jZ1Xeaf-1GIMcvBrc2Qmeg?auto=format&w=1000',
  //   'https://i.seadn.io/gae/w5XoKsN9vXLP0_cKIPM4bB5cJSGfgKt241MMl1FxD4IhcnTlzkhBN3HAVVhSqCfib_3_iUB0t_tTzhak-hlQ_oOVv0frCMkJFlbKwQ?auto=format&w=1200',
  //   'https://i.seadn.io/gae/by84lEwLcPErvS8_E3Sarerepmi74PBp85fxeHTor7xadp5-bT20pOHm2bsffNAsJmSRnJdsf7T_m5PGVSBSiv2nkllEoMK3t167gw?auto=format&w=1200',
  //   'https://i.seadn.io/gae/tbdHR04RZZWqu2ZZoRZBE65dtw3DNZrjcb2j_MOTES0fH3eDfW1D8XiFzKcFbMVx6tribNOp5euWUPl1YWeNnWLGtG0gBlAbDExfnz0?auto=format&w=1200',
  //   'https://i.seadn.io/gcs/files/6fdd0cb3b4dddccaa7ff95e2d5f91429.jpg?auto=format&w=1200',
  //   // 'https://i.ibb.co/S6HQHw9/bluebackground.jpg',
  // ];

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
                image: NetworkImage(
                  _getRandomBackgroundImage(),
                ),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Center(
              child: Text(
                "Welcome to BlockList",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
