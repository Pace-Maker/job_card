// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:job_card/utils/themes/colors.dart';
import 'package:sizer/sizer.dart';

import '../core/services/theme/theme_services.dart';

class FilesCardWidget extends StatelessWidget {
  final String data;
  final BuildContext context;
  final String extension;
  final String fileName;
  final bool isCommentAvailable;
  final String text;
  const FilesCardWidget({
    Key? key,
    required this.data,
    required this.context,
    required this.extension,
    required this.fileName,
    required this.isCommentAvailable,
    required this.text,
  }) : super(key: key);

  String getFileTypeImagePath(String key) {
    switch (key) {
      case "pdf":
        return "assets/images/pdf.png";

      case "xls":
        return "assets/images/xls.png";

      default:
        return "assets/images/unknown-file.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: kWhite,
            // image: DecorationImage(
            //   image: FileImage(file),
            // ),
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: Center(
            child: Image.asset(
              getFileTypeImagePath(extension),
              package: "job_card",
            ),
            // child: Icon(
            //   isPdf ? FontAwesomeIcons.filePdf : FontAwesomeIcons.file,
            //   size: 30.sp,
            // ),
          ),
        ),
        GestureDetector(
            onTap: () async {},
            child: Builder(builder: (context) {
              if (text.isEmpty && !isCommentAvailable) {
                return const SizedBox();
              }

              return Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: text.isNotEmpty,
                        child: Builder(builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: text == "Before"
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: text == "Before"
                                    ? ThemeServices().getPrimaryFgColor(context)
                                    : ThemeServices()
                                        .getSecondaryFgColor(context),
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Visibility(
                        visible: isCommentAvailable,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Icon(
                            Icons.comment,
                            color: ThemeServices().getPrimaryFgColor(context),
                            size: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })),
      ],
    );
  }
}
