import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
// ignore: depend_on_referenced_packages
import 'package:job_card/job_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List list = [];

  @override
  void initState() {
    // GrapghQlClientServices().performQuery(
    //     query: FilesSchemas.getAllfilesFromPath,
    //     variables: {"filePath": "jobs/buildingdemo/43550"}).then((value) {
    //   print(value.exception);
    //   list = value.data?['getAllFilesFromSamePath']?['data'] ?? [];
    //   setState(() {});
    // });
    // // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CustomJobCard(
                filePath: "jobs/buildingdemo/43609",
              ),
            ),
          );
        },
      ),
      // body: Builder(builder: (context) {
      //   return GridView.builder(
      //     itemCount: list.length,
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       mainAxisSpacing: 10,
      //       crossAxisSpacing: 10,
      //       crossAxisCount: 3,
      //     ),
      //     itemBuilder: (context, index) {
      //       var map = list[index];
      //       var bas64 = base64Decode(map['data']);

      //       String filePath = map['path'];

      //       return GestureDetector(
      //         onTap: () async {
      //           // ignore: use_build_context_synchronously
      //           // Navigator.of(context).push(
      //           //   MaterialPageRoute(
      //           //     builder: (context) => FilesViewerWithSwipeScreen(
      //           //       items: list,
      //           //       initilaIndex: index,
      //           //       // enableCommentFeature: false,
      //           //       internetAvailable: false,
      //           //       noInternetCommentSaving: (ff,comment, isReplyComment) {
      //           //         print("comment: $comment reply: $isReplyComment");
      //           //       },
      //           //     ),
      //           //   ),
      //           // );
      //         },
      //         child: Hero(
      //           tag: map['fileName'],
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: Colors.red,
      //               image: DecorationImage(
      //                 image: MemoryImage(bas64),
      //               ),
      //             ),
      //             child: Builder(builder: (context) {
      //               bool commentAvailable = filePath.contains('/comments');

      //               if (!commentAvailable) {
      //                 return const SizedBox();
      //               }

      //               return const Align(
      //                 alignment: Alignment.topRight,
      //                 child: Icon(
      //                   Icons.comment,
      //                   color: Colors.white,
      //                 ),
      //               );
      //             }),
      //           ),
      //         ),
      //       );
      //     },
      //   );
      // }),
    );
  }
}
