import 'package:flutter/material.dart';

Color colourChoice(endRow, startRow, endCol, startCol) {
  var size = (endRow - startRow + 1) * (endCol - startCol + 1);
  switch (size) {
    case 1:
      {
        return Colors.lightBlue;
      }

    case 2:
      {
        return const Color.fromARGB(255, 3, 107, 244);
      }

    case 3:
      {
        return const Color.fromARGB(255, 3, 7, 244);
      }

    case 4:
      {
        return const Color.fromARGB(255, 95, 3, 244);
      }

    case 5:
      {
        return const Color.fromARGB(255, 188, 3, 244);
      }

    case 6:
      {
        return const Color.fromARGB(255, 244, 3, 232);
      }

    case 7:
      {
        return const Color.fromARGB(255, 224, 3, 244);
      }

    case 8:
      {
        return const Color.fromARGB(255, 244, 3, 212);
      }

    case 9:
      {
        return const Color.fromARGB(255, 244, 3, 152);
      }

    case 10:
      {
        return const Color.fromARGB(255, 244, 3, 83);
      }

    case 12:
      {
        return const Color.fromARGB(255, 244, 3, 35);
      }
    default:
      {
        return const Color.fromARGB(255, 244, 3, 3);
      }
  }
}
