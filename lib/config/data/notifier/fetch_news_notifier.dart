import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/news_model.dart';
import '../repository/news_fetch_repo.dart';


part 'fetch_news_notifier.g.dart';

@riverpod
class FetchNewsNotifier extends _$FetchNewsNotifier {
  @override
  FutureOr<NewsModel> build() async {
    return NewsFetchRepo().fetchNews();
  }

  void refresh() async{
    state = AsyncLoading();
    try{
      state = AsyncData(await NewsFetchRepo().fetchNews());
    }catch(e, stackTrace){
      state = AsyncError(e, stackTrace);
    }
  }
}