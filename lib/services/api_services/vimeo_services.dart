import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:get/get.dart';


import '../../controller/main_controllers/meta_data_controller.dart';

class VimeoUploader {
  // Replace with your actual client ID and secret
  final String clientId = '2b5f201509c79598d173b84dba2ae25d7ed66354';
  final String clientSecret = 'WXFqHLB4b8BrULmB0qVo/eRJzk6Np6adYo+3SQ8iV2t1ZiKFcFUOmIKXpjb28+w8JmyOpfaFoI361aRvwFf4T+GMI2qFyPq4aTb0K/D5/9uuvRlSS4mWJdx2PyTR7+HT';

  String? _accessToken;

  /// Generate Access Token using Client Credentials Grant (limited scope, can't upload)
  Future<String?> generateAccessToken() async {
    final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));

    final response = await http.post(
      Uri.parse('https://api.vimeo.com/oauth/authorize/client'),
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.vimeo.*+json;version=3.4',
      },
      body: jsonEncode({'grant_type': 'client_credentials', 'scope': 'public'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
      // setAccessToken(_accessToken??"");
      print('✅ Access token generated: $_accessToken');

      return _accessToken;
      // final metDataController = Get.put(MetaDataController());
      //
      // VimeoUploader().uploadVideo(File(metDataController.videPath.value));

    } else {
      throw Exception('❌ Failed to get access token: ${response.body}');
    }
  }

  /// Upload video using TUS protocol (requires user-authenticated token)
  Future<void> uploadVideo(File videoFile, {String title = "My Video"}) async {

    // if (_accessToken == null) {
    //   throw Exception('⚠️ Access token is null. Call generateAccessToken() or set a valid token manually.');
    // }

    final fileSize = await videoFile.length();
    final mimeType = lookupMimeType(videoFile.path) ?? 'video/mp4';
    var header = {
      'Authorization': 'bearer e80e2b663a36356c9ddf80524e5b0310',
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.vimeo.*+json;version=3.4',
    };
    log("header "+header.toString());

    // 1. Create video container (upload ticket)
    final createResponse = await http.post(
      Uri.parse('https://api.vimeo.com/me/videos'),
      headers: header,
      body: jsonEncode({
        'upload': {'approach': 'tus', 'size': fileSize.toString()},
        'name': title,
      }),
    );

    if (createResponse.statusCode != 200 && createResponse.statusCode != 201) {
      throw Exception('❌ Failed to create Vimeo upload ticket: ${createResponse.body}');
    }

    final uploadLink = jsonDecode(createResponse.body)['upload']['upload_link'];
    print('📤 Upload link: $uploadLink');

    // 2. Upload video using TUS protocol
    final videoBytes = await videoFile.readAsBytes();
    final uploadResponse = await http.patch(
      Uri.parse(uploadLink),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': mimeType,
        'Tus-Resumable': '1.0.0',
        'Upload-Offset': '0',
        'Content-Length': videoBytes.length.toString(),
      },
      body: videoBytes,
    );

    if (uploadResponse.statusCode != 204) {
      throw Exception('❌ Failed to upload video to Vimeo: ${uploadResponse.body}');
    }

    print("✅ Upload complete");
  }

  /// Optional: Set token manually if you're using a pre-generated user token
  void setAccessToken(String token) {
    _accessToken = token;
  }
}
