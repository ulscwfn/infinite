import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// 七牛云上传
class UploadImageQiNiu {
  final Dio dio = Dio();

  /// 浏览地址
  final String browseUrl;

  /// 命名空间
  final String namespace;

  /// 图片上传地址
  final String uploadUrl;

  UploadImageQiNiu({
    @required this.browseUrl,
    @required this.namespace,
    this.uploadUrl = 'https://up-z2.qiniup.com/',
  });

  ///  上传
  Future<UploadImageMessage> upload({
    @required File file,
    @required String tokenUrl,
  }) async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String fileName = '$namespace$timeStamp.png';
    String token = await _getQiniuToken(fileName, tokenUrl);

    return _upload(file, fileName, token);
  }

  /// 获取 token
  Future<String> _getQiniuToken(String filename, String url) async {
    var token = await dio.post('path', data: {'filename': filename});
    return token.data['qiniuToken'] as String;
  }

  /// 上传图片
  Future<UploadImageMessage> _upload(
    File file,
    String fileName,
    String token,
  ) async {
    String path = file.path;
    Map<String, dynamic> result;
    String name = path.substring(path.lastIndexOf("/") + 1, path.length);

    /// 根据图片地址+图片名称，把图片转Stream流
    var fromFile = await MultipartFile.fromFile(path, filename: name);

    /// 提交数据转换 formData 类型
    FormData formData = FormData.fromMap({
      "token": token,
      "key": fileName,
      "file": fromFile,
    });

    try {
      Response response = await dio.post(uploadUrl, data: formData);
      result = {
        'type': 0,
        'message': "上传成功",
        'url': '$browseUrl/${response.data['key']}'
      };
    } catch (e) {
      result = {'type': 1, 'message': "上传成功"};
      debugPrint(e.toString());
    }

    return UploadImageMessage.to(result);
  }
}

class UploadImageMessage {
  int type;
  String message;
  String url;

  // UploadImageMessage({this.type, this.message, this.url});

  UploadImageMessage.to(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    url = json['url'];
  }
}
