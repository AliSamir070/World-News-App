import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:news_app/model/Source.dart';
import 'package:news_app/modules/article_view/article_view_screen.dart';
import 'package:news_app/shared/network/remote/http_helper.dart';

import '../../model/Article.dart';
import '../../model/ArticleResponse.dart';
import 'package:timeago/timeago.dart' as timeago;
class CategoryItem extends StatelessWidget {
  Color ItemColor;
  bool isLeft;
  String title;
  String image;
  CategoryItem({required this.title , required this.ItemColor , required this.isLeft , required this.image});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap:(){
        Navigator.pushNamed(context, title);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ItemColor,
          borderRadius: isLeft?BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
              :BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
        child: Column(
          children: [
            Image(
                image: AssetImage(image),
                height: height*0.15,
                width: width*0.3,
              ),
            SizedBox(height: 5,),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
class TabItem extends StatelessWidget {
  Source source;
  bool isSelected;
  TabItem({required this.source , required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        color: isSelected?Theme.of(context).primaryColor:Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected?Colors.transparent:Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: Text(
        source.name!,
        style: TextStyle(
          color: isSelected?Colors.white:Theme.of(context).primaryColor
        ),
      ),
    );
  }
}
class TabListItem extends StatefulWidget {
  Source source;
  TabListItem({required this.source});

  @override
  State<TabListItem> createState() => _TabListItemState();
}

class _TabListItemState extends State<TabListItem> {
  List<Article> articles = [];

  int page = 1;

  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if(_controller.position.atEdge){
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print("top");
        }else{
          print("bottom");
          page++;
          _controller.jumpTo(0);
          setState((){});
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<ArticleResponse?>(
          future: getArticlesOfSource(),
          builder: (context , snapShot){
            if(snapShot.hasError){
              return Text('Something wrong , please try again');
            }else if(snapShot.hasData){
              return ListView.builder(
                  itemBuilder: (context , index)=>ArticlesListItem(article: snapShot.data!.articles![index]),
                  itemCount: snapShot.data!.articles!.length,
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
              );
            }else if(snapShot.connectionState==ConnectionState.none){
              return Text('Something wrong , please try again ${snapShot.error}');
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }

  Future<ArticleResponse?> getArticlesOfSource()async{
    try{
      Response httpResponse = await HttpHelper.FetchSourcesArticles(widget.source.id!,page);
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
    print("Exception");
  }
}
class ArticlesListItem extends StatelessWidget {
  Article article;
  ArticlesListItem({required this.article});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, ArticleViewScreen.route,arguments: article);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
                height: height*0.3,
                width: width*0.5,
                imageUrl: article.urlToImage??'https://img.icons8.com/ios-glyphs/344/no-image.png',
                imageBuilder: (context,provider){
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: provider,fit: BoxFit.fill)
                    ),
                  );
                },
                placeholder: (context , url)=>Center(child: CircularProgressIndicator(),),
                errorWidget: (context , url,error)=>Center(child: Icon(Icons.broken_image),),
            ),
            SizedBox(height: 10,),
            Text(
              article.source?.name??'',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 10,),
            Text(
              article.title??"",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10,),
            Text(
              timeago.format(DateTime.parse(article.publishedAt!)),
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}



