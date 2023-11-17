import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/halaman_utama_order_berjalan/order_berjalan_car/order_berjalan_car_widget.dart';
import '/halaman_utama_order_berjalan/order_berjalan_deliv/order_berjalan_deliv_widget.dart';
import '/halaman_utama_order_berjalan/order_berjalan_food/order_berjalan_food_widget.dart';
import '/halaman_utama_order_berjalan/order_berjalan_mart/order_berjalan_mart_widget.dart';
import '/halaman_utama_order_berjalan/order_berjalan_ride/order_berjalan_ride_widget.dart';
import 'order_berjalan_widget.dart' show OrderBerjalanWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderBerjalanModel extends FlutterFlowModel<OrderBerjalanWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Order_berjalan_ride component.
  late OrderBerjalanRideModel orderBerjalanRideModel;
  // Model for Order_berjalan_food component.
  late OrderBerjalanFoodModel orderBerjalanFoodModel;
  // Model for Order_berjalan_mart component.
  late OrderBerjalanMartModel orderBerjalanMartModel;
  // Model for Order_berjalan_deliv component.
  late OrderBerjalanDelivModel orderBerjalanDelivModel;
  // Model for Order_berjalan_car component.
  late OrderBerjalanCarModel orderBerjalanCarModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    orderBerjalanRideModel =
        createModel(context, () => OrderBerjalanRideModel());
    orderBerjalanFoodModel =
        createModel(context, () => OrderBerjalanFoodModel());
    orderBerjalanMartModel =
        createModel(context, () => OrderBerjalanMartModel());
    orderBerjalanDelivModel =
        createModel(context, () => OrderBerjalanDelivModel());
    orderBerjalanCarModel = createModel(context, () => OrderBerjalanCarModel());
  }

  void dispose() {
    unfocusNode.dispose();
    orderBerjalanRideModel.dispose();
    orderBerjalanFoodModel.dispose();
    orderBerjalanMartModel.dispose();
    orderBerjalanDelivModel.dispose();
    orderBerjalanCarModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
