import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_helpful_toolbox/data/models/OfferListItemModel.dart';
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
    this.items,
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
  List<OfferlistItem>? items;

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
        items: List<OfferlistItem>.from(
            json["items"].map((x) => OfferlistItem.fromJson(x))),
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
    Media media = Media();

    try {
      List<int> fileBytes = lFile.bytes!;
      String name = lFile.name;

      FormData formData = FormData.fromMap(
          {"file": MultipartFile.fromBytes(fileBytes, filename: name)});
      ApiService apiService = ApiService();
      var body = toJson();
      apiService.uploadFile(
        url: '/media/$whereToStore',
        formData: formData,
        context: context,
        body: body,
      );
      return media;
    } catch (e) {
      debugPrint("Error in Media save :$e");
      return media;
    }
  }

  Future<Media> mediaDownload(context) async {
    Media media = Media();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response = await apiService.post(
          url: '/media/$id', body: body, context: context);

      if (response.statusCode == 200) {
        // var tmp = json.decode(response.body);
        Directory? appDocDir = await getDownloadsDirectory();
        String? path = await FilesystemPicker.openDialog(
            context: context,
            rootDirectory: appDocDir!,
            fsType: FilesystemType.folder,
            showGoUp: true);
        if (path == null) {
          snackbarwithMessage("No folder selected", context, 2);
          return media;
        }

        File file = await File("$path\\$fileName").create();
        file.writeAsBytes(response.bodyBytes);
        OpenAppFile.open(file.path);
        debugPrint("Receive Media successful");
        snackbarwithMessage("File saved to: $path", context, 1);
      } else {
        debugPrint(response.body);
        return media;
      }
      return media;
    } catch (e) {
      debugPrint("Error in save :$e");
      return media;
    }
  }

  Future<bool> mediaDelete(context, String whereToStore) async {
    try {
      ApiService apiService = ApiService();
      http.Response response = await apiService.delete(
          url: '/media/$whereToStore/$id', context: context);

      if (response.statusCode == 200) {
        debugPrint("Delete Media successful");
        snackbarwithMessage("Media Deleted", context, 1);
        return true;
      } else {
        debugPrint("Error in Server delete Media");
        snackbarwithMessage("Error in Server delete Media", context, 1);
        return false;
      }
    } catch (e) {
      debugPrint("Error in save :$e");
      return false;
    }
  }
}
