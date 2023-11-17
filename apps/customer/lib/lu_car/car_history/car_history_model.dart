import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/lu_ride/ride_history_komponen/ride_history_komponen_widget.dart';
import 'car_history_widget.dart' show CarHistoryWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarHistoryModel extends FlutterFlowModel<CarHistoryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for Ride_history_komponen component.
  late RideHistoryKomponenModel rideHistoryKomponenModel1;
  // Model for Ride_history_komponen component.
  late RideHistoryKomponenModel rideHistoryKomponenModel2;
  // Model for Ride_history_komponen component.
  late RideHistoryKomponenModel rideHistoryKomponenModel3;
  // Model for Ride_history_komponen component.
  late RideHistoryKomponenModel rideHistoryKomponenModel4;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    rideHistoryKomponenModel1 =
        createModel(context, () => RideHistoryKomponenModel());
    rideHistoryKomponenModel2 =
        createModel(context, () => RideHistoryKomponenModel());
    rideHistoryKomponenModel3 =
        createModel(context, () => RideHistoryKomponenModel());
    rideHistoryKomponenModel4 =
        createModel(context, () => RideHistoryKomponenModel());
  }

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    rideHistoryKomponenModel1.dispose();
    rideHistoryKomponenModel2.dispose();
    rideHistoryKomponenModel3.dispose();
    rideHistoryKomponenModel4.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
