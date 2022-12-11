import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFF78E2F);
const Color kBackgroundColor = Color(0xFF062B48);
const Color kDangerColor = Color(0xFFF78E2F);
const Color kCaptionColor = Color.fromRGBO(166, 177, 187, 1);

// Lets replace all static sizes
const double kDesktopMaxWidth = 1000.0;
const double kTabletMaxWidth = 760.0;
double getMobileMaxWidth(BuildContext context) => MediaQuery.of(context).size.width * .8;
