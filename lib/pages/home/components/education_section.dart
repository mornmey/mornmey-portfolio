import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mornmey_portfolio/models/education.dart';
import 'package:mornmey_portfolio/utils/constants.dart';
import 'package:mornmey_portfolio/utils/screen_helper.dart';

final List<Education> educationList = [
  Education(
    description:
        "A public higher education institution specialized in digital technology, providing excellent traning programs to foster digital talents indispensable for the development of digital economy and society.",
    educationLink: "https://www.cadt.edu.kh/",
    linkName: "CADT WEBSITE",
    period: "2019 - PRESENT",
    educationName: "Cambodia Academy of Digital Technology-CADT",
  ),
  Education(
    description:
        "This is a sample education and details about it is stated below.This is a sample education and details about it is stated below",
    educationLink: "https://www.facebook.com/profile.php?id=100067117728320",
    linkName: "FACEBOOK PROFILE",
    period: "2017 - 2019",
    educationName: "Hun Sen Sangkerb High School",
  ),
  Education(
      description:
          "This is a sample education and details about it is stated below. This is a sample education and details about it is stated below",
      educationLink: "https://www.facebook.com/profile.php?id=100067117728320",
      linkName: "FACEBOOK PROFILE",
      period: "2013 - 2017",
      educationName: "Hun Sen Sangkerb Secondary School"),
  Education(
      description:
          "This is a sample education and details about it is stated below. This is a sample education and details about it is stated below",
      educationLink: "",
      linkName: "",
      period: "2006 - 2013",
      educationName: "Phnov Primary School"),
];

class EducationSection extends StatelessWidget {
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

  Widget _buildUi(double width) {
    return Container(
      alignment: Alignment.center,
      child: ResponsiveWrapper(
        maxWidth: width,
        minWidth: width,
        defaultScale: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "EDUCATION",
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
                    "This is the educational information.",
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
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: educationList
                        .map(
                          (education) => Container(
                            width: constraints.maxWidth / 2.0 - 20.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  education.period,
                                  style: GoogleFonts.oswald(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SelectableText.rich(
                                  TextSpan(
                                    text: education.educationName,
                                    style: GoogleFonts.oswald(
                                      color: kDangerColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                SelectableText.rich(
                                  TextSpan(
                                    text: education.description,
                                    style: TextStyle(
                                      color: kCaptionColor,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Visibility(
                                  visible: education.linkName != "",
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      height: 48.0,
                                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                                      child: TextButton(
                                        onPressed: () async {
                                          await launchUrl(Uri.parse(education.educationLink));
                                        },
                                        child: Text(
                                          education.linkName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  replacement: Container(),
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
