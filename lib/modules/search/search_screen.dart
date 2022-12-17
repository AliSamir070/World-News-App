import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:news_app/modules/news_viewModel.dart';
import 'package:news_app/modules/search/search_viewModel.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/api_manager.dart';
import 'package:news_app/shared/network/remote/http_helper.dart';
import 'package:news_app/shared/network/repository/data_source/news_api_repo.dart';

import '../../model/ArticleResponse.dart';
import '../../model/Source.dart';

class SearchScreen extends StatefulWidget {
  static String route = "search_screen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  SearchViewModel searchViewModel = SearchViewModel(newsRepository: NewsApiRepo());
  @override
  Widget build(BuildContext context) {
    Source source = ModalRoute.of(context)!.settings.arguments as Source;
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
              automaticallyImplyLeading: false,
              title: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  onChanged: (text){
                    query = text;
                    setState((){

                    });
                  },
                  style:Theme.of(context).textTheme.titleSmall ,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          FocusScope.of(context).requestFocus(new FocusNode());
                          ApiManager.getQueriedArticles(source , query);
                        },
                        icon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                        )
                    ),
                    prefixIcon: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).primaryColor,
                        )
                    ),
                    contentPadding: EdgeInsetsDirectional.all(16),
                    filled: true,
                    hintText: 'Search article',
                    hintStyle: Theme.of(context).textTheme.displaySmall,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    )
                  ),
                ),
              ),

            ),
            body: Container(
              padding: EdgeInsetsDirectional.all(16),
              child: FutureBuilder<ArticleResponse?>(
                  future: searchViewModel.NewsSearch(source , query),
                  builder: (context , snapshot){
                    if(snapshot.hasError){
                      return Text('Something went wrong, please try again');
                    }else if(snapshot.connectionState==ConnectionState.none){
                      return Text('Something went wrong, please try again');
                    }else if(snapshot.hasData){
                      return snapshot.data!.articles!.length>0?ListView.builder(
                          itemBuilder: (context,index)=>ArticlesListItem(article: snapshot.data!.articles![index]),
                          itemCount: snapshot.data!.articles!.length,
                          physics: BouncingScrollPhysics(),
                      ):Center(child:Text(
                        'No articles',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ));
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }

              ),
            ),
        ),
      ],
    );
  }


}
