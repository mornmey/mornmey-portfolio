import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mornmey_portfolio/pages/home/components/carousel.dart';
import 'package:mornmey_portfolio/pages/home/components/cv_section.dart';
import 'package:mornmey_portfolio/pages/home/components/footer.dart';
import 'package:mornmey_portfolio/pages/home/components/header.dart';
import 'package:mornmey_portfolio/pages/home/components/ios_app_ad.dart';
import 'package:mornmey_portfolio/pages/home/components/portfolio_stats.dart';
import 'package:mornmey_portfolio/pages/home/components/references_widget.dart';
import 'package:mornmey_portfolio/pages/home/components/education_section.dart';
import 'package:mornmey_portfolio/pages/home/components/skill_section.dart';
import 'package:mornmey_portfolio/pages/home/components/website_ad.dart';
import 'package:mornmey_portfolio/utils/constants.dart';
import 'package:mornmey_portfolio/utils/globals.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemScrollController itemScrollController = ItemScrollController();
    final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
    final ValueNotifier<bool> isTopNotif = ValueNotifier(true);
    final itemList = [
      Carousel(), // 13
      SizedBox(height: 20.0), //12
      CvSection(), // 11
      IosAppAd(), // 10
      SizedBox(height: 50.0), // 9
      WebsiteAd(), // 8
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
        child: PortfolioStats(),
      ), // 7
      SizedBox(height: 50.0), // 6
      EducationSection(), // 5
      SizedBox(height: 50.0), // 4
      SkillSection(), // 3
      SizedBox(height: 100.0), // 2
      TestimonialWidget(), // 1
      Footer(), // 0
    ];
    return Scaffold(
      key: Globals.scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return headerItems[index].isButton
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kDangerColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 28.0),
                          child: TextButton(
                            onPressed: () {
                              itemScrollController.scrollTo(
                                index: itemList.length - headerItems[index].index!,
                                duration: Duration(seconds: 2),
                                curve: Curves.easeInOutCubic,
                              );
                              Globals.scaffoldKey.currentState?.closeEndDrawer();
                            },
                            child: Text(
                              headerItems[index].title!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ListTile(
                        title: TextButton(
                          onPressed: () {
                            itemScrollController.scrollTo(
                              index: itemList.length - headerItems[index].index!,
                              duration: Duration(seconds: 2),
                              curve: Curves.easeInOutCubic,
                            );
                            Globals.scaffoldKey.currentState?.closeEndDrawer();
                          },
                          child: Text(
                            headerItems[index].title!,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.0,
                );
              },
              itemCount: headerItems.length,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: ValueListenableBuilder<bool>(
          valueListenable: isTopNotif,
          builder: (_, isTop, __) => Visibility(
            visible: isTop,
            child: HeaderLogo(
              text1: 'M',
              text2: '.',
            ),
            replacement: HeaderLogo(
              text1: 'MORN ',
              text2: 'MEY',
            ),
          ),
        ),
        actions: [
          ResponsiveVisibility(
            visible: true,
            hiddenWhen: [
              Condition.equals(name: DESKTOP),
              Condition.equals(name: TABLET),
            ],
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Globals.scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
          Header(
            itemScrollController: itemScrollController,
            itemList: itemList,
          ),
        ],
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        child: ScrollablePositionedList.builder(
          itemCount: itemList.length,
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemBuilder: (context, index) {
            return itemList[index];
          },
        ),
        onNotification: (scroll) => isTopNotif.value = scroll.metrics.pixels == 0,
      ),
    );
  }
}
