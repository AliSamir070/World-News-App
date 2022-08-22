import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/Article.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
class ArticleViewScreen extends StatelessWidget {
  static String route = "ArticleScreen";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Article article = ModalRoute.of(context)!.settings.arguments as Article;
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
      ),
      Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.1,
          title: Text('Sports'),
        ),
        body: Container(
          margin: EdgeInsetsDirectional.only(top: 20),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  CachedNetworkImage(
                    height: height*0.4,
                    width: double.infinity,
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
                  Padding(
                    padding: EdgeInsetsDirectional.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          article.source?.name??'',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          article.title??"",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          timeago.format(DateTime.parse(article.publishedAt!)),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          article.description??"",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                if(article.url!=null){
                                  launchUrl(Uri.parse(article.url??''));
                                }
                              },
                              child: Text(
                                'View article',
                                style: Theme.of(context).textTheme.labelLarge,

                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                                Icons.arrow_right
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        ),
      )
    ]);
  }
}
