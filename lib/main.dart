import 'package:flutter/material.dart';
import 'package:news_app/modules/article_view/article_view_screen.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/environment/entertainment_screen.dart';
import 'package:news_app/modules/health/health_screen.dart';
import 'package:news_app/modules/politics/politics_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/styles/AppStyle.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppStyle.lightTheme,
      routes: {
        HomeScreen.route:(_)=>HomeScreen(),
        BusinessScreen.route:(_)=>BusinessScreen(),
        EntertainmentScreen.route:(_)=>EntertainmentScreen(),
        HealthScreen.route:(_)=>HealthScreen(),
        PoliticsScreen.route:(_)=>PoliticsScreen(),
        ScienceScreen.route:(_)=>ScienceScreen(),
        SportsScreen.route:(_)=>SportsScreen(),
        SettingsScreen.route:(_)=>SettingsScreen(),
        SearchScreen.route:(_)=>SearchScreen(),
        ArticleViewScreen.route:(_)=>ArticleViewScreen()
      },
      initialRoute: HomeScreen.route,
    );
  }
}


