import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lesson_one/config/data/notifier/fetch_news_notifier.dart';

void main() {
  runApp(
    ProviderScope(
        child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsData = ref.watch(fetchNewsNotifierProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('UI Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: newsData.when(
              data: (data){
                return RefreshIndicator(
                  onRefresh: () async{
                    ref.read(fetchNewsNotifierProvider.notifier).refresh();
                  },
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final dataPost = data.articles?[index];
                      return  PostItem(
                        imageUrl: dataPost?.urlToImage ?? '',
                        author: dataPost?.author ?? "",
                        description: dataPost?.description ?? "",
                      );
                    },
                    itemCount: data.articles?.length ?? 0,

                  ),
                );
              },
              error: (error, stackTree){
                return Text(error.toString());
              },
              loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final String imageUrl;
  final String author;
  final String description;

  PostItem({
    required this.imageUrl,
    required this.author,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(imageUrl),
        SizedBox(height: 8),
        Text(
          author,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(description),
      ],
    );
  }
}

