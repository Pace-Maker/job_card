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
    // TODO: implement initState
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
                jobId: 43609,
              ),
            ),
          );
        },
      ),
    );
  }
}
