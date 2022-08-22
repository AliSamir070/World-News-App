import 'package:http/http.dart' as http;

import '../../components/constants.dart';
class HttpHelper{
  static Future<http.Response> FetchCategorizedSources(String category){
    return http.get(Uri.parse(Constants.getSourcesCategorizedUrl(category)));
  }
  static Future<http.Response> FetchSourcesArticles(String sourceName,int page){
    return http.get(Uri.parse(Constants.getArticlesSourceUrl(sourceName,page)));
  }
  static Future<http.Response> FetchSourcesArticlesWithQuery(String sourceName,String query){
    return http.get(Uri.parse(Constants.getArticlesSourceQueyUrl(sourceName, query)));
  }
}