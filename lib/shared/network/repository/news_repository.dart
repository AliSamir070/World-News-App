import '../../../model/ArticleResponse.dart';
import '../../../model/Source.dart';
import '../../../model/SourceResponse.dart';

abstract class NewsRepository{
  Future<SourceResponse?> getCategorySources(String category);
  Future<ArticleResponse?> getArticlesOfSource({String? sourceId , int? page});
  Future<ArticleResponse?> getQueriedArticles({Source? source , String? query});
}