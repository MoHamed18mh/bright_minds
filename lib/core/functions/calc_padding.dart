import 'package:flutter/material.dart';

double calcPadding(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  return ((size.width > 500) ? size.width * .129 : 18).toDouble();
}
