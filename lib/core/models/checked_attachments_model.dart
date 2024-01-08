// To parse this JSON data, do
//
//     final CheckedAttachmentModel = checkedAttachmentFromJson(jsonString);

import 'dart:convert';

List<CheckedAttachmentModel> checkedAttachmentModelFromJson(List list) =>
    List<CheckedAttachmentModel>.from(
        list.map((x) => CheckedAttachmentModel.fromJson(x)));

String checkedAttachmentModelToJson(List<CheckedAttachmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckedAttachmentModel {
  String? fileName;
  String? mimeType;
  String? type;
  String? path;
  String? uploadedTime;

  CheckedAttachmentModel({
    this.fileName,
    this.mimeType,
    this.type,
    this.path,
    this.uploadedTime,
  });

  factory CheckedAttachmentModel.fromJson(Map<String, dynamic> json) =>
      CheckedAttachmentModel(
        fileName: json["fileName"],
        mimeType: json["mimeType"],
        type: json["type"],
        path: json["path"],
        uploadedTime: json['uploadedTime'],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "mimeType": mimeType,
        "type": type,
        "path": path,
        "uploadedTime": uploadedTime,
      };
}
