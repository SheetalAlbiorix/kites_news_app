import 'package:kites_news_app/src/features/news/domain/repositories/abstract_news_repository.dart';
import 'package:kites_news_app/src/features/news/presentation/notifiers/NewsNotifier.dart';

import 'main.dart';

NewsNotifier get newsProvider =>
    NewsNotifier(newsRepository: sl<AbstractNewsRepository>());
