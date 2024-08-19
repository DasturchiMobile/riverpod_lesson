import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    @JsonKey(defaultValue: "", name: "status")
    String? status,
    @JsonKey(defaultValue: 0,name: "totalResults")
    int? totalResults,
    @JsonKey(defaultValue: [],name: "articles")
    List<Article>? articles,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);
}

@freezed
class Article with _$Article {
  const factory Article({
    @JsonKey(name: "source")
    Source? source,
    @JsonKey(defaultValue: "",name: "author")
    String? author,
    @JsonKey(defaultValue: "",name: "title")
    String? title,
    @JsonKey(defaultValue: "",name: "description")
    String? description,
    @JsonKey(defaultValue: "",name: "url")
    String? url,
    @JsonKey(defaultValue: "https://i.ytimg.com/vi/0QiHn1oAnMA/hqdefault.jpg",name: "urlToImage")
    String? urlToImage,
    @JsonKey(defaultValue: "",name: "publishedAt")
    String? publishedAt,
    @JsonKey(defaultValue: "",name: "content")
    String? content,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

@freezed
class Source with _$Source {
  const factory Source({
    @JsonKey(defaultValue: "",name: "id")
    String? id,
    @JsonKey(defaultValue: "",name: "name")
    String? name,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
