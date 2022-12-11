import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mornmey_portfolio/models/footer_item.dart';
import 'package:mornmey_portfolio/utils/constants.dart';
import 'package:mornmey_portfolio/utils/screen_helper.dart';

final List<FooterItem> footerItems = [
  FooterItem(
    iconPath: "assets/telegram.png",
    title: "TELEGRAM",
    text1: "https://t.me/mornmey",
  ),
  FooterItem(
    iconPath: "assets/phone.png",
    title: "PHONE",
    text1: "+855 85 341 311",
  ),
  FooterItem(
    iconPath: "assets/email.png",
    title: "EMAIL",
    text1: "mornmey952@gmail.com",
  ),
  FooterItem(
    iconPath: "assets/github.png",
    title: "GITHUB",
    text1: "https://github.com/mornmey",
  )
];

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }
}

Widget _buildUi(double width, BuildContext context) {
  return Center(
    child: ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CONTACT ME",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                  height: 1.3,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Wrap(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 400.0),
                    child: Text(
                      ""
                      "This is my information.",
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: footerItems
                    .map(
                      (footerItem) => Container(
                        height: 120.0,
                        width: ScreenHelper.isMobile(context)
                            ? constraints.maxWidth / 2.0 - 20.0
                            : constraints.maxWidth / 4.0 - 20.0,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    footerItem.iconPath,
                                    color: kDangerColor,
                                    width: 25.0,
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    footerItem.title,
                                    style: GoogleFonts.oswald(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              SelectableText.rich(
                                TextSpan(
                                  text: "${footerItem.text1}",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (footerItem.text1 == "mornmey952@gmail.com") {
                                        await launchUrl(Uri.parse("mailto:${footerItem.text1}"));
                                      } else if (footerItem.text1 == "+855 85 341 311") {
                                        await launchUrl(Uri.parse("tel:${footerItem.text1}"));
                                      } else {
                                        await launchUrl(Uri.parse("${footerItem.text1}"));
                                      }
                                    },
                                  style: TextStyle(
                                    color: kCaptionColor,
                                    height: 1.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Flex(
                direction: ScreenHelper.isMobile(context) ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: ScreenHelper.isMobile(context)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Copyright (c) 2022.",
                      style: TextStyle(
                        color: kCaptionColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: kCaptionColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "|",
                          style: TextStyle(
                            color: kCaptionColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            "Terms & Conditions",
                            style: TextStyle(
                              color: kCaptionColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );
}
