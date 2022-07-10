import 'dart:convert';
import 'package:encarte_facil_2/DesignSystem/DesignTokens.dart';
import 'package:encarte_facil_2/HomeNormal/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QueroSerPRO extends StatefulWidget {

  @override
  State<QueroSerPRO> createState() => _QueroSerPROState();
}

class _QueroSerPROState extends State<QueroSerPRO> {

  TextEditingController controllerNome = new TextEditingController();
  TextEditingController controllerWhatsApp = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();


  // solicitaPRO(String nome, String whatsapp, String email) async {

  solicitaPRO() async {

    Map data = {
          "records": [
            {
            "fields": {
              "Name": controllerNome.text,
              "Phone": controllerWhatsApp.text,
              "email": controllerEmail.text,
            }
            },
          ]
    };

    var jsonData = jsonEncode(data);

    http.Response response;

    response = await http.post(
      Uri.parse('https://api.airtable.com/v0/app2OpRUT2B6brsT7/request'),
      headers: (
          {'Authorization': 'Bearer keySFSIYnvACQhHAa',
          'Content-Type': 'application/json'}
      ),
      body: jsonData,
    );

    Map<dynamic, dynamic> retorno = jsonDecode(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  alert(String title, bool finaliza){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title:
          Text(title),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                if (finaliza){
                  //esse pop de baixo leva de volta pra tela de settings
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("",
            style: TextStyle(fontWeight: FontWeight.bold, color: colorNeutralLowPure())),
        elevation: 0,
        backgroundColor: Colors.grey[300],
        foregroundColor: colorNeutralLowPure(),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.bottomCenter,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
              Text("Entre na lista de espera",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorNeutralLowPure(),
                      fontSize: 40)),
              Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
              Container(
                width: width*0.85,
                decoration: BoxDecoration(
                  color: colorNeutralHighPure(),
                  borderRadius: BorderRadius.all(Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: TextField(
                  controller: controllerNome,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 6,
                  autofocus: true,
                  onChanged: (String e) {

                    //to do
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nome',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
              Container(
                width: width*0.85,
                decoration: BoxDecoration(
                  color: colorNeutralHighPure(),
                  borderRadius: BorderRadius.all(Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: TextField(
                  controller: controllerWhatsApp,
                  keyboardType: TextInputType.number,
                  minLines: 1,
                  maxLines: 6,
                  autofocus: true,
                  onChanged: (String e) {

                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'WhatsApp',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
              Container(
                width: width*0.85,
                decoration: BoxDecoration(
                  color: colorNeutralHighPure(),
                  borderRadius: BorderRadius.all(Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: TextField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  minLines: 1,
                  maxLines: 6,
                  autofocus: true,
                  onChanged: (String e) {

                    //to do
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'E-mail',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
              TextButton(
                onPressed: () async {

                  //verifica se da pra enviar a requisição

                  if (controllerNome.text.isNotEmpty && controllerWhatsApp.text.length >= 9 && RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(controllerEmail.text)) {

                    // validou
                    solicitaPRO().then((dados) {
                      print(dados);
                      if (dados == 200) {
                        alert("Solicitação concluída, aguarde nosso contato.", true);
                      } else {
                        alert("Erro no servidor, tente mais tarde", false);
                      }
                    });

                  } else {
                    alert("Seus dados parecem não estar corretos", false);
                  }
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorBrandPrimary(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Solicitar PRO',
                          style: TextStyle(
                              color: colorNeutralHighPure(),
                              fontSize: 16
                          )
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pushReplacement(
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
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colorBrandPrimary()),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Usar versão grátis',
                          style: TextStyle(
                              color: colorNeutralLowPure(),
                              fontSize: 16
                          )
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
