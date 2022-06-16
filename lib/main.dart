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

  runApp(MaterialApp(
    initialRoute: "/",
    routes: {

    },
    home: Encartes(),
    debugShowCheckedModeBanner: false,
  ));
}