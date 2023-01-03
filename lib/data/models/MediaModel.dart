import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/helper/api_service.dart';
import 'package:http/http.dart' as http;

class Media {
  Media({
    this.id,
    this.mediaCategorieId,
    this.name,
    this.fileName,
    this.mimeType,
    this.path,
    this.disk,
    this.collection,
    this.size,
  });

  int? id;
  int? mediaCategorieId;
  String? name;
  String? fileName;
  String? mimeType;
  String? path;
  String? disk;
  dynamic? collection;
  int? size;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        mediaCategorieId: json["media_categorie_id"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: json["mime_type"],
        path: json["path"],
        disk: json["disk"],
        collection: json["collection"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "media_categorie_id": mediaCategorieId,
        "name": name,
        "file_name": fileName,
        "mime_type": mimeType,
        "path": path,
        "disk": disk,
        "collection": collection,
        "size": size,
      };

  Future<Media> mediaStore(context) async {
    Media _media = Media();
    try {
      var body = toJson();
      ApiService apiService = ApiService();
      http.Response response =
          await apiService.post(url: '/media', body: body, context: context);

      if (response.statusCode == 200) {
        debugPrint("Save Media success");
      } else {
        debugPrint(response.body);
        return _media;
      }
      return _media;
    } catch (e) {
      debugPrint("Error in Media save :$e");
      return _media;
    }
  }
}
