import 'package:news_app/model/ArticleResponse.dart';
import 'package:news_app/model/Source.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/shared/network/repository/news_repository.dart';

class NewsLocalRepo extends NewsRepository{
  @override
  Future<ArticleResponse?> getArticlesOfSource({String? sourceId, int? page}) {
    // TODO: implement getArticlesOfSource
    throw UnimplementedError();
  }

  @override
  Future<SourceResponse?> getCategorySources(String category) {
    // TODO: implement getCategorySources
    throw UnimplementedError();
  }

  @override
  Future<ArticleResponse?> getQueriedArticles({Source? source, String? query}) {
    // TODO: implement getQueriedArticles
    throw UnimplementedError();
  }
  
}