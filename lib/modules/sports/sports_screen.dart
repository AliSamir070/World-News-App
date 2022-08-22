import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/model/Source.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/http_helper.dart';

class SportsScreen extends StatefulWidget {
  static String route = "Sports";

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  List<Source> sources = [];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (sources.isEmpty) {
      getSportsSources();
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
        ),
        Scaffold(
            appBar: AppBar(
              toolbarHeight: height * 0.1,
              title: Text('Sports'),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 20),
                  child: IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, SearchScreen.route,arguments: sources[currentIndex]);
                      },
                      icon: Icon(
                          Icons.search,
                          size: 30,
                      )
                  ),
                )
              ],
            ),
            body: sources.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : DefaultTabController(
                    length: sources.length,
                    child: Column(
                      children: [
                        TabBar(
                            indicatorColor: Colors.transparent,
                            padding: EdgeInsetsDirectional.only(top: 20),
                            onTap: (index){
                              currentIndex = index;
                              setState((){});
                            },
                            isScrollable: true,
                            tabs: sources.map((source){
                              return TabItem(source: source, isSelected: sources.indexOf(source)==currentIndex);
                            }).toList(),

                        ),
                        Expanded(
                            child: TabBarView(
                                children: sources.map((e) => TabListItem(source: e)).toList()
                            )
                        )
                      ],
                    ),
                  )),
      ],
    );
  }

  void getSportsSources() {
    try {
      HttpHelper.FetchCategorizedSources("sports").then((value) {
        SourceResponse response =
            SourceResponse.fromJson(jsonDecode(value.body));
        if (value.statusCode >= 200 && value.statusCode < 300) {
          sources = response.sources!;
          print("tesst");
          setState(() {});
        } else {
          Fluttertoast.showToast(
              msg: response.message!,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 16.0);
        }
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: "No Network Connection",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
}
