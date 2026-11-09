import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Answer of a [RecordingHttpAdapter]: an HTTP status and a JSON body.
typedef FakeResponse = ({int status, Object? body});

/// Decides the answer to [options], e.g. by `options.path`.
typedef FakeResponder = FakeResponse Function(RequestOptions options);

/// Dio adapter that records every request and answers from a [FakeResponder],
/// so tests can check what a data source sends without a server.
class RecordingHttpAdapter implements HttpClientAdapter {
  /// Creates a [RecordingHttpAdapter] answering with [respond], or an empty
  /// successful envelope when it is `null`.
  RecordingHttpAdapter([FakeResponder? respond])
    : _respond = respond ?? _emptySuccess;

  final FakeResponder _respond;

  /// Requests received so far, in order.
  final requests = <RequestOptions>[];

  /// Body of the last request sent to [path] as a JSON object.
  Map<String, dynamic> bodyOf(String path) {
    final request = requests.lastWhere((request) => request.path == path);
    return Map<String, dynamic>.from(request.data as Map<dynamic, dynamic>);
  }

  static FakeResponse _emptySuccess(RequestOptions options) =>
      (status: 200, body: {'success': true, 'data': <String, dynamic>{}});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final response = _respond(options);
    if (response.status == 204) return ResponseBody.fromString('', 204);
    return ResponseBody.fromString(
      jsonEncode(response.body),
      response.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// Successful `{ success, data }` answer carrying [data].
FakeResponse successOf(Object? data, {int status = 200}) =>
    (status: status, body: {'success': true, 'data': data});

/// Error answer in the format of the API.
FakeResponse errorOf(int status, String code, {Object? details}) => (
  status: status,
  body: {
    'success': false,
    'error': {
      'statusCode': status,
      'code': code,
      'message': 'debug text',
      'details': ?details,
    },
    'path': '/api/v1/test',
    'timestamp': '2026-10-13T00:00:00.000Z',
  },
);
