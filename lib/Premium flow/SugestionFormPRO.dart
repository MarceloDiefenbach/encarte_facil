import 'package:encarte_facil_2/DesignSystem/DesignTokens.dart';
import 'package:encarte_facil_2/Premium%20flow/HomePRO.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SugestionFormPRO extends StatefulWidget {
  const SugestionFormPRO({key}) : super(key: key);

  @override
  _SugestionFormPRO createState() => _SugestionFormPRO();
}

class _SugestionFormPRO extends State<SugestionFormPRO> {

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
      body: Container(
        padding: EdgeInsets.fromLTRB(spacingGlobalMargin(), 0, spacingGlobalMargin(), 0),
        alignment: Alignment.bottomCenter,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(50)),
              Text("Ou escreva a sua \nsugestão ou dúvida",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorNeutralLowPure(),
                      fontSize: 30)),
              Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
              Container(
                width: width*0.85,
                decoration: BoxDecoration(
                  color: colorNeutralHighPure(),
                  borderRadius: borderRadiusMedium(),
                ),
                padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: TextField(
                  controller: controllerProdutos,
                  keyboardType: TextInputType.text,
                  minLines: 5,
                  maxLines: 9,
                  autofocus: false,
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
                          body: 'Olá essa é a minha solicitação para o Encarte Fácil: \n\n\n ${controllerProdutos.text}',
                          subject: 'Preciso de ajuda com o aplicativo',
                          recipients: ['apptwocontato@gmail.com'],
                          isHTML: false,
                        )
                    );
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => HomeWidgetPRO(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: borderRadiusMedium(),
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
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: borderRadiusMedium(),
                    color: Colors.transparent,
                    border: Border.all(color: colorBrandPrimary()),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Cancelar',
                          style: TextStyle(color: colorBrandPrimary(), fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 100)),
            ],
          ),
        ),
      ),
    );
  }
}
