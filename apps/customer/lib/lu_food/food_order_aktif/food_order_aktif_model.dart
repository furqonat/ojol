import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/lu_food/food_daftar_pesanan/food_daftar_pesanan_widget.dart';
import 'food_order_aktif_widget.dart' show FoodOrderAktifWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FoodOrderAktifModel extends FlutterFlowModel<FoodOrderAktifWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Food_daftar_pesanan component.
  late FoodDaftarPesananModel foodDaftarPesananModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    foodDaftarPesananModel =
        createModel(context, () => FoodDaftarPesananModel());
  }

  void dispose() {
    unfocusNode.dispose();
    foodDaftarPesananModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
