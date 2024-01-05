import 'package:example/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'screens/login_screen.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageServices().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GraphQlProviderWidget(
        client: ValueNotifier(
          GrapghQlClientServices().getClient(
            timeZone: "asia/kolkata",
            isConnectedinStaging: true,
            exceptionHandler: () async {
              // UserAuthHelpers().logoutHelper();
            },
          ),
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          routes: {
            LoginScreen.id: (context) => LoginScreen(),
            HomeScreen.id: (context) => const HomeScreen(),
          },
          initialRoute: LoginScreen.id,
        ),
      ),
    );
  }
}
