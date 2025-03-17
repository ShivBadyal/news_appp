import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_appp/Models/categories_news_model.dart';
import 'package:news_appp/Models/news_channel_headlines_model.dart';

class NewsRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://newsapi.org/v2/',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
  ));

  final String apiKey = '0fbb06d460184be48134cba78f6b9356'; // Store safely in env file

  // Fetch News Channel Headlines
  Future<NewsHeadlinesModel> fetchNewsChannelHeadlines(String newsChannel) async {
    try {
      final response = await _dio.get(
        'top-headlines',
        queryParameters: {
          'sources': newsChannel,
          'apiKey': apiKey,
        },
      );

      if (kDebugMode) {
        print(response.data);
      }

      return NewsHeadlinesModel.fromJson(response.data);
    } catch (e) {
      print('Error fetching news: $e');
      throw Exception('Failed to fetch news');
    }
  }

  // Fetch News by Category
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    try {
      final response = await _dio.get(
        'everything',
        queryParameters: {
          'q': category,
          'apiKey': apiKey,
        },
      );

      if (kDebugMode) {
        print(response.data);
      }

      return CategoriesNewsModel.fromJson(response.data);
    } catch (e) {
      print('Error fetching category news: $e');
      throw Exception('Failed to fetch category news');
    }
  }
}
