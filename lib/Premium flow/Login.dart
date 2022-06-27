import 'dart:async';

import 'package:encarte_facil_2/Components/Button.dart';
import 'package:encarte_facil_2/Nova%20Home/Home.dart';
import 'package:encarte_facil_2/Premium%20flow/Detalhes%20Premium.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Logic/Functions.dart';
import '../Logic/controller.dart';

class Login extends StatefulWidget {
  const Login({key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {

  Controller controller;
  TextEditingController _textControllerCodigoPro;
  bool isStopped = true;
  SharedPreferences prefs;
  String codigoPRO;

  getSharedPreferences () async
  {
    prefs = await SharedPreferences.getInstance();
  }

  salvaCodigoPRO() async
  {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("codigo", "1234");
  }

  recuperaCodigoPRO() async
  {
    prefs = await SharedPreferences.getInstance();
    codigoPRO = prefs.getString("codigo");
    print(codigoPRO);
    return codigoPRO;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controller = Provider.of<Controller>(context);
    controller.pegaProdutos();
    controller.pegaEncartes();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textControllerCodigoPro = TextEditingController(text: "");

    Timer.periodic(Duration(milliseconds: 1), (timer) async {
      if (isStopped) {
        recuperaCodigoPRO();
        if (codigoPRO == "1234") {
          isStopped = false;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => HomeWidget(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        } else {
          print("nao pegou");
        }
        if(false){
          isStopped = false;
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.center,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Sou cliente PRO",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Container(
                  width: width * 0.9,
                  height: height*0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: TextField(
                    controller: _textControllerCodigoPro,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    onChanged: (String e) {},
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Código de cliente',
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  recuperaCodigoPro();
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Entrar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          )),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(4)),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => DetalhesPremium(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ainda não sou PRO, quero assinar!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          )),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(50)),
              Text("Ou entre na versão 100% gratuita",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16),
              ),
              Padding(padding: EdgeInsets.all(8)),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => HomeWidget(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Usar gratuitamente',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
