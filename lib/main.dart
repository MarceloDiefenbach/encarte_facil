import 'package:encarte_facil_2/Nova%20Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Encartes.dart';
import 'ProdutosEncarte.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAnalytics.instance.logEvent(name: "open_app");

  runApp(
      MaterialApp(
        initialRoute: "/",
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/go-to-home': (context) => const HomeWidget(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          // '/second': (context) => const SecondScreen(),
        },
        home: HomeWidget(),
        debugShowCheckedModeBanner: false,
      )
  );
}