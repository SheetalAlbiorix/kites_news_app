import 'package:flutter/foundation.dart';

import '../network/response.dart';

abstract class baseNotify extends ChangeNotifier {
  bool isProcessingCompleted = false;
  bool isProcessingStarted = false;
  bool isTimeOut = false;
  bool isError = false;
  bool isProcessingFailed = false;

  void processingStarted() {
    isProcessingStarted = true;

    isProcessingCompleted = false;
    isTimeOut = false;
    isProcessingFailed = false;

    notifyListeners();
  }

  void processingCompleted() {
    isProcessingStarted = false;
    isProcessingCompleted = true;
    isTimeOut = false;
    isProcessingFailed = false;

    notifyListeners();
  }

  void timeOut() {
    isProcessingStarted = false;
    isProcessingCompleted = false;
    isTimeOut = true;
    isProcessingFailed = true;
    notifyListeners();
  }

  void processingFailed() {
    isProcessingStarted = false;
    isProcessingCompleted = false;
    isTimeOut = false;
    isProcessingFailed = true;
    notifyListeners();
  }
}

class BaseNotifier extends ChangeNotifier {
  apiResIsLoading(BaseApiResponse res) {
    res.status = Status.loading;

    notifyListeners();
  }

  apiResIsSuccess<T>(BaseApiResponse res, T data) {
    res.status = Status.completed;

    res.data = data;

    notifyListeners();
  }

  apiResIsFailed(BaseApiResponse res, Object e) {
    res.status = Status.error;

    res.message = e.toString();

    notifyListeners();
  }

  apiResIsUnAuthorise(BaseApiResponse res, Object e) {
    res.status = Status.unAuthorized;

    res.message = e.toString();

    notifyListeners();
  }
}
