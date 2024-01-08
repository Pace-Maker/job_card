import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:job_card/core/schemas/files_scheams.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:graphql_config/graphql_config.dart';
// ignore: depend_on_referenced_packages
import 'package:secure_storage/secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import '../../../widgets/build_snackbar.dart';
// ignore: depend_on_referenced_packages
import 'package:open_file_plus/open_file_plus.dart';

class JobCardServices {
  Future<void> openJobCard(
    int jobId, {
    required String fileType,
    required BuildContext context,
    required String? preference,
  }) async {
    UserDataSingleton userData = UserDataSingleton();

    showAdaptiveDialog(
      context: context,
      builder: (context) => Dialog(

          // insetPadding: EdgeInsets.symmetric(horizontal: 10.sp),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator.adaptive(),
                SizedBox(
                  width: 5.sp,
                ),
                const Text(
                  "File is loading, please wait...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
    );

    var result = await GrapghQlClientServices().performQuery(
      query: FilesSchemas.jobCardReport,
      variables: {
        "data": {
          "reportTitle": "Breakdown Job Card",
          "app": "Nectar Assets",
          "brand": userData.domain,
          "client": "Nectar",
          "reportDate": DateTime.now().millisecondsSinceEpoch,
          "jobId": jobId,
          "reportType": fileType,
          "preference": preference,
        }
      },
    );

    if (result.hasException) {
      print(result.exception);
      if (context.mounted) {
        buildSnackBar(
          context: context,
          value: "Something went wrong. Please try again",
        );

        Navigator.of(context).pop();
      }
      return;
    }

    String? data = result.data?['jobCardReport']?['data'];
    String? fileName = result.data?['jobCardReport']?['fileName'];

    if (data == null) {
      if (context.mounted) {
        buildSnackBar(
          context: context,
          value: "File not found",
        );
        Navigator.of(context).pop();
      }

      return;
    }

    Uint8List decodedbytes = base64Decode(data);

    final directory = await getApplicationDocumentsDirectory();

    File file =
        await File("${directory.path}/$fileName.${getFileExtension(fileType)}")
            .writeAsBytes(decodedbytes);

    if (context.mounted) {
      if (!file.existsSync()) {
        buildSnackBar(
          context: context,
          value: "File not found",
        );
        return;
      }

      // FileServices().openFile(file, context);
      OpenFile.open(file.path);

      Navigator.of(context).pop();
    }
  }

// /  ================================================
// Get file Extension

  String getFileExtension(String type) {
    switch (type) {
      case "PDF":
        return "pdf";

      case "EXCEL":
        return "xlsx";

      default:
        return "";
    }
  }
}
