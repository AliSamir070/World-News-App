import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/Source.dart';
import '../../model/SourceResponse.dart';
import '../../shared/components/components.dart';
import '../../shared/network/remote/http_helper.dart';
import '../search/search_screen.dart';

class HealthScreen extends StatefulWidget {
  static String route = "Health";

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  List<Source> sources = [];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (sources.isEmpty) {
      getHealthSources();
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/background.png'),fit: BoxFit.cover)
          ),
        ),
        Scaffold(
          appBar: AppBar(
            toolbarHeight: height*0.1,
            title: Text(
                'Health'
            ),
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
          ),
        ),
      ],
    );
  }

  void getHealthSources() {
    try {
      HttpHelper.FetchCategorizedSources("health").then((value) {
        SourceResponse response =
        SourceResponse.fromJson(jsonDecode(value.body));
        if (value.statusCode >= 200 && value.statusCode < 300) {
          sources = response.sources!;
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
