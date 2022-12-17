import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/Source.dart';
import '../../model/SourceResponse.dart';
import '../../shared/components/components.dart';
import '../../shared/network/remote/api_manager.dart';
import '../../shared/network/remote/http_helper.dart';
import '../../shared/network/repository/data_source/news_api_repo.dart';
import '../news_viewModel.dart';
import '../search/search_screen.dart';

class PoliticsScreen extends StatefulWidget {
  static String route = "Politics";

  @override
  State<PoliticsScreen> createState() => _PoliticsScreenState();
}

class _PoliticsScreenState extends State<PoliticsScreen> {
  List<Source> sources = [];
  int currentIndex = 0;
  NewsViewModel newsViewModel = NewsViewModel(newsRepository: NewsApiRepo());
  @override
  Widget build(BuildContext context) {
    if (sources.isEmpty) {
      newsViewModel.NewsCategorySource("general").then((value) {
        if(value!=null){
          sources = value.sources!;
          setState((){});
        }
      });
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
                'Politics'
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

}
