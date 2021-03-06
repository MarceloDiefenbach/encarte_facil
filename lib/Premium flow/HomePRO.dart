import 'package:encarte_facil_2/HomeNormal/Home.dart';
import 'package:encarte_facil_2/Premium%20flow/EncartesPRO.dart';
import 'package:encarte_facil_2/Premium%20flow/NewEncarteComTemaPRO.dart';
import 'package:encarte_facil_2/Premium%20flow/SettingsPRO.dart';
import 'package:encarte_facil_2/Premium%20flow/StoryCreator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Logic/Functions.dart';
import '../HomeNormal/Settings.dart';

class HomeWidgetPRO extends StatefulWidget {
  const HomeWidgetPRO({key}) : super(key: key);

  @override
  State<HomeWidgetPRO> createState() => _HomeWidgetPROState();
}

class _HomeWidgetPROState extends State<HomeWidgetPRO> {

  bool pro = false;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (await verificaProMemoria() == "true"){
      //nothing to do
      print("nothing to do");
    } else {
      setState() {
        pro = true;
      }
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomeWidget(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
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
            activeIcon: Icon(CupertinoIcons.arrow_up_down_square, color: Color(0xff5DA0EF)),
            icon: Icon(CupertinoIcons.arrow_up_down_square),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.settings, color: Color(0xff5DA0EF)),
            icon: Icon(CupertinoIcons.settings),
            label: 'Configura????es',
          ),
        ],
        onTap: (index) {

        }
      ),

      //aqui configura qual widget vai aparecer
      tabBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return EncartesPRO();
        } else if (index == 1) {
          return NewEncarteComTemaPRO();
        } else if (index == 2){
          return StoryCreator();
        } else if (index == 3){
          return SettingsPRO();
        }
      },
    );
  }
}
