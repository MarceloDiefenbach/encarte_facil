import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'Encartes.dart';

class SugestionForm extends StatefulWidget {
  const SugestionForm({key}) : super(key: key);

  @override
  _SugestionForm createState() => _SugestionForm();
}

class _SugestionForm extends State<SugestionForm> {

  TextEditingController controllerProdutos = new TextEditingController();

  String produtos = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final Email email = Email(
      body: 'Olá, gostaria de solicitar a inclusão dos seguintes produtos \n\n\n ${controllerProdutos.text}',
      subject: 'Solicitação de novos produtos',
      recipients: ['apptwocontato@gmail.com'],
      isHTML: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        alignment: Alignment.bottomCenter,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
              Text("Escreva a sua sugestão",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 40)),
              Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
              Container(
                width: width*0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: TextField(
                  controller: controllerProdutos,
                  keyboardType: TextInputType.text,
                  minLines: 5,
                  maxLines: 9,
                  autofocus: true,
                  onChanged: (String e) {
                    produtos = e;
                    print(e);
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Digite aqui',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
              TextButton(
                onPressed: () async {
                  await FlutterEmailSender.send(
                      Email(
                        body: 'Olá essa é a minha sugestão para o Encarte Fácil: \n\n\n ${controllerProdutos.text}',
                        subject: 'Sugestão de melhoria',
                        recipients: ['apptwocontato@gmail.com'],
                        isHTML: false,
                      )
                  );
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Enviar sugestão',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          )
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Encartes()
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Cancelar',
                          style: TextStyle(color: Colors.blue, fontSize: 16)),
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
