import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaray_police_web/constant.dart';
import 'package:jaray_police_web/landing.dart';

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<StatefulWidget> createState() {
    return _RestartWidgetState();
  }
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child ?? Container(),
    );
  }
}

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAvtbZH3ve_LIIedbuHDGlbH4fjBf4Lsag",
      authDomain: "jaray-police-web.firebaseapp.com",
      projectId: "jaray-police-web",
      storageBucket: "jaray-police-web.appspot.com",
      messagingSenderId: "142290228885",
      appId: "1:142290228885:web:2b0096b2f73c759fb26d9c",
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale('en', 'US'), // Current locale
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('th', 'TH'), // Thai
        ],
        title: 'Jaray Police',
        theme: ThemeData(
            scaffoldBackgroundColor: color6.withOpacity(0.3),
            colorScheme: ColorScheme.fromSeed(seedColor: color2),
            // primarySwatch: Colors.blueGrey
            // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
            textTheme: GoogleFonts.itimTextTheme()),
        home: LandingPage());
   
  }
}
