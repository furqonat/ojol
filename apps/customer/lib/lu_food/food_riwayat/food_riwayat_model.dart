import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/lu_food/food_riwayat_componen/food_riwayat_componen_widget.dart';
import 'food_riwayat_widget.dart' show FoodRiwayatWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FoodRiwayatModel extends FlutterFlowModel<FoodRiwayatWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Food_riwayat_componen component.
  late FoodRiwayatComponenModel foodRiwayatComponenModel1;
  // Model for Food_riwayat_componen component.
  late FoodRiwayatComponenModel foodRiwayatComponenModel2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    foodRiwayatComponenModel1 =
        createModel(context, () => FoodRiwayatComponenModel());
    foodRiwayatComponenModel2 =
        createModel(context, () => FoodRiwayatComponenModel());
  }

  void dispose() {
    unfocusNode.dispose();
    foodRiwayatComponenModel1.dispose();
    foodRiwayatComponenModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
