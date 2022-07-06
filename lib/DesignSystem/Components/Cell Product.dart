
import 'package:flutter/material.dart';

class CellProductWidget extends StatelessWidget {
  get textController => null;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
            child: Text(
              'Produto 1',
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      'Nome do produto',
                      // style: FlutterFlowTheme.of(context).bodyText1.override(
                      //   fontFamily: 'Montserrat',
                      // ),
                    ),
                  ),
                ),
                Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black,
                    size: 30,
                  )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      'Valor do produto',
                      // style: FlutterFlowTheme.of(context).bodyText1.override(
                      //   fontFamily: 'Montserrat',
                      // ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0, -1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          // labelStyle:
                          // FlutterFlowTheme.of(context).bodyText1.override(
                          //   fontFamily: 'Montserrat',
                          // ),
                          hintText: 'Digite o valor',
                          // hintStyle:
                          // FlutterFlowTheme.of(context).bodyText1.override(
                          //   fontFamily: 'Montserrat',
                          // ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        // style: FlutterFlowTheme.of(context).bodyText1.override(
                        //   fontFamily: 'Montserrat',
                        // ),
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
