import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/halaman_depan_order_tersedia/order_tersedia_deliv/order_tersedia_deliv_widget.dart';
import '/halaman_depan_order_tersedia/order_tersedia_food/order_tersedia_food_widget.dart';
import '/halaman_depan_order_tersedia/order_tersedia_mart/order_tersedia_mart_widget.dart';
import '/halaman_depan_order_tersedia/order_tersedia_ride/order_tersedia_ride_widget.dart';
import 'order_tersedia_widget.dart' show OrderTersediaWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderTersediaModel extends FlutterFlowModel<OrderTersediaWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Order_tersedia_ride component.
  late OrderTersediaRideModel orderTersediaRideModel;
  // Model for Order_tersedia_food component.
  late OrderTersediaFoodModel orderTersediaFoodModel;
  // Model for Order_tersedia_mart component.
  late OrderTersediaMartModel orderTersediaMartModel;
  // Model for Order_tersedia_deliv component.
  late OrderTersediaDelivModel orderTersediaDelivModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    orderTersediaRideModel =
        createModel(context, () => OrderTersediaRideModel());
    orderTersediaFoodModel =
        createModel(context, () => OrderTersediaFoodModel());
    orderTersediaMartModel =
        createModel(context, () => OrderTersediaMartModel());
    orderTersediaDelivModel =
        createModel(context, () => OrderTersediaDelivModel());
  }

  void dispose() {
    unfocusNode.dispose();
    orderTersediaRideModel.dispose();
    orderTersediaFoodModel.dispose();
    orderTersediaMartModel.dispose();
    orderTersediaDelivModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
