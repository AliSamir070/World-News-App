import 'package:news_app/shared/components/secured.dart';

class Constants{
  static String getSourcesCategorizedUrl(String category){
    return "https://newsapi.org/v2/top-headlines/sources?apiKey=${apiKey}&category=$category";
  }
  static String getArticlesSourceUrl(String sourceName , int page){
    return "https://newsapi.org/v2/everything?sources=$sourceName&apiKey=${apiKey}&page=$page";
  }
  static String getArticlesSourceQueyUrl(String sourceName,String query){
    return "https://newsapi.org/v2/everything?sources=$sourceName&apiKey=${apiKey}&q=$query";
  }
}