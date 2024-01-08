import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum ReportType { pdf, excel }

class SelectReportTypeWidget extends StatefulWidget {
  const SelectReportTypeWidget({
    required this.initialReportType,
    required this.onChanged,
    super.key,
  });

  final ReportType initialReportType;
  final Function(ReportType) onChanged;

  @override
  State<SelectReportTypeWidget> createState() => _SelectReportTypeWidgetState();
}

class _SelectReportTypeWidgetState extends State<SelectReportTypeWidget> {
  final double borderRadius = 7;
  late ValueNotifier changeReportTypeNotifier;

  @override
  void initState() {
    changeReportTypeNotifier =
        ValueNotifier<ReportType>(widget.initialReportType);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Select Report Type",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 5.sp,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ValueListenableBuilder(
            valueListenable: changeReportTypeNotifier,
            builder: (context, value, child) => Row(
              children: [
                buildReportType(
                  context,
                  selected: value == ReportType.pdf,
                  title: "PDF",
                  reportType: ReportType.pdf,
                ),
                buildReportType(
                  context,
                  selected: value == ReportType.excel,
                  title: "Excel",
                  reportType: ReportType.excel,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  // =============================================================
  Widget buildReportType(
    BuildContext context, {
    required bool selected,
    required String title,
    required ReportType reportType,
  }) {
    return GestureDetector(
      onTap: () {
        changeReportTypeNotifier.value = reportType;
        widget.onChanged(reportType);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.sp, vertical: 4.sp),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : null,
          borderRadius: reportType == ReportType.pdf
              ? BorderRadius.horizontal(
                  left: Radius.circular(borderRadius),
                )
              : BorderRadius.horizontal(
                  right: Radius.circular(borderRadius),
                ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            // color: kWhite,
          ),
        ),
      ),
    );
  }
}
