
import 'package:flutter/material.dart';

class AppColor{

  // primary color
  static const PrimaryColor = Color(0xFF1b0d7e);
  static const SecondaryColor = Color(0xFFf9610b);
  static const lightColor = Color(0xFF1652bf);

  // gray color shade
  static const GreyShade1 = Color(0xFF8E8E93);
  static const GreyShade2 = Color(0xFFAEAEB2);
  static const GreyShade3 = Color(0xFFC7C7CC);
  static const GreyShade4 = Color(0xFFD1D1D6);
  static const GreyShade5 = Color(0xFFE5E5EA);
  static const GreyShade6 = Color(0xFFF2F2F7);
  static Map<int, Color> color =
  {
    50:Color.fromRGBO(13,150,130, .1),
    100:Color.fromRGBO(13,150,130, .2),
    200:Color.fromRGBO(13,150,130, .3),
    300:Color.fromRGBO(13,150,130, .4),
    400:Color.fromRGBO(13,150,130, .5),
    500:Color.fromRGBO(13,150,130, .6),
    600:Color.fromRGBO(13,150,130, .7),
    700:Color.fromRGBO(13,150,130, .8),
    800:Color.fromRGBO(13,150,130, .9),
    900:Color.fromRGBO(13,150,130, 1),

  };

  static MaterialColor colorCustom = MaterialColor(0xFF0D9682, color);

}

