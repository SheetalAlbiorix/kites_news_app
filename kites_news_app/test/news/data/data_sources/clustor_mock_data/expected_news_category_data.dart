import 'package:kites_news_app/src/features/news/domain/models/category_response.dart';

import 'actual_news_category_json.dart';

CategoryResponse apiModelEmptyClusterListData = CategoryResponse.fromJson(
  apiEmptyClusterJson,
);

CategoryResponse apiModelClusterListData = CategoryResponse.fromJson(apiClusterListJson);
