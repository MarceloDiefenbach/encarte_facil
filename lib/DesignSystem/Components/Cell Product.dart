
import 'package:encarte_facil_2/DesignSystem/DesignTokens.dart';
import 'package:flutter/material.dart';

class CellProductWidget extends StatelessWidget {
  get textController => null;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(spacingXXS(height), 0, spacingXXS(height), 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, spacingNano(height)),
            child: Text(
              'Produto 1',
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: colorNeutralHighPure(),
              borderRadius: BorderRadius.only(
                topLeft: borderRadiusMedium(),
                topRight: borderRadiusMedium(),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(spacingXXS(height), 0, 0, 0),
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
                    color: colorNeutralLowPure(),
                    size: 30,
                  )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: colorNeutralHighPure(),
              borderRadius: BorderRadius.only(
                bottomLeft: borderRadiusMedium(),
                bottomRight: borderRadiusMedium(),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(spacingXXS(height), 0, 0, 0),
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, spacingXXS(height), 0),
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
