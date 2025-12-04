import 'package:flutter/material.dart';

extension SizeExtensions on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  
  double get height => MediaQuery.sizeOf(this).height;
  
  double percentHeight (double percent)=> height * percent;
  double percentWidth (double percent)=> width * percent;
}
