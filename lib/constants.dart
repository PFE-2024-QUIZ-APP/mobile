import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// IMAGES
String logo = 'lib/assets/images/logo.png';


// GRADIENTS ET COLORS
const LinearGradient BackgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF4A69AA), Color(0xFF84A6C8)],
);

const Color purple = Color(0xFF8B85C1);
const Color blue = Color(0xFF094D92);
const Color lightBlue = Color(0xFF84A6C8);


// FONT STYLE

class TextGlobalStyle {
  static const TextStyle buttonStylePurple = TextStyle(
    fontFamily: 'Luckiest',
    fontSize: 20,
    height: 1,
    color: purple,
  );

  static const TextStyle buttonStyleWhite= TextStyle(
    fontFamily: 'Luckiest',
    fontSize: 20,
    height: 1,
    color: Colors.white,
  );

  static const TextStyle timerStyle = TextStyle(
    fontFamily: 'Luckiest',
    fontSize: 100,
    height: 1,
    color: blue,
  );
}


