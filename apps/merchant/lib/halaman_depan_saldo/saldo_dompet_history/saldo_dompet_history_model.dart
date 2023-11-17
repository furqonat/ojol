import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/halaman_depan_saldo/saldo_dompet_potongan_food/saldo_dompet_potongan_food_widget.dart';
import 'saldo_dompet_history_widget.dart' show SaldoDompetHistoryWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SaldoDompetHistoryModel
    extends FlutterFlowModel<SaldoDompetHistoryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for Saldo_Dompet_potongan_Food component.
  late SaldoDompetPotonganFoodModel saldoDompetPotonganFoodModel1;
  // Model for Saldo_Dompet_potongan_Food component.
  late SaldoDompetPotonganFoodModel saldoDompetPotonganFoodModel2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    saldoDompetPotonganFoodModel1 =
        createModel(context, () => SaldoDompetPotonganFoodModel());
    saldoDompetPotonganFoodModel2 =
        createModel(context, () => SaldoDompetPotonganFoodModel());
  }

  void dispose() {
    unfocusNode.dispose();
    saldoDompetPotonganFoodModel1.dispose();
    saldoDompetPotonganFoodModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
