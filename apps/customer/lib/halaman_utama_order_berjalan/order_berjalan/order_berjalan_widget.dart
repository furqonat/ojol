import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/halaman_utama_order_berjalan/order_berjalan_car/order_berjalan_car_widget.dart';
import '/halaman_utama_order_berjalan/order_berjalan_deliv/order_berjalan_deliv_widget.dart';
import '/halaman_utama_order_berjalan/order_berjalan_food/order_berjalan_food_widget.dart';
import '/halaman_utama_order_berjalan/order_berjalan_mart/order_berjalan_mart_widget.dart';
import '/halaman_utama_order_berjalan/order_berjalan_ride/order_berjalan_ride_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'order_berjalan_model.dart';
export 'order_berjalan_model.dart';

class OrderBerjalanWidget extends StatefulWidget {
  const OrderBerjalanWidget({Key? key}) : super(key: key);

  @override
  _OrderBerjalanWidgetState createState() => _OrderBerjalanWidgetState();
}

class _OrderBerjalanWidgetState extends State<OrderBerjalanWidget> {
  late OrderBerjalanModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderBerjalanModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 24.0, 12.0, 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Color(0xFF3978EF),
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor: Color(0xFF3978EF),
                        icon: Icon(
                          Icons.chevron_left,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 360.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: wrapWithModel(
                          model: _model.orderBerjalanRideModel,
                          updateCallback: () => setState(() {}),
                          child: OrderBerjalanRideWidget(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 360.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: wrapWithModel(
                          model: _model.orderBerjalanFoodModel,
                          updateCallback: () => setState(() {}),
                          child: OrderBerjalanFoodWidget(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 360.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 360.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: wrapWithModel(
                            model: _model.orderBerjalanMartModel,
                            updateCallback: () => setState(() {}),
                            child: OrderBerjalanMartWidget(),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 360.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: wrapWithModel(
                          model: _model.orderBerjalanDelivModel,
                          updateCallback: () => setState(() {}),
                          child: OrderBerjalanDelivWidget(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 360.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: wrapWithModel(
                          model: _model.orderBerjalanCarModel,
                          updateCallback: () => setState(() {}),
                          child: OrderBerjalanCarWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
