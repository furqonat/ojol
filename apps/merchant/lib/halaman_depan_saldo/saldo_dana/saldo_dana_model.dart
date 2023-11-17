import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/halaman_depan_saldo/saldo_dana_topup/saldo_dana_topup_widget.dart';
import 'saldo_dana_widget.dart' show SaldoDanaWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SaldoDanaModel extends FlutterFlowModel<SaldoDanaWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for Saldo_dana_topup component.
  late SaldoDanaTopupModel saldoDanaTopupModel1;
  // Model for Saldo_dana_topup component.
  late SaldoDanaTopupModel saldoDanaTopupModel2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    saldoDanaTopupModel1 = createModel(context, () => SaldoDanaTopupModel());
    saldoDanaTopupModel2 = createModel(context, () => SaldoDanaTopupModel());
  }

  void dispose() {
    unfocusNode.dispose();
    saldoDanaTopupModel1.dispose();
    saldoDanaTopupModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
