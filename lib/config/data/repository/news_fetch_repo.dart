import 'package:riverpod_lesson_one/config/data/model/news_model.dart';
import 'package:riverpod_lesson_one/config/network/api_provider.dart';

class NewsFetchRepo {
  Future<NewsModel> fetchNews() async {
    final request = await ApiClient().getMethod(pathUrl: "everything?q=tesla&from=2024-07-19&sortBy=publishedAt&apiKey=2996abecbbfd43e2850857ecbae60ff3", isHeader: false);
    return NewsModel.fromJson(request.response);
  }
}