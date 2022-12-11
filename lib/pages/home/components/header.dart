import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mornmey_portfolio/models/header_item.dart';
import 'package:mornmey_portfolio/utils/constants.dart';
import 'package:mornmey_portfolio/utils/globals.dart';
import 'package:mornmey_portfolio/utils/screen_helper.dart';

List<HeaderItem> headerItems = [
  HeaderItem(title: "HOME", index: 14),
  HeaderItem(title: "CV", index: 12),
  HeaderItem(title: "HLH", index: 11),
  HeaderItem(title: "PORTFOLIO", index: 9),
  HeaderItem(title: "EDUCATION", index: 6),
  HeaderItem(title: "SKILLS", index: 4),
  HeaderItem(title: "REFERENCES", index: 2),
  HeaderItem(
    title: "CONTACT ME",
    index: 1,
    isButton: true,
  ),
];

class HeaderLogo extends StatelessWidget {
  final String text1;
  final String text2;

  HeaderLogo({
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: text1,
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: text2,
                  style: GoogleFonts.oswald(
                    color: kPrimaryColor,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  final ItemScrollController itemScrollController;
  final List itemList;
  HeaderRow({
    required this.itemScrollController,
    required this.itemList,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: [
        Condition.largerThan(name: MOBILE),
      ],
      child: Row(
        children: headerItems
            .map(
              (item) => item.isButton
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kDangerColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                        child: TextButton(
                          onPressed: () {
                            itemScrollController.scrollTo(
                              index: itemList.length - item.index!,
                              duration: Duration(seconds: 2),
                              curve: Curves.easeInOutCubic,
                            );
                          },
                          child: Text(
                            item.title!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        margin: EdgeInsets.only(right: 30.0),
                        child: GestureDetector(
                          onTap: () {
                            itemScrollController.scrollTo(
                              index: itemList.length - item.index!,
                              duration: Duration(seconds: 2),
                              curve: Curves.easeInOutCubic,
                            );
                          },
                          child: Text(
                            item.title!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
            )
            .toList(),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final ItemScrollController itemScrollController;
  final List itemList;
  Header({
    required this.itemScrollController,
    required this.itemList,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: buildHeader(
            itemScrollController: itemScrollController,
            itemList: itemList,
          ),
        ),
        // We will make this in a bit
        mobile: buildMobileHeader(),
        tablet: buildHeader(
          itemScrollController: itemScrollController,
          itemList: itemList,
        ),
      ),
    );
  }

  // mobile header
  Widget buildMobileHeader() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // Lets open drawer using global key
                Globals.scaffoldKey.currentState?.openEndDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 28.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Lets plan for mobile and smaller width screens
  Widget buildHeader({
    required ItemScrollController itemScrollController,
    required List itemList,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderRow(
            itemScrollController: itemScrollController,
            itemList: itemList,
          ),
        ],
      ),
    );
  }
}
