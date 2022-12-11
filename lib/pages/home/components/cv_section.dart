import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mornmey_portfolio/models/experience.dart';
import 'package:mornmey_portfolio/utils/constants.dart';
import 'package:mornmey_portfolio/utils/screen_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

final List<Experience> experience = [
  Experience(
    title: "UX/UI & DESIGN",
    imagePath: "assets/design.png",
    projectDes: "Football team.",
    projectTitle: "BLUE HORSE FT",
    projectLinkName: "FIGMA",
    projectLink:
        "https://www.figma.com/file/aE90ce1PKOvs4WW5IgVddJ/BLUE-HORSE?node-id=0%3A1&t=8Gpan2z7V87ne5X6-0",
  ),
  Experience(
    title: "MOBILE DEVELOPER",
    imagePath: "assets/develop.png",
    projectDes: "Delivery Made Simple.",
    projectTitle: "HLH EXPRESS",
    projectLinkName: "DOWNLOAD NOW",
    projectLink: "https://play.google.com/store/apps/details?id=com.hlhtransport.express&hl=en",
  ),
  Experience(
    title: "WEB DEVELOPER",
    imagePath: "assets/write.png",
    projectDes: "My Information.",
    projectTitle: "PORTFOLIO",
    projectLinkName: "PORTFOLIO",
    projectLink: "http://localhost:2533/#/",
  ),
  Experience(
    title: "ML & DATA SCIENCE",
    imagePath: "assets/promote.png",
    projectDes:
        "Job searching analysis is the process of scraping data from popular websites in Cambodia such as Bongthom, CamHr, Pel Prek or National Employment Agency website, etc.",
    projectTitle: "JOB SEARCHING ANALYSIS",
    projectLinkName: "",
    projectLink: "",
  ),
];

class CvSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ScreenHelper(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    // we need the context to get maxWidth before the constraints below
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "BETTER DESIGN,\nBETTER EXPERIENCES",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.8,
                  fontSize: 18.0,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final cv =
                      "https://drive.google.com/drive/u/0/folders/1SdtAENk_A4-E978LiuNzZ2KDGPsJkSwU";
                  await launchUrl(Uri.parse(cv));
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AutoSizeText(
                    "DOWNLOAD CV",
                    maxFontSize: 18,
                    minFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.oswald(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          LayoutBuilder(
            builder: (_context, constraints) {
              return ResponsiveGridView.builder(
                padding: EdgeInsets.all(0.0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                alignment: Alignment.topCenter,
                gridDelegate: ResponsiveGridDelegate(
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  maxCrossAxisExtent:
                      ScreenHelper.isTablet(context) || ScreenHelper.isMobile(context)
                          ? constraints.maxWidth / 2.0
                          : 250.0,
                  // Hack to adjust child height
                  childAspectRatio: ScreenHelper.isDesktop(context)
                      ? 1
                      : MediaQuery.of(context).size.aspectRatio * 1.2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            experience[index].imagePath,
                            color: kDangerColor,
                            width: 40.0,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              experience[index].title,
                              minFontSize: 20,
                              maxFontSize: 20,
                              style: GoogleFonts.oswald(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        experience[index].projectTitle,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      AutoSizeText(
                        experience[index].projectDes,
                        minFontSize: 14,
                        maxFontSize: 14,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Visibility(
                        visible: experience[index].projectLinkName != "",
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
                                await launchUrl(Uri.parse(experience[index].projectLink));
                              },
                              child: Text(
                                experience[index].projectLinkName,
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
                    ],
                  );
                },
                itemCount: experience.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
