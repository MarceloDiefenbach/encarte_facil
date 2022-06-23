import 'dart:convert';

import 'package:encarte_facil_2/Encartes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/Cell Encarte.dart';
import '../Logic/Functions.dart';
import '../Model/Produto.dart';
import '../NewEncarteComTema.dart';
import '../ProdutosEncarte.dart';
import '../SugestionForm.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

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
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'Encartes',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.plus_circle),
            label: 'Criar encarte',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.globe),
            label: 'Ajuda',
          ),
        ],
        onTap: (index) {

          if (index == 1){
            setState((){});
            print("clicou");
          }
        }

      ),


      //aqui configura qual widget vai aparecer
      tabBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Encartes();
        } else if (index == 1) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return NewEncarteComTema();
            },
          );
        } else if (index == 2){
          return SugestionForm();
        }
      },

    );
  }
}
