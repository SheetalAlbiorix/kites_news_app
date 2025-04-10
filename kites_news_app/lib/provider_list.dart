import 'package:kites_news_app/src/core/utils/injections.dart';
import 'package:kites_news_app/src/features/articles/domain/repositories/abstract_articles_repository.dart';
import 'package:kites_news_app/src/features/articles/presentation/notifiers/ArticlesNotifier.dart';
import 'package:kites_news_app/src/features/news/domain/repositories/abstract_news_repository.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/NewsNotifier.dart';

ArticlesNotifier get articlesProvider =>
    ArticlesNotifier(articlesRepository: sl<AbstractArticlesRepository>());

NewsNotifier get newsProvider =>
    NewsNotifier(newsRepository: sl<AbstractNewsRepository>());
