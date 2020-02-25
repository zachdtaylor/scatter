import 'package:flutter/cupertino.dart';

import 'package:scatter/pages/insights/insights_page.dart';
import 'package:scatter/pages/sprint/sprint_page.dart';
import 'package:scatter/pages/timeline/timeline_page.dart';

class Home extends StatelessWidget {

  Widget _tabBuilder(context, index) {
    switch (index) {
      case 0:
        return CupertinoTabView(
          builder: (context) => InsightsPage() 
        ); 
        break;
      case 1:
        return CupertinoTabView(
          builder: (context) => SprintPage()
        );
        break;
      case 2:
        return CupertinoTabView(
          builder: (context) => TimelinePage()
        );
        break;
      default:
        return CupertinoTabView(
          builder: (context) => InsightsPage()
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), title: Text('Insights')
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.time), title: Text('Sprint')
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book), title: Text('Timeline')
          )
        ],
      ),
      tabBuilder: _tabBuilder
    );
  }
}