import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:news_app/model/ArticleResponse.dart';
import 'package:news_app/model/Source.dart';
import 'package:news_app/model/SourceResponse.dart';

import '../../remote/http_helper.dart';
import '../news_repository.dart';

class NewsApiRepo extends NewsRepository{
  @override
  Future<ArticleResponse?> getArticlesOfSource({String? sourceId, int? page})async {
    try{
      Response httpResponse = await HttpHelper.FetchSourcesArticles(sourceId!,page!);
      ArticleResponse response = ArticleResponse.fromJson(jsonDecode(httpResponse.body));
      if(httpResponse.statusCode>=200 && httpResponse.statusCode<300 ){
        return response;

      }else{
        throw Exception(response.message!);
      }
    }on Exception catch(e){
      Fluttertoast.showToast(
          msg: "No Network Connection",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  Future<SourceResponse?> getCategorySources(String category) async{
    try {
      return await HttpHelper.FetchCategorizedSources(category).then((value)async{
        SourceResponse response =
        SourceResponse.fromJson(jsonDecode(value.body));
        if (value.statusCode >= 200 && value.statusCode < 300) {
          print("sds");
          print(response.sources![0].name);
          return response;
        } else {
          print("sdserr");
          Fluttertoast.showToast(
              msg: response.message!,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 16.0);
          return null;
        }
      });
    } on Exception catch (e) {
      print("sdsrttg");
      Fluttertoast.showToast(
          msg: "No Network Connection",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<ArticleResponse?> getQueriedArticles({Source? source, String? query})async {
    try{
      Response httpResponse = await HttpHelper.FetchSourcesArticlesWithQuery(source!.id!, query!);
      ArticleResponse articleResponse = ArticleResponse.fromJson(jsonDecode(httpResponse.body));
      if(httpResponse.statusCode>=200 && httpResponse.statusCode<300){
        return articleResponse;
      }else{
        throw Exception(articleResponse.message);
      }
    }on Exception catch(e){
      Fluttertoast.showToast(
          msg: "No Network Connection",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

}