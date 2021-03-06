import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

import 'time_utils.dart';

class Client {
//  factory Client(String apiKey) {
//    if (_instance != null) {
//      return _instance;
//    }
//    _instance = Client._internal(apiKey);
//    return _instance;
//  }
  factory Client(String apiKey) {
    if (_instances.containsKey(apiKey)) {
      return _instances[apiKey];
    }
    _instances[apiKey] = Client._internal(apiKey);
    return _instances[apiKey];
  }

  Client._internal(this.apiKey);

  static const String apiUrl = 'https://api.amplitude.com/';
  static const String apiVersion = '2';
//  static Client _instance;
  static final Map<String, Client> _instances = {};

  final String apiKey;

  Future<int> post(List<Map<String, dynamic>> eventData) async {
    final String uploadTime = TimeUtils().currentTime().toString();
    final String events = json.encode(eventData);
    final String checksum = apiVersion + apiKey + events + uploadTime;
    final String md5 = crypto.md5.convert(utf8.encode(checksum)).toString();

    try {
      final response = await http.post(apiUrl, body: <String, String>{
        'client': apiKey,
        'e': events,
        'v': apiVersion,
        'upload_time': uploadTime,
        'checksum': md5
      });
      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }
}
