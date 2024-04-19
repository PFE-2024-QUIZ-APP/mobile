import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// IMAGES
String logo = 'lib/assets/images/logo.png';
String logoSVG = 'lib/assets/images/logo.svg';

// ICONS
String play = 'lib/assets/icons/play.svg';
String host = 'lib/assets/images/host.svg';
String profile = 'lib/assets/images/profile.svg';
String share = 'lib/assets/images/share.svg';
String close = 'lib/assets/images/close.png';

// AVATARS
String avatar_1 = 'lib/assets/images/avatar_1.png';
String avatar_2 = 'lib/assets/images/avatar_2.png';
String avatar_3 = 'lib/assets/images/avatar_3.png';
String avatar_4 = 'lib/assets/images/avatar_4.png';
String avatar_5 = 'lib/assets/images/avatar_5.png';
String avatar_6 = 'lib/assets/images/avatar_6.png';
String avatar_7 = 'lib/assets/images/avatar_7.png';
String avatar_8 = 'lib/assets/images/avatar_8.png';

// GRADIENTS ET COLORS
const LinearGradient BackgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF4D6BA8),Color(0xFF83A5C7), Color(0xFF83A6C7)],
  stops: [0.1, 0.5, 0.9],
);

const Color purple = Color(0xFF8B85C1);
const Color blue = Color(0xFF094D92);
const Color blue60 = Color(0x99094D92);
const Color lightBlue = Color(0xFF84A6C8);
const Color correct = Color(0xFF8ED5A2);
const Color wrong = Color(0xFFD23C3C);


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
  static const TextStyle answerButtonStyleWhite= TextStyle(
    fontFamily: 'Luckiest',
    fontSize: 16,
    height: 1,
    color: Colors.white,
  );

  static const TextStyle listTileText = TextStyle(
    fontFamily: 'Luckiest',
    fontSize: 14,
    height: 1,
    color: Colors.white,
  );

  static const TextStyle timerStyle = TextStyle(
    fontFamily: 'Luckiest',
    fontSize: 100,
    height: 1,
    color:  Colors.white,
  );

  static const TextStyle questionTimerStyle = TextStyle(
    fontFamily: 'Luckiest',
    fontSize: 48,
    height: 1,
    color:  Colors.white,
  );

  static const TextStyle nbQuestionStyle = TextStyle(
    fontFamily: 'Luckiest',
    fontSize: 32,
    height: 1,
    color:  Colors.white,
  );
}


