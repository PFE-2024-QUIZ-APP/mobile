import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(logoSVG, height: 81, width: 180);
  }
}
