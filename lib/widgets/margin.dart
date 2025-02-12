import 'package:flutter/material.dart';

class ResponsiveMargin {
  static double getMargin(BoxConstraints constraints) {
    double maxWidth = constraints.maxWidth;
    return maxWidth > 1000 ? (maxWidth - 1000) / 2 : 20;
  }
}

class ResponsiveInputField {
  static getMargin(BoxConstraints constraints) {
    double maxWidth = constraints.maxWidth;
    return maxWidth > 300 ? (maxWidth - 300) / 2 : 20;
  }
}
