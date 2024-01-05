import 'package:example/screens/home_screen.dart';
import 'package:example/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';

enum AppModes { machineMode, buildingMode, buildingAndMachine }

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static String id = '/login';

  ValueNotifier<AppModes> valueNotifier =
      ValueNotifier<AppModes>(AppModes.buildingMode);

  @override
  Widget build(BuildContext context) {
    changeUsernamePassword(valueNotifier.value);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  buildRadioListTile(
                    title: "Building and Machine ",
                    appMode: AppModes.buildingAndMachine,
                  ),
                  buildRadioListTile(
                    title: "Building Mode",
                    appMode: AppModes.buildingMode,
                  ),
                  buildRadioListTile(
                    title: "Machine Mode",
                    appMode: AppModes.machineMode,
                  ),
                ],
              ),
              MyTextField(
                controller: usernameController,
                labelText: "Username",
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: passwordController,
                labelText: "Password",
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  String errorMessage = await UserAuthServices().loginUser(
                    username: usernameController.text,
                    password: passwordController.text,
                  );

                  if (errorMessage.isEmpty) {
                    // Navigate to home screen
                    // SharedPrefrencesServices().storerememberMe(true);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                      ),
                    );
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioListTile({
    required String title,
    required AppModes appMode,
  }) {
    return ValueListenableBuilder<AppModes>(
        valueListenable: valueNotifier,
        builder: (context, AppModes value, _) {
          return RadioListTile<AppModes>(
            value: appMode,
            groupValue: value,
            title: Text(title),
            onChanged: (value) {
              valueNotifier.value = value!;

              changeUsernamePassword(value);
            },
          );
        });
  }

  changeUsernamePassword(AppModes value) {
    if (value == AppModes.buildingMode) {
      usernameController.text = "mansoor@buildingdemo";
      passwordController.text = "Welcome@123";
    } else if (value == AppModes.machineMode) {
      usernameController.text = "admin@machinedemo";
      passwordController.text = "Welcome@123";
    } else {
      usernameController.text = "mansoor@nectarit";
      passwordController.text = "Welcome@123";
    }
  }
}
