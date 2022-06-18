import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lista10/firebase_options.dart';
import 'package:lista10/helpers/helpers_auth.dart';
import 'package:lista10/screens/auth_screen.dart';
import 'package:lista10/screens/home_screen.dart';
import 'package:lista10/screens/verify_email_screen.dart';

import 'infra/lista10_database.dart';
import 'controllers/db_controller.dart';

import 'screens/category_lists_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/list_details_screen.dart';
import 'widgets/login_widget.dart';

AppDatabase? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DBController.openDatabase();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: HelpersAuth.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Lista 10',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.tealAccent),
      ),
      home: const MainPage(),

      //theme: ThemeData(
      //  canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      //  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      //      .copyWith(secondary: Colors.amber),
      //),
      //initialRoute: LoginScreen.routeName,
      //routes: {
      //  LoginScreen.routeName: ((ctx) => const LoginScreen()),
      //  CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
      //  CategoryListsScreen.routeName: (ctx) => const CategoryListsScreen(),
      //  ListDetailsScreen.routeName: (ctx) => const ListDetailsScreen(),
      //},
      //onUnknownRoute: (settings) {
      //  return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      //},
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Ops! Deu algum problema!'));
            } else if (snapshot.hasData) {
              return VerifyEmailScreen();
            } else {
              return AuthScreen();
            }
          },
        ),
      );
}
