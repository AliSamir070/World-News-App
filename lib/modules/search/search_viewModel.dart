import 'package:news_app/model/Source.dart';
import 'package:news_app/shared/network/repository/news_repository.dart';

class SearchViewModel{
  NewsRepository? newsRepository;
  SearchViewModel({this.newsRepository});

  NewsSearch(Source source , String query)async{
    return await newsRepository?.getQueriedArticles(source: source , query: query);
  }
}