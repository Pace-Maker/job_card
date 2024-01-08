// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:files_viewer/screens/files_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_card/utils/themes/colors.dart';
import 'package:sizer/sizer.dart';
import '../core/bloc/bloc/attachment_selection_bloc.dart';
import '../core/services/theme/theme_services.dart';

class AttachmentCardWidget extends StatelessWidget {
  final Map<String, dynamic> map;
  final AttachmentSelectionBloc attachmentSelectionBloc;

  const AttachmentCardWidget({
    Key? key,
    required this.map,
    required this.attachmentSelectionBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String filePath = map['path'];

    String extension = map['fileName'].toString().split('.').last;

    bool isCommentAvailable = map['path'].toString().contains('/comments');

    String data = map['data'] ?? "";
    String fileName = map['fileName'] ?? "";

    bool isImage =
        extension == "jpeg" || extension == "png" || extension == "jpg";

    return Hero(
      tag: fileName,
      child: GestureDetector(
        onTap: () {
          bool isChecked = attachmentSelectionBloc.state.checkedAttachments.any(
            (element) =>
                element.fileName == fileName && element.path == filePath,
          );

          attachmentSelectionBloc.add(
            UnSelectAttachment(
              map: map,
              isChecked: isChecked,
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            // color: kWhite,
            image: getDecorationImage(
                isImage: isImage, extension: extension, data: data),
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
              return Stack(
                children: [
                  SelctionWidget(
                    fileName: fileName,
                    path: filePath,
                  ),
                  ExpandFileWidget(
                    onTap: () {
                      int index = attachmentSelectionBloc.state.allAttachments
                          .indexOf(map);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FilesViewerWithSwipeScreen(
                            items: attachmentSelectionBloc.state.allAttachments,
                            initilaIndex: index,
                            internetAvailable: true,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }

            return Stack(
              children: [
                SelctionWidget(
                  fileName: fileName,
                  path: filePath,
                ),
                ExpandFileWidget(
                  onTap: () {
                    int index = attachmentSelectionBloc.state.allAttachments
                        .indexOf(map);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FilesViewerWithSwipeScreen(
                          items: attachmentSelectionBloc.state.allAttachments,
                          initilaIndex: index,
                          internetAvailable: true,
                        ),
                      ),
                    );
                  },
                ),
                Align(
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
                                      ? ThemeServices()
                                          .getPrimaryFgColor(context)
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
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  DecorationImage getDecorationImage({
    required bool isImage,
    required String data,
    required String extension,
  }) {
    BoxFit boxFit = BoxFit.cover;

    return isImage
        ? DecorationImage(
            image: MemoryImage(
              base64Decode(data),
            ),
            fit: boxFit,
          )
        : DecorationImage(
            image: AssetImage(getFileTypeImagePath(extension),
                package: "job_card"),
            fit: boxFit,
          );
  }

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
}

class ExpandFileWidget extends StatelessWidget {
  const ExpandFileWidget({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Icon(
            Icons.open_in_full_rounded,
            size: 12.sp,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class SelctionWidget extends StatelessWidget {
  const SelctionWidget({
    required this.fileName,
    required this.path,
    super.key,
  });

  final String fileName;
  final String path;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttachmentSelectionBloc, AttachmentSelectionState>(
      builder: (context, state) {
        bool isChecked = state.checkedAttachments.any(
          (element) => element.fileName == fileName && element.path == path,
        );

        if (!isChecked) {
          return const SizedBox();
        }

        return Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(5.sp),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              maxRadius: 10.sp,
              child: Icon(
                Icons.done,
                color: kWhite,
              ),
            ),
          ),
        );
      },
    );
  }
}
