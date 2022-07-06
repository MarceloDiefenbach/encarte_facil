import 'package:encarte_facil_2/DesignSystem/DesignTokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class NewProductsForm extends StatefulWidget {
  const NewProductsForm({key}) : super(key: key);

  @override
  _NewProductsForm createState() => _NewProductsForm();
}

class _NewProductsForm extends State<NewProductsForm> {

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
            style: TextStyle(fontWeight: FontWeight.bold, color: colorNeutralLowPure())),
        elevation: 0,
        backgroundColor: Colors.grey[300],
        foregroundColor: colorNeutralLowPure(),
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
              Text("Quais produtos você precisa?",
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
                  controller: controllerProdutos,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 6,
                  autofocus: true,
                  onChanged: (String e) {
                    produtos = e;
                    print(e);
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Digite os nomes dos produtos',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
              TextButton(
                  onPressed: () async {
                    await FlutterEmailSender.send(
                          Email(
                            body: 'Olá, gostaria de solicitar a inclusão dos seguintes produtos \n\n\n ${controllerProdutos.text}',
                            subject: 'Solicitação de novos produtos',
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
                      color: colorBrandPrimary(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Enviar solicitação',
                            style: TextStyle(
                                color: colorNeutralHighPure(),
                                fontSize: 16
                            )
                        ),
                      ],
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
