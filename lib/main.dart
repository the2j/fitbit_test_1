import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/utils.dart';
import 'screens/screens.dart';
import 'database/database.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupSingletons();
  runApp(MyApp());
}

Future setupSingletons() async {
  GetIt locator = GetIt.instance;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  locator.registerSingleton<SharedPreferences>(prefs);

  var db = MyDatabase();
  locator.registerSingleton<MyDatabase>(db);
} // setupSingletons

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: Strings.homeScreenRouteName,
      routes: {
        Strings.homeScreenRouteName: (context) => HomeScreen(),
        Strings.fitbitSettingsScreenRouteName: (context) =>
            FitbitSettingsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == HomeScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return HomeScreen();
          });
        } else if (settings.name == FitbitSettingsScreen.routeName) {
          return MaterialPageRoute(builder: (context) {
            return FitbitSettingsScreen();
          });
        } else {
          return null;
        }
      },
      theme: Style.themeData,
      //home: HomeScreen(),
    );
  }
}