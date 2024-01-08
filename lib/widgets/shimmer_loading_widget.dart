


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class BuildShimmerLoadingWidget extends StatelessWidget {
  BuildShimmerLoadingWidget({
    this.height,
    this.itemCount = 7,
    this.shrinkWrap = false,
    this.padding,
    this.seperatedHeight,
    super.key,
  });

  double? height;
  int itemCount;
  bool shrinkWrap;
  EdgeInsets? padding;
  double? seperatedHeight;

  @override
  Widget build(BuildContext context) {
    height ??= 20.h;

    seperatedHeight ??= 10.sp;

    return ListView.separated(
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(
        height: seperatedHeight,
      ),
      itemBuilder: (context, index) {
        return Shimmer(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFEBEBF4),
              Color(0xFFF4F4F4),
              Color(0xFFEBEBF4),
            ],
            stops: [
              0.1,
              0.3,
              0.4,
            ],
            begin: Alignment(-1.0, -0.3),
            end: Alignment(1.0, 0.3),
            tileMode: TileMode.clamp,
          ),
          child: Container(
            // width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            height: height,
          ),
        );
      },
    );
  }
}

class ShimmerLoadingContainerWidget extends StatelessWidget {
  ShimmerLoadingContainerWidget({required this.height,this.width, super.key});

  double height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        // width: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
