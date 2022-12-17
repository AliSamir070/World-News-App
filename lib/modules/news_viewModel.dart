import 'package:news_app/model/ArticleResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/shared/network/repository/news_repository.dart';

class NewsViewModel{
  NewsRepository? newsRepository;
  NewsViewModel({this.newsRepository});

  Future<ArticleResponse?> NewsArticleSource(String sourceId , int page)async{
    return await newsRepository?.getArticlesOfSource(sourceId: sourceId , page: page);
  }
  Future<SourceResponse?> NewsCategorySource(String category)async{
    return await newsRepository?.getCategorySources(category);
  }
}