import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    final request = MockHttpClientRequest(url.toString());
    return request;
  }
}

class MockHttpClientRequest extends Mock implements HttpClientRequest {
  final String url;
  MockHttpClientRequest(this.url);

  @override
  Future<HttpClientResponse> close() async {
    return MockHttpClientResponse();
  }
}

class MockHttpClientResponse extends Mock implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  String get reasonPhrase => 'OK';
  @override
  int get contentLength => 67;
  // Match mock image size
  Stream<List<int>> get data {
    final mockImage = base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==');
    return Stream.value(mockImage);
  }
}
