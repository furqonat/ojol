import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/halaman_utama_order_history/order_history_car/order_history_car_widget.dart';
import '/halaman_utama_order_history/order_history_deliv/order_history_deliv_widget.dart';
import '/halaman_utama_order_history/order_history_food/order_history_food_widget.dart';
import '/halaman_utama_order_history/order_history_mart/order_history_mart_widget.dart';
import '/halaman_utama_order_history/order_history_ride/order_history_ride_widget.dart';
import 'order_histoey_widget.dart' show OrderHistoeyWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderHistoeyModel extends FlutterFlowModel<OrderHistoeyWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Order_history_car component.
  late OrderHistoryCarModel orderHistoryCarModel;
  // Model for Order_history_deliv component.
  late OrderHistoryDelivModel orderHistoryDelivModel;
  // Model for Order_history_food component.
  late OrderHistoryFoodModel orderHistoryFoodModel;
  // Model for Order_history_mart component.
  late OrderHistoryMartModel orderHistoryMartModel;
  // Model for Order_history_ride component.
  late OrderHistoryRideModel orderHistoryRideModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    orderHistoryCarModel = createModel(context, () => OrderHistoryCarModel());
    orderHistoryDelivModel =
        createModel(context, () => OrderHistoryDelivModel());
    orderHistoryFoodModel = createModel(context, () => OrderHistoryFoodModel());
    orderHistoryMartModel = createModel(context, () => OrderHistoryMartModel());
    orderHistoryRideModel = createModel(context, () => OrderHistoryRideModel());
  }

  void dispose() {
    unfocusNode.dispose();
    orderHistoryCarModel.dispose();
    orderHistoryDelivModel.dispose();
    orderHistoryFoodModel.dispose();
    orderHistoryMartModel.dispose();
    orderHistoryRideModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
