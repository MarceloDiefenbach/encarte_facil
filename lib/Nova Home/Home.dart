import 'dart:convert';

import 'package:encarte_facil_2/Encartes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/Cell Encarte.dart';
import '../Logic/Functions.dart';
import '../Logic/controller.dart';
import '../Model/Produto.dart';
import '../NewEncarteComTema.dart';
import '../ProdutosEncarte.dart';
import '../Settings.dart';
import '../SugestionForm.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  Controller controller;

  @override
  Widget build(BuildContext context) {

    controller = Provider.of<Controller>(context);

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
