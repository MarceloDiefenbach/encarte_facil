import 'package:flutter/material.dart';


//SPACING

spacingQuarck(double screenHeight) {
  return screenHeight*0.0105;
}

spacingNano(double screenHeight) {
  return screenHeight*0.021;
}

spacingXXXS(double screenHeight) {
  return screenHeight*0.042;
}

spacingXXS(double screenHeight) {
  return screenHeight*0.063;
}

spacingGlobalMargin(){
  return 20.0;
}


//COLORS

colorBrandPrimary() {
  return Color(0xff5DA0EF);
}

colorNeutralHighPure(){
  return Color(0xffFFFFFF);
}

colorNeutralHighDark(){
  return Color(0xffE4E4E4);
}

colorNeutralLowPure(){
  return Color(0xff000000);
}

//CORNER RADIUS
borderRadiusNone() {
  return BorderRadius.circular(0);
}

borderRadiusSmall() {
  return BorderRadius.circular(4);
}

borderRadiusMedium() {
  return BorderRadius.circular(8);
}

borderRadiusCircular(){
  return BorderRadius.circular(500);
}
