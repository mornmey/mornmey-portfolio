import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mornmey_portfolio/models/reference.dart';
import 'package:mornmey_portfolio/utils/constants.dart';
import 'package:mornmey_portfolio/utils/screen_helper.dart';

final List<Reference> references = [
  Reference(
    telegramLink: "https://t.me/Naseang",
    phoneNumber: "+855 86 213 939",
    email: "channa.seang@gmail.com",
    occupation: "UX/UI Designer",
    personName: "CHOR CHANNASEANG",
    profilePhoto: "assets/female.png",
  ),
  Reference(
    telegramLink: "https://t.me/Chakkrey",
    phoneNumber: "+855 16 687 126",
    email: "saingchakkreymeas@gmail.com",
    occupation: "Senior Mobile Developer",
    personName: "MEAS SAINGCHAKKREY",
    profilePhoto: "assets/male.png",
  )
];

class TestimonialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth),
        tablet: _buildUi(kTabletMaxWidth),
        mobile: _buildUi(getMobileMaxWidth(context)),
      ),
    );
  }
}

Widget _buildUi(double width) {
  return Center(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ResponsiveWrapper(
          maxWidth: width,
          minWidth: width,
          defaultScale: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "REFERENCES",
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
              Container(
                constraints: BoxConstraints(maxWidth: 400.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "This is the reference information.",
                        style: TextStyle(color: Colors.white, height: 1.8),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              Flex(
                direction: ScreenHelper.isMobile(context) ? Axis.vertical : Axis.horizontal,
                // Lets map
                children: references.map((reference) {
                  return Expanded(
                    flex: ScreenHelper.isMobile(context) ? 0 : 1,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/quote.png",
                              color: kDangerColor,
                              width: 50.0,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                  reference.profilePhoto,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText.rich(
                                    TextSpan(
                                      text: reference.personName,
                                      style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  SelectableText.rich(
                                    TextSpan(
                                      text: reference.occupation,
                                      style: TextStyle(
                                        color: kCaptionColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  SelectableText.rich(
                                    TextSpan(
                                      text: "${reference.phoneNumber}",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          await launchUrl(Uri.parse("tel:${reference.phoneNumber}"));
                                        },
                                      style: TextStyle(
                                        color: kCaptionColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  SelectableText.rich(
                                    TextSpan(
                                      text: "${reference.telegramLink}",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          await launchUrl(Uri.parse(reference.telegramLink));
                                        },
                                      style: TextStyle(
                                        color: kCaptionColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  SelectableText.rich(
                                    TextSpan(
                                      text: "${reference.email}",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          await launchUrl(Uri.parse("mailto:${reference.email}"));
                                        },
                                      style: TextStyle(
                                        color: kCaptionColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40.0),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    ),
  );
}
