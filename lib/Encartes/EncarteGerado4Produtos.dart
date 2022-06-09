
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class EncarteGerado4Produtos extends StatefulWidget {

  List listaProdutos;

  String fundoEncarte;

  String temaEncarte;

  EncarteGerado4Produtos(this.listaProdutos, this.fundoEncarte, this.temaEncarte);
  @override
  _EncarteGerado4ProdutosState createState() => _EncarteGerado4ProdutosState();
}

class _EncarteGerado4ProdutosState extends State<EncarteGerado4Produtos> {

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
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width*0.8,
                                      height: width*0.5,
                                      color: Colors.transparent,
                                      child: Image.network(widget.temaEncarte),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: larguraProduto*0.8,
                                        height: larguraProduto*0.8,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(larguraProduto*0.03),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, larguraProduto*0.03, larguraProduto*0.03, larguraProduto*0.03),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 0, larguraProduto*0.19, 0),
                                                      child: Container(
                                                        width: larguraProduto*0.7,
                                                        height: larguraProduto*0.7,
                                                        child: Image.network(widget.listaProdutos[0]["imagem"]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          widget.listaProdutos[0]["nomeProduto"],
                                                          style: TextStyle(
                                                              fontSize: larguraProduto*0.035,
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          widget.listaProdutos[0]["segundaLinha"],
                                                          style: TextStyle(
                                                              fontSize: larguraProduto*0.035,
                                                              fontWeight: FontWeight.w300
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(right: larguraProduto*0.03),
                                                              child: Text(
                                                                "R\$",
                                                                style: TextStyle(
                                                                  fontSize: larguraProduto*0.04,
                                                                  fontWeight: FontWeight.w200,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              widget.listaProdutos[0]["valor"],
                                                              style: TextStyle(
                                                                  fontSize: larguraProduto*0.12,
                                                                  fontWeight: FontWeight.w900
                                                              ),
                                                            ),
                                                          ]
                                                      )
                                                    ]
                                                )
                                              ],
                                            )
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                          width: larguraProduto*0.8,
                                          height: larguraProduto*0.8,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(larguraProduto*0.03),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, larguraProduto*0.03, larguraProduto*0.03, larguraProduto*0.03),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            widget.listaProdutos[1]["nomeProduto"],
                                                            style: TextStyle(
                                                                fontSize: larguraProduto*0.035,
                                                                fontWeight: FontWeight.w700
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            widget.listaProdutos[1]["segundaLinha"],
                                                            style: TextStyle(
                                                                fontSize: larguraProduto*0.035,
                                                                fontWeight: FontWeight.w300
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 0, larguraProduto*0.19, 0),
                                                        child: Container(
                                                          width: larguraProduto*0.7,
                                                          height: larguraProduto*0.7,
                                                          child: Image.network(widget.listaProdutos[1]["imagem"]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(right: larguraProduto*0.03),
                                                                child: Text(
                                                                  "R\$",
                                                                  style: TextStyle(
                                                                    fontSize: larguraProduto*0.04,
                                                                    fontWeight: FontWeight.w200,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                widget.listaProdutos[1]["valor"],
                                                                style: TextStyle(
                                                                    fontSize: larguraProduto*0.12,
                                                                    fontWeight: FontWeight.w900
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                      ]
                                                  )
                                                ],
                                              )
                                          )
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: larguraProduto*0.8,
                                          height: larguraProduto*0.8,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(larguraProduto*0.03),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, larguraProduto*0.03, larguraProduto*0.03, larguraProduto*0.03),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            widget.listaProdutos[2]["nomeProduto"],
                                                            style: TextStyle(
                                                                fontSize: larguraProduto*0.035,
                                                                fontWeight: FontWeight.w700
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            widget.listaProdutos[2]["segundaLinha"],
                                                            style: TextStyle(
                                                                fontSize: larguraProduto*0.035,
                                                                fontWeight: FontWeight.w300
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(0, 0, larguraProduto*0.19, 0),
                                                        child: Container(
                                                          width: larguraProduto*0.7,
                                                          height: larguraProduto*0.7,
                                                          child: Image.network(widget.listaProdutos[2]["imagem"]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(right: larguraProduto*0.03),
                                                                child: Text(
                                                                  "R\$",
                                                                  style: TextStyle(
                                                                    fontSize: larguraProduto*0.04,
                                                                    fontWeight: FontWeight.w200,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                widget.listaProdutos[2]["valor"],
                                                                style: TextStyle(
                                                                    fontSize: larguraProduto*0.12,
                                                                    fontWeight: FontWeight.w900
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                      ]
                                                  )
                                                ],
                                              )
                                          )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Container(
                                            width: larguraProduto*0.8,
                                            height: larguraProduto*0.8,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(larguraProduto*0.03),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(0, larguraProduto*0.03, larguraProduto*0.03, larguraProduto*0.03),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              widget.listaProdutos[3]["nomeProduto"],
                                                              style: TextStyle(
                                                                  fontSize: larguraProduto*0.035,
                                                                  fontWeight: FontWeight.w700
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              widget.listaProdutos[3]["segundaLinha"],
                                                              style: TextStyle(
                                                                  fontSize: larguraProduto*0.035,
                                                                  fontWeight: FontWeight.w300
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0, 0, larguraProduto*0.19, 0),
                                                          child: Container(
                                                            width: larguraProduto*0.7,
                                                            height: larguraProduto*0.7,
                                                            child: Image.network(widget.listaProdutos[3]["imagem"]),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(right: larguraProduto*0.03),
                                                                  child: Text(
                                                                    "R\$",
                                                                    style: TextStyle(
                                                                      fontSize: larguraProduto*0.04,
                                                                      fontWeight: FontWeight.w200,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget.listaProdutos[3]["valor"],
                                                                  style: TextStyle(
                                                                      fontSize: larguraProduto*0.12,
                                                                      fontWeight: FontWeight.w900
                                                                  ),
                                                                ),
                                                              ]
                                                          )
                                                        ]
                                                    )
                                                  ],
                                                )
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                )
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
