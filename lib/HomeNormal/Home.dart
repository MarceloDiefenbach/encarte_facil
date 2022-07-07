
import 'package:encarte_facil_2/Encartes.dart';
import 'package:encarte_facil_2/Premium%20flow/EncartesPRO.dart';
import 'package:encarte_facil_2/Premium%20flow/HomePRO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Logic/Functions.dart';
import '../Logic/controller.dart';
import '../NewEncarteComTema.dart';
import '../Settings.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (await verificaProMemoria() == "true"){
      print("é pro");
      Navigator.pushReplacement(
      context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomeWidgetPRO(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      print("nao é pro");
      //nothing to do
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.list_bullet, color: Color(0xff5DA0EF)),
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'Encartes',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.plus_circle, color: Color(0xff5DA0EF)),
            icon: Icon(CupertinoIcons.plus_circle),
            label: 'Criar encarte',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.settings, color: Color(0xff5DA0EF)),
            icon: Icon(CupertinoIcons.settings),
            label: 'Configurações',
          ),
        ],
        onTap: (index) {

        }
      ),

      //aqui configura qual widget vai aparecer
      tabBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Encartes();
        } else if (index == 1) {
          return NewEncarteComTema();
        } else if (index == 2){
          return Settings();
        }
      },
    );
  }
}
