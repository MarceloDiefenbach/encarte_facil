import 'package:encarte_facil_2/Nova%20Home/Home.dart';
import 'package:encarte_facil_2/Premium%20flow/InformaCodigoPRO.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:provider/provider.dart';
import 'Logic/Functions.dart';
import 'Logic/controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAnalytics.instance.logEvent(name: "open_app");

  FlutterUxcam.optIntoSchematicRecordings(); // Confirm that you have user permission for screen recording
  FlutterUxConfig config = FlutterUxConfig(userAppKey: "no40ub4vc1pm8ty");
  FlutterUxcam.startWithConfiguration(config);

  runApp(
      Provider<Controller>(
        create: (_) => Controller(),
        child: MaterialApp(
          initialRoute: "/",
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            // '/go-to-home': (context) => const HomeWidget(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            // '/second': (context) => const SecondScreen(),
          },
          home: HomeWidget(),
          debugShowCheckedModeBanner: false,
        ),
      )
  );
}