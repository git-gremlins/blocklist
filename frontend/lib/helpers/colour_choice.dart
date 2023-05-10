import 'package:flutter/material.dart';

//pepe color but doesnt match well
// Color colourChoice(endRow, startRow, endCol, startCol) {
//   var size = (endRow - startRow + 1) * (endCol - startCol + 1);
//   if (size <= 3) {
//     return Color(0xFFE5F0EC);
//   } else if (size > 3 && size < 6) {
//     return Color(0xFF781515);
//   } else if (size >= 6 && size <= 9) {
//     return Color(0xFFF1EADB);
//   } else if (size >= 6 && size <= 9) {
//     return Color(0xFFE31414);
//   } else {
//     return Color(0xFF2A5B28);
//   }
// }

// Color colourChoice(endRow, startRow, endCol, startCol) {
//   var size = (endRow - startRow + 1) * (endCol - startCol + 1);
//   if (size <= 3) {
//     return const Color.fromRGBO(255, 230, 230, 1);
//   } else if (size > 3 && size < 6) {
//     return const Color.fromRGBO(242, 209, 209, 1);
//   } else if (size >= 6 && size < 8) {
//     return const Color.fromRGBO(218, 234, 241, 1);
//   } else {
//     return const Color.fromRGBO(198, 220, 228, 1);
//   }
// }

//better math and good palette
Color colourChoice(endRow, startRow, endCol, startCol) {
  var size = (endRow - startRow + 1) * (endCol - startCol + 1);
  if (size <= 3) {
    return Color(0xFFE4572E);
  } else if (size > 3 && size < 6) {
    return Color(0xFF669BBC);
  } else if (size >= 6 && size <= 9) {
    return Color(0xFFF3A712);
  } else {
    return Color(0xFFA8C686);
  }
}

//another
// Color colourChoice(endRow, startRow, endCol, startCol) {
//   var size = (endRow - startRow + 1) * (endCol - startCol + 1);
//   if (size <= 3) {
//     return Color(0xFF9AC4F8);
//   } else if (size > 3 && size < 6) {
//     return Color(0xFF99EDCC);
//   } else if (size >= 6 && size < 8) {
//     return Color(0xFFCB958E);
//   } else {
//     return Color(0xFFE36588);
//   }
// }

//blueish
// Color colourChoice(endRow, startRow, endCol, startCol) {
//   var size = (endRow - startRow + 1) * (endCol - startCol + 1);
//   if (size <= 3) {
//     return Color(0xFF73FBD3);
//   } else if (size > 3 && size < 6) {
//     return Color(0xFF44E5E7);
//   } else if (size >= 6 && size < 8) {
//     return Color(0xFF59D2FE);
//   } else {
//     return Color(0xFF4A8FE7);
//   }
// }

//color palette orange, yellow, purple

// Color colourChoice(endRow, startRow, endCol, startCol) {
//   var size = (endRow - startRow + 1) * (endCol - startCol + 1);
//   if (size <= 3) {
//     return Color.fromARGB(255, 255, 240, 90);
//   } else if (size > 3 && size < 6) {
//     return Color.fromARGB(255, 253, 210, 90);
//   } else if (size >= 6 && size < 8) {
//     return Color.fromARGB(255, 255, 170, 90);
//   } else {
//     return Color.fromARGB(255, 120, 90, 255);
//   }
// }

// Color colourChoice(endRow, startRow, endCol, startCol) {
//   var size = (endRow - startRow + 1) * (endCol - startCol + 1);
//   if (size <= 3) {
//     return const Color.fromRGBO(255, 230, 230, 1);
//   } else if (size > 3 && size < 6) {
//     return const Color.fromRGBO(242, 209, 209, 1);
//   } else if (size >= 6 && size < 8) {
//     return const Color.fromRGBO(218, 234, 241, 1);
//   } else {
//     return const Color.fromRGBO(198, 220, 228, 1);
//   }
// }
