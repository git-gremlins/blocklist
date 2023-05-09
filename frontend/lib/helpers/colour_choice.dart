import 'package:flutter/material.dart';

Color colourChoice(endRow, startRow, endCol, startCol) {
  var size = (endRow - startRow + 1) * (endCol - startCol + 1);
  if (size <= 3) {
    return const Color.fromRGBO(255, 230, 230, 1);
  } else if (size > 3 && size < 6) {
    return const Color.fromRGBO(242, 209, 209, 1);
  } else if (size >= 6 && size < 8) {
    return const Color.fromRGBO(218, 234, 241, 1);
  } else {
    return const Color.fromRGBO(198, 220, 228, 1);
  }
}
