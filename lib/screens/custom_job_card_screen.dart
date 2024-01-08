import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:graphql_config/graphql_config.dart';
import 'package:job_card/core/bloc/bloc/attachment_selection_bloc.dart';
import 'package:job_card/core/schemas/files_scheams.dart';
import 'package:job_card/core/services/job/job_card_services.dart';
import 'package:job_card/widgets/attachment_image_widget.dart';
import 'package:job_card/widgets/build_elevated_button.dart';
import 'package:job_card/widgets/shimmer_loading_widget.dart';
import 'package:sizer/sizer.dart';
import '../core/models/checked_attachments_model.dart';
import '../widgets/select_report_type_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:secure_storage/secure_storage.dart';

// ignore: must_be_immutable
class CustomJobCard extends StatefulWidget {
  const CustomJobCard({required this.jobId, required this.filePath, super.key});

  final String filePath;
  final int jobId;

  @override
  State<CustomJobCard> createState() => _CustomJobCardState();
}

class _CustomJobCardState extends State<CustomJobCard> {
  late AttachmentSelectionBloc attachmentSelectionBloc;

  @override
  void initState() {
    attachmentSelectionBloc = BlocProvider.of<AttachmentSelectionBloc>(context);
    super.initState();
  }

  ReportType reportType = ReportType.pdf;

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Job Card"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          children: [
            SelectReportTypeWidget(
              initialReportType: reportType,
              onChanged: (value) {
                reportType = value;
              },
            ),
            Expanded(
              child: QueryWidget(
                options: GrapghQlClientServices().getQueryOptions(
                  document: FilesSchemas.getAllfilesFromPath,
                  variables: {
                    "filePath": widget.filePath,
                    "traverseFiles": true,
                  },
                ),
                builder: (result, {fetchMore, refetch}) {
                  // if (result.isLoading) {
                  //   return const Center(
                  //     child: CircularProgressIndicator.adaptive(),
                  //   );
                  // }

                  if (result.hasException) {
                    return GrapghQlClientServices().handlingGraphqlExceptions(
                      result: result,
                      context: context,
                      refetch: refetch,
                    );
                  }

                  List list =
                      result.data?['getAllFilesFromSamePath']?['data'] ?? [];

                  attachmentSelectionBloc.state.allAttachments = list;
                  attachmentSelectionBloc.state.checkedAttachments =
                      checkedAttachmentModelFromJson(list);

                  return buildGridviewbuilder(list, result.isLoading);
                },
              ),
            ),
            buildElevatedButton(),
            SizedBox(
              height: 10.sp,
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================================================

  Widget buildElevatedButton() {
    return BuildElevatedButton(
      onPressed: () {
        var checkedAttachments =
            attachmentSelectionBloc.state.checkedAttachments;

        String? prefrence = checkedAttachments.isEmpty
            ? null
            : checkedAttachmentModelToJson(checkedAttachments);

        JobCardServices().openJobCard(
          widget.jobId,
          preference: prefrence,
          fileType: getFileType(reportType),
          context: context,
        );
      },
      title: "Save",
    );
  }

  String getFileType(ReportType reportType) {
    switch (reportType) {
      case ReportType.pdf:
        return "PDF";
      case ReportType.excel:
        return "EXCEL";
    }
  }

  // ===================================================================================
  Widget buildGridviewbuilder(List<dynamic> list, bool isLoading) {
    return GridView.builder(
      physics: isLoading ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      itemCount: isLoading ? 15 : list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.sp,
        crossAxisSpacing: 10.sp,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        if (isLoading) {
          return ShimmerLoadingContainerWidget(height: 0);
        }

        var map = list[index];

        return AttachmentCardWidget(
          attachmentSelectionBloc: attachmentSelectionBloc,
          map: map,
        );
      },
    );
  }
}
