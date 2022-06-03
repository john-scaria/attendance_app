import 'dart:convert';

import 'package:http/http.dart' as http;

class FcmSendNotification {
  static Future<void> sendNotification({
    required List<String> fcmIdList,
    required String messageTitle,
    required String messageBody,
  }) async {
    try {
      final _headers = {
        'Authorization': 'key=AABBCCDDEEFF', //!Dummy Server Key!!
        'Content-Type': 'application/json'
      };
      final _uri = Uri.parse('https://fcm.googleapis.com/fcm/send');
      final _body = json.encode({
        "registration_ids": fcmIdList,
        "notification": {
          "body": messageBody,
          "title": messageTitle,
          "android_channel_id": "markey_fcm_channel"
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "sound": "default"
        }
      });
      await http.post(
        _uri,
        body: _body,
        headers: _headers,
      );
    } catch (e) {
      print(e);
    }
  }
}
