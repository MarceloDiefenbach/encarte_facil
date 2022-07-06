
import 'dart:typed_data';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import '../DesignSystem/Components/ProductEncarte.dart';

class EncarteGerado5Produtos extends StatefulWidget {

  List listaProdutos;

  String fundoEncarte;

  String temaEncarte;

  String validade;

  EncarteGerado5Produtos(this.listaProdutos, this.fundoEncarte, this.temaEncarte, this.validade);
  @override
  _EncarteGerado5ProdutosState createState() => _EncarteGerado5ProdutosState();
}

class _EncarteGerado5ProdutosState extends State<EncarteGerado5Produtos> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenshotController screenshotController = ScreenshotController();

    double larguraProduto = width*0.4;

    print(widget.listaProdutos);

    return Scaffold(
      appBar: AppBar(
        title: Text("Encarte",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: width*1.3,
                color: Colors.red,
                child: Stack(
                  children: [
                    Screenshot(
                      controller: screenshotController,
                      child:Stack(
                        children: [
                          Image.network(
                            widget.fundoEncarte,
                            fit: BoxFit.fill, // I thought this would fill up my Container but it doesn't
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width*0.8,
                                      height: width*0.4,
                                      color: Colors.transparent,
                                      child: Image.network(widget.temaEncarte),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ProductEncarte(width*0.3, widget.listaProdutos[0]),
                                    Padding(padding: EdgeInsets.all(2)),
                                    ProductEncarte(width*0.3, widget.listaProdutos[1]),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ProductEncarte(width*0.3, widget.listaProdutos[2]),
                                      Padding(padding: EdgeInsets.all(2)),
                                      ProductEncarte(width*0.3, widget.listaProdutos[3]),
                                      Padding(padding: EdgeInsets.all(2)),
                                      ProductEncarte(width*0.3, widget.listaProdutos[4]),
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                                Text("Ofertas válidas até: ${widget.validade}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 12)
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Salvar na galeria",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  screenshotController
                      .capture(delay: Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    _saveImage(capturedImage);
                  }).catchError((onError) {
                    print(onError);
                  });
                  FirebaseAnalytics.instance.logEvent(
                    name: "salvou_encarte_na_galeria",
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text("Encarte salvo na galeria"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  _saveImage(Uint8List imagem) async{
    final result = await ImageGallerySaver.saveImage(imagem, quality: 100);
  }
}
