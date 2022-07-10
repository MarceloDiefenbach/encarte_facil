import 'package:encarte_facil_2/HomeNormal/Home.dart';
import 'package:encarte_facil_2/HomeNormal/QueroSerPRO.dart';
import 'package:encarte_facil_2/Logic/Functions.dart';
import 'package:encarte_facil_2/Premium%20flow/Detalhes%20Premium.dart';
import 'package:encarte_facil_2/Premium%20flow/HomePRO.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DesignSystem/DesignTokens.dart';
import '../Logic/controller.dart';

class InformaCodigoPRO extends StatefulWidget {
  const InformaCodigoPRO({key}) : super(key: key);

  @override
  _InformaCodigoPRO createState() => _InformaCodigoPRO();
}

class _InformaCodigoPRO extends State<InformaCodigoPRO> {

  Controller controller;
  TextEditingController _textControllerCodigoPro;
  bool isStopped = true;
  bool isStopped2 = true;
  SharedPreferences prefs;
  String codigoPRO;


  getSharedPreferences () async {
    prefs = await SharedPreferences.getInstance();
  }

  salvaCodigoPRO(String codigoPRO) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("codigo", codigoPRO);
  }

  salvaURLlogo(String url) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("urlLogo", "${url}");
  }

  recuperaURLLlogo() async {
    String urlLogo;
    prefs = await SharedPreferences.getInstance();
    urlLogo = prefs.getString("urlLogo");
  }

  recuperaCodigoPRO() async {
    prefs = await SharedPreferences.getInstance();
    codigoPRO = prefs.getString("codigo");
    return codigoPRO;
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
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // if (await verificaProMemoria(controller) == "true"){
    //   Navigator.pushReplacement(
    //     context,
    //     PageRouteBuilder(
    //       pageBuilder: (context, animation1, animation2) => HomeWidget(),
    //       transitionDuration: Duration.zero,
    //       reverseTransitionDuration: Duration.zero,
    //     ),
    //   );
    // } else {
    //   print("errado");
    // }
    // controller = Provider.of<Controller>(context);
    // controller.pegaProdutos();
    // controller.pegaAirtable();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textControllerCodigoPro = TextEditingController(text: "");
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
        padding: EdgeInsets.fromLTRB(spacingGlobalMargin(), 0, spacingGlobalMargin(), 0),
        alignment: Alignment.center,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Sou cliente PRO",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: colorNeutralLowPure(),
                    fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(top: spacingNano(height))),
              Container(
                width: width * 0.9,
                height: height*0.08,
                decoration: BoxDecoration(
                  color: colorNeutralHighPure(),
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
                      color: colorNeutralLowPure(),
                      fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Código de cliente',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: spacingQuarck(height))),
              GestureDetector(
                onTap: (){
                  print(_textControllerCodigoPro.text);
                  verificaProDigitado(_textControllerCodigoPro.text).then((value) => {
                    if (value == "true"){
                        salvaCodigoPRO(_textControllerCodigoPro.text),
                      Navigator.pushReplacement(context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => HomeWidgetPRO(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                          ),
                      )
                    } else {
                      alert("Código inválido", false)
                    }
                  });
                },
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colorBrandPrimary(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Entrar',
                          style: TextStyle(
                              color: colorNeutralHighPure(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          )),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: spacingQuarck(height))),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => QueroSerPRO(),
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
                      Text('Ainda não sou PRO, quero assinar!',
                          style: TextStyle(
                              color: colorNeutralLowPure(),
                              fontSize: 16,
                              fontWeight: FontWeight.w700
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
                      pageBuilder: (context, animation1, animation2) => HomeWidget(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: width*0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Voltar para a versão gratuita',
                          style: TextStyle(
                              color: colorNeutralLowPure(),
                              fontSize: height*0.017,
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
