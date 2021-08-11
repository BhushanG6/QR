import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutproj/size_config.dart';
// Migrate DiagnosticableMixin to Diagnosticable until
// https://github.com/flutter/flutter/pull/51495 makes it into stable (v1.15.21)
class DatePickerTheme with DiagnosticableTreeMixin {
  final TextStyle cancelStyle;
  final TextStyle doneStyle;
  final TextStyle itemStyle;
  final Color backgroundColor;
  final Color headerColor;

  final double containerHeight;
  final double titleHeight;
  final double itemHeight;

  const DatePickerTheme(this.doneStyle, this.containerHeight, this.titleHeight, this.itemHeight, {
    this.cancelStyle = const TextStyle(color: Colors.black54, fontSize: 16),
    //this.doneStyle = const TextStyle(color: Colors.black, fontSize: 16),
    this.itemStyle = const TextStyle(color: Color(0xFF000046), fontSize: 18),
    this.backgroundColor = Colors.white,
    this.headerColor,
    //this.containerHeight = 350,
    //this.titleHeight = 44.0,
    //this.itemHeight = 36.0,
    // ignore: non_constant_identifier_names
  
  });
}
