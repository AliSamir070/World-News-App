import 'Source.dart';

/// source : {"id":"engadget","name":"Engadget"}
/// author : "Jon Fingas"
/// title : "Discovery+ is the new home for CNN originals following CNN+ shutdown"
/// description : "Discovery+ now has a hub for CNN originals — the ones you were supposed to be watching on CNN+ before it collapsed."
/// url : "https://www.engadget.com/discovery-plus-cnn-originals-hub-150546550.html"
/// urlToImage : "https://s.yimg.com/ny/api/res/1.2/PvwYR4HmgHaAN9MjktTYYA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://s.yimg.com/os/creatr-uploaded-images/2022-08/9f9e5ef0-1fc8-11ed-8bfe-157c22b4505f"
/// publishedAt : "2022-08-19T15:05:46Z"
/// content : "The short life of CNN+ left its parent network without an official home for original shows, but the broadcaster now appears to have a makeshift solution. Discovery+ has launched a CNN Originals hub t… [+1147 chars]"

class Article {
  Article({
      this.source, 
      this.author, 
      this.title, 
      this.description, 
      this.url, 
      this.urlToImage, 
      this.publishedAt, 
      this.content,});

  Article.fromJson(dynamic json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (source != null) {
      map['source'] = source?.toJson();
    }
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['urlToImage'] = urlToImage;
    map['publishedAt'] = publishedAt;
    map['content'] = content;
    return map;
  }

}