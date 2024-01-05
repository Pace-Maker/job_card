// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/services/theme/theme_services.dart';

class ImageCardWidget extends StatelessWidget {
  final String data;
  final Map<dynamic, dynamic> map;
  final String fileName;
  final bool isCommentAvailable;
  final String filePath;
  final int index;
  const ImageCardWidget({
    Key? key,
    required this.data,
    required this.map,
    required this.fileName,
    required this.isCommentAvailable,
    required this.filePath,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   

    return Container(
      decoration: BoxDecoration(
        // color: kWhite,
        image: DecorationImage(
          image: MemoryImage( base64Decode(data),),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5.sp),
      ),
      child: Builder(builder: (context) {
        // if (!isCommentAvailable) {
        //   return const SizedBox();
        // }
        bool isBefore = filePath.contains("__before");

        bool isAfter = filePath.contains("__after");

        String text = !isAfter && !isBefore
            ? ""
            : isBefore
                ? "Before"
                : "After";

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
                              : ThemeServices().getSecondaryFgColor(context),
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
      }),
    );
  }
}
