import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:graphql_config/graphql_config.dart';
import 'package:job_card/core/schemas/files_scheams.dart';
import 'package:job_card/widgets/attachment_files_widget.dart';
import 'package:job_card/widgets/attachment_image_widget.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:files_viewer/files_viewer.dart';

class CustomJobCard extends StatelessWidget {
  const CustomJobCard({required this.filePath, super.key});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Job Card"),
      ),
      body: QueryWidget(
        options: GrapghQlClientServices().getQueryOptions(
          document: FilesSchemas.getAllfilesFromPath,
          variables: {
            "filePath": filePath,
            "traverseFiles": true,
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (result.hasException) {
            return GrapghQlClientServices().handlingGraphqlExceptions(
              result: result,
              context: context,
              refetch: refetch,
            );
          }

          List list = result.data?['getAllFilesFromSamePath']?['data'] ?? [];

          return GridView.builder(
            padding: EdgeInsets.all(10.sp),
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.sp,
              crossAxisSpacing: 10.sp,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              var map = list[index];

              String filePath = map['path'];

              String extension = map['fileName'].split('.').last;

              bool commentAvailable =
                  map['path'].toString().contains('/comments');

              String data = map['data'] ?? "";
              String fileName = map['fileName'] ?? "";

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FilesViewerWithSwipeScreen(
                      items: list,
                      initilaIndex: index,
                      internetAvailable: true,
                    ),
                  ));
                },
                child: Builder(
                  builder: (context) {
                    if (extension == "jpeg" ||
                        extension == "png" ||
                        extension == "jpg") {
                      return ImageCardWidget(
                        data: data,
                        map: map,
                        fileName: fileName,
                        isCommentAvailable: commentAvailable,
                        filePath: filePath,
                        index: index,
                      );
                    }

                    bool isBefore = filePath.contains("__before");

                    bool isAfter = filePath.contains("__after");

                    String text = !isAfter && !isBefore
                        ? ""
                        : isBefore
                            ? "Before"
                            : "After";

                    return FilesCardWidget(
                      data: data,
                      context: context,
                      extension: extension,
                      fileName: fileName,
                      isCommentAvailable: commentAvailable,
                      text: text,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
