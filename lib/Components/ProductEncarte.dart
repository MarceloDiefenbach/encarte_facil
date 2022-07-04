import 'package:flutter/material.dart';

class ProductEncarte extends StatefulWidget {

  double larguraProduto;
  var produto;

  ProductEncarte(this.larguraProduto, this.produto);

  @override
  _ProductEncarteState createState() => _ProductEncarteState();

}

class _ProductEncarteState extends State<ProductEncarte> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.larguraProduto,
        height: widget.larguraProduto,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.larguraProduto*0.05),
          color: Colors.white,
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, widget.larguraProduto*0.05, widget.larguraProduto*0.05, widget.larguraProduto*0.05),
            child: Stack(
              children: [
                Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                  Text(
                                    widget.produto["nomeProduto"],
                                    style: TextStyle(
                                      fontSize: widget.larguraProduto*0.04,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                Text(
                                  widget.produto["segundaLinha"],
                                  style: TextStyle(
                                      fontSize: widget.larguraProduto*0.04,
                                      fontWeight: FontWeight.w900
                                  ),
                                ),
                              ]
                          ),
                        ],
                      )
                    ]
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(widget.larguraProduto*0.05, 0, widget.larguraProduto*0.19, 0),
                      child: Container(
                        width: widget.larguraProduto*0.7,
                        height: widget.larguraProduto*0.7,
                        child: Image.network(widget.produto["imagem"]),
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
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                "R\$",
                                style: TextStyle(
                                  fontSize: widget.larguraProduto*0.04,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                            Text(
                              widget.produto["valor"],
                              style: TextStyle(
                                  fontSize: widget.larguraProduto*0.12,
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
    );
  }
}
