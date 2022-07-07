import 'package:encarte_facil_2/Premium%20flow/InformaCodigoPRO.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DetalhesPremium extends StatefulWidget {
  const DetalhesPremium({key}) : super(key: key);

  @override
  _DetalhesPremium createState() => _DetalhesPremium();
}

class _DetalhesPremium extends State<DetalhesPremium> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.centerLeft,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(50)),
              Text("Seja PRO e tenha \nacesso a benefícios \nexclusivos!",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30)),
              Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 8, 0)),
                  Text("Use o logo do seu mercado",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 16)),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 8, 0)),
                  Text("Temas exclusivos",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 16)),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 8, 0)),
                  Text("Encartes ilimitados",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 16)),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 8, 0)),
                  Text("Remova os anúncios",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 16)),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 8, 0)),
                  Text("Prioridade na adição de novos produtos",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 16)),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
              Text("Tudo isso por apenas",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16)),
              Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
              Text("R\$ 20,00",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 40)),
              Text("por mês",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16)),
              Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      // height: 0,
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Quero ser PRO', style: TextStyle(color: Colors.white)),
                          ],
                        )
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => InformaCodigoPRO(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  GestureDetector(
                    child: Container(
                      // height: 0,
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Já sou PRO', style: TextStyle(color: Colors.black)),
                          ],
                        )
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => InformaCodigoPRO(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(8)),
              GestureDetector(
                child: Text("Usar versão grátis",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 12)),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
