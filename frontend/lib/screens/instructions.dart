import 'package:flutter/material.dart';

import 'dart:math';

class Instructions extends StatelessWidget {
  static const List<String> backgroundImages = [
    'https://i.seadn.io/gae/0jPQNCjX-zkP8NjDnlmOTlQsrgE5mO8o4m4Seotr6JSFr4SLeRZilyp_dB5K430x59PiNe6xT37Docg7jZ1Xeaf-1GIMcvBrc2Qmeg?auto=format&w=1000',
    'https://i.seadn.io/gae/w5XoKsN9vXLP0_cKIPM4bB5cJSGfgKt241MMl1FxD4IhcnTlzkhBN3HAVVhSqCfib_3_iUB0t_tTzhak-hlQ_oOVv0frCMkJFlbKwQ?auto=format&w=1000',
    'https://i.seadn.io/gae/by84lEwLcPErvS8_E3Sarerepmi74PBp85fxeHTor7xadp5-bT20pOHm2bsffNAsJmSRnJdsf7T_m5PGVSBSiv2nkllEoMK3t167gw?auto=format&w=1000',
    'https://i.seadn.io/gae/tbdHR04RZZWqu2ZZoRZBE65dtw3DNZrjcb2j_MOTES0fH3eDfW1D8XiFzKcFbMVx6tribNOp5euWUPl1YWeNnWLGtG0gBlAbDExfnz0?auto=format&w=1000',
    'https://i.seadn.io/gcs/files/6fdd0cb3b4dddccaa7ff95e2d5f91429.jpg?auto=format&w=1000'
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
            image: NetworkImage(_getRandomBackgroundImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 50, bottom: 10),
              child: Text(
                "INSTRUCTIONS:",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                children: [
                  _buildInstructionContainer(
                    "GENERAL INFO",
                    "Blocklist is a to-do app with interactive tasks, your base page will have a white background. If you are within a subtask, the background color will reflect which task you are within",
                  ),
                  SizedBox(height: 20),
                  _buildInstructionContainer(
                    "NEW TASK",
                    "The grid is 4 x 8 containing 32 squares. click on any empty square, hold and drag to the desired dimensions. As long as there are no other tasks in the way, a new rectangle/square will appear",
                  ),
                  SizedBox(height: 20),
                  _buildInstructionContainer(
                    "EDIT TASK",
                    "Double click on task to update task title and description. You can also delete the task from here",
                  ),
                  SizedBox(height: 20),
                  _buildInstructionContainer(
                    "DELETE TASK",
                    "You can either double click to edit the task and delete. Alternatively you can click the task and locate the delete/bin icon bottom right",
                  ),
                  SizedBox(height: 20),
                  _buildInstructionContainer(
                    "MOVE TASK",
                    "Press and hold on your current task. You will see a border appear, you can now drag this task to any open grid.",
                  ),
                  SizedBox(height: 20),
                  _buildInstructionContainer(
                    "LOG OUT",
                    "On the main grid there will be a logout button on the bottom right",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Row(
                  children: [
                    Icon(Icons.arrow_back),

                    // Icon(Icons.login),
                  ],
                ),
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionContainer(String title, String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
