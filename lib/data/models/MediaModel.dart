import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/helper/snackbarDisplay.dart';

class Media {
  Media({
    this.id,
    this.media_type,
    this.name,
    this.fileName,
    this.mimeType,
    this.path,
    this.disk,
    this.collection,
    this.size,
  });

  int? id;
  String? media_type;
  String? name;
  String? fileName;
  String? mimeType;
  String? path;
  String? disk;
  String? collection;
  int? size;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        media_type: json["media_type"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: json["mime_type"],
        path: json["path"],
        disk: json["disk"],
        collection: json["collection"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? "" : id.toString(),
        "media_type": media_type ?? "",
        "name": name ?? "",
        "file_name": fileName ?? "",
        "mime_type": mimeType ?? "",
        "path": path ?? "",
        "disk": disk ?? "",
        "collection": collection ?? "",
        "size": size == null ? "" : size.toString(),
      };

  Future<Media> mediaStore(
      context, PlatformFile lFile, String whereToStore) async {
    Media _media = Media();

    try {
      List<int> fileBytes = lFile.bytes!;
      String name = lFile.name;

      FormData formData = FormData.fromMap(
          {"file": MultipartFile.fromBytes(fileBytes, filename: name)});
      ApiService apiService = ApiService();
      var body = toJson();
      apiService.uploadFile(
        url: '/media/${whereToStore}',
        formData: formData,
        context: context,
        body: body,
      );
      return _media;
    } catch (e) {
      debugPrint("Error in Media save :$e");
      return _media;
    }
    return _media;
  }

  Future<Media> mediaDownload(context) async {
    Media _media = Media();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/media/${id}', body: body, context: context);

      if (response.statusCode == 200) {
        // var tmp = json.decode(response.body);
        Directory? appDocDir = await getDownloadsDirectory();
        String? _path = await FilesystemPicker.openDialog(
            context: context,
            rootDirectory: appDocDir!,
            fsType: FilesystemType.folder,
            showGoUp: true);
        print(_path);
        if (_path == null) {
          snackbarwithMessage("No folder selected", context, 2);
          return _media;
        }

        File _file = await File("${_path}\\${fileName}").create();
        _file.writeAsBytes(response.bodyBytes);
        OpenAppFile.open(_file.path);
        debugPrint("Receive Media successful");
        snackbarwithMessage("File saved to: ${_path}", context, 1);
      } else {
        debugPrint(response.body);
        return _media;
      }
      return _media;
    } catch (e) {
      debugPrint("Error in save :$e");
      return _media;
    }
  }
}
