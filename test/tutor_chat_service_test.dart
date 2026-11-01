import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:speak_english/services/tutor_chat_service.dart';

void main() {
  group('TutorChatService', () {
    test('requires a configured endpoint instead of fabricating a reply', () async {
      final service = TutorChatService(endpoint: '');
      await expectLater(
        service.send(history: const [], message: 'Hello'),
        throwsA(isA<TutorChatException>()),
      );
    });

    test('sends the conversation and returns the backend reply', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));

      server.listen((request) async {
        final body = await utf8.decoder.bind(request).join();
        final payload = jsonDecode(body) as Map<String, dynamic>;
        expect(payload['message'], 'I went to school yesterday.');
        expect(payload['language'], 'en');
        expect(payload['mode'], 'english_tutor');
        expect(payload['history'], [
          {'role': 'user', 'content': 'Hello'}
        ]);
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(jsonEncode({'reply': 'Good use of the past tense!'}));
        await request.response.close();
      });

      final service = TutorChatService(
        endpoint: 'http://127.0.0.1:${server.port}/chat',
      );
      final reply = await service.send(
        history: const [
          {'role': 'user', 'content': 'Hello'}
        ],
        message: 'I went to school yesterday.',
      );
      expect(reply, 'Good use of the past tense!');
    });

    test('rejects a non-success backend response', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) async {
        request.response
          ..statusCode = HttpStatus.serviceUnavailable
          ..write('unavailable');
        await request.response.close();
      });
      final service = TutorChatService(
        endpoint: 'http://127.0.0.1:${server.port}/chat',
      );
      await expectLater(
        service.send(history: const [], message: 'Hi'),
        throwsA(isA<TutorChatException>()),
      );
    });
  });
}
