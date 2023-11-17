import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/halaman_depan_history/halaman_history_tanggal/halaman_history_tanggal_widget.dart';
import '/halaman_depan_history/history_deliv/history_deliv_widget.dart';
import '/halaman_depan_history/history_food/history_food_widget.dart';
import '/halaman_depan_history/history_mart/history_mart_widget.dart';
import '/halaman_depan_history/history_ride/history_ride_widget.dart';
import 'halaman_depan_history_widget.dart' show HalamanDepanHistoryWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HalamanDepanHistoryModel
    extends FlutterFlowModel<HalamanDepanHistoryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for History_ride component.
  late HistoryRideModel historyRideModel;
  // Model for History_mart component.
  late HistoryMartModel historyMartModel;
  // Model for History_food component.
  late HistoryFoodModel historyFoodModel;
  // Model for History_deliv component.
  late HistoryDelivModel historyDelivModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    historyRideModel = createModel(context, () => HistoryRideModel());
    historyMartModel = createModel(context, () => HistoryMartModel());
    historyFoodModel = createModel(context, () => HistoryFoodModel());
    historyDelivModel = createModel(context, () => HistoryDelivModel());
  }

  void dispose() {
    historyRideModel.dispose();
    historyMartModel.dispose();
    historyFoodModel.dispose();
    historyDelivModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
