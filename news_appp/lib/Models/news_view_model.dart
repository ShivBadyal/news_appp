import 'package:news_appp/Models/categories_news_model.dart';
import 'package:news_appp/Models/news_channel_headlines_model.dart';
import 'package:news_appp/Repository/news_repository.dart';

class NewsViewModel {

  final _rep = NewsRepository();


  Future<NewsHeadlinesModel>fetchNewsChannelHeadlines(String newsChannel)async{

    final response = await _rep.fetchNewsChannelHeadlines(newsChannel);
    return response;

  }

    Future<CategoriesNewsModel>fetchCategoriesNewsApi(String category)async{

    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;

  }




}