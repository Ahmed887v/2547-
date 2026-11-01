import 'dart:convert';
import 'dart:io';

/// Sends chat turns to the user's own SpeakLocal tutor backend.
///
/// Configure the endpoint at build time with:
/// --dart-define=SPEAKLOCAL_TUTOR_API_URL=https://your-domain.example/api/tutor/chat
/// The mobile app deliberately contains no provider API key. The backend owns
/// provider credentials, rate limits, safety checks and conversation policy.
class TutorChatService {
  TutorChatService({String? endpoint})
      : endpoint = endpoint ??
            const String.fromEnvironment('SPEAKLOCAL_TUTOR_API_URL');

  final String endpoint;

  Future<String> send({
    required List<Map<String, String>> history,
    required String message,
  }) async {
    if (endpoint.trim().isEmpty) {
      throw const TutorChatException(
        'لم يتم إعداد خادم المعلّم الذكي بعد. أضف SPEAKLOCAL_TUTOR_API_URL عند البناء.',
      );
    }

    final uri = Uri.tryParse(endpoint);
    if (uri == null || !uri.hasScheme ||
        (uri.scheme != 'https' && uri.scheme != 'http') ||
        uri.host.isEmpty) {
      throw const TutorChatException('عنوان خادم المعلّم غير صالح.');
    }

    final client = HttpClient()..connectionTimeout = const Duration(seconds: 15);
    try {
      final request = await client.postUrl(uri).timeout(
        const Duration(seconds: 20),
      );
      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      request.write(jsonEncode({
        'message': message,
        'history': history,
        'language': 'en',
        'mode': 'english_tutor',
      }));

      final response = await request.close().timeout(
        const Duration(seconds: 45),
      );
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw TutorChatException(
          'خادم المعلّم أعاد HTTP ${response.statusCode}. حاول لاحقًا.',
        );
      }

      final decoded = jsonDecode(body);
      if (decoded is! Map) {
        throw const TutorChatException('استجابة الخادم غير مفهومة.');
      }
      final reply = (decoded['reply'] ?? decoded['message'] ?? '').toString().trim();
      if (reply.isEmpty) {
        throw const TutorChatException('الخادم أرسل ردًا فارغًا.');
      }
      return reply;
    } on SocketException {
      throw const TutorChatException('تعذر الاتصال بخادم المعلّم. تحقق من الإنترنت.');
    } on HttpException {
      throw const TutorChatException('حدث خطأ في اتصال المعلّم.');
    } on FormatException {
      throw const TutorChatException('الخادم أرسل بيانات غير صالحة.');
    } finally {
      client.close(force: true);
    }
  }
}

class TutorChatException implements Exception {
  const TutorChatException(this.message);
  final String message;

  @override
  String toString() => message;
}
