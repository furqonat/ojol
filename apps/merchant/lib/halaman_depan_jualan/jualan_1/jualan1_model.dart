import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/halaman_depan_jualan/jualan_buttom_sheet/jualan_buttom_sheet_widget.dart';
import 'jualan1_widget.dart' show Jualan1Widget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Jualan1Model extends FlutterFlowModel<Jualan1Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for Jualan_buttom_sheet component.
  late JualanButtomSheetModel jualanButtomSheetModel1;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for Jualan_buttom_sheet component.
  late JualanButtomSheetModel jualanButtomSheetModel2;
  // Model for Jualan_buttom_sheet component.
  late JualanButtomSheetModel jualanButtomSheetModel3;
  // Model for Jualan_buttom_sheet component.
  late JualanButtomSheetModel jualanButtomSheetModel4;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    jualanButtomSheetModel1 =
        createModel(context, () => JualanButtomSheetModel());
    jualanButtomSheetModel2 =
        createModel(context, () => JualanButtomSheetModel());
    jualanButtomSheetModel3 =
        createModel(context, () => JualanButtomSheetModel());
    jualanButtomSheetModel4 =
        createModel(context, () => JualanButtomSheetModel());
  }

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    jualanButtomSheetModel1.dispose();
    jualanButtomSheetModel2.dispose();
    jualanButtomSheetModel3.dispose();
    jualanButtomSheetModel4.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
