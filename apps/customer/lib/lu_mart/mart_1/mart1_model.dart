import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/lu_mart/mart_daftar_menu/mart_daftar_menu_widget.dart';
import 'mart1_widget.dart' show Mart1Widget;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Mart1Model extends FlutterFlowModel<Mart1Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for Mart_daftar_menu component.
  late MartDaftarMenuModel martDaftarMenuModel1;
  // Model for Mart_daftar_menu component.
  late MartDaftarMenuModel martDaftarMenuModel2;
  // Model for Mart_daftar_menu component.
  late MartDaftarMenuModel martDaftarMenuModel3;
  // Model for Mart_daftar_menu component.
  late MartDaftarMenuModel martDaftarMenuModel4;
  // Model for Mart_daftar_menu component.
  late MartDaftarMenuModel martDaftarMenuModel5;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    martDaftarMenuModel1 = createModel(context, () => MartDaftarMenuModel());
    martDaftarMenuModel2 = createModel(context, () => MartDaftarMenuModel());
    martDaftarMenuModel3 = createModel(context, () => MartDaftarMenuModel());
    martDaftarMenuModel4 = createModel(context, () => MartDaftarMenuModel());
    martDaftarMenuModel5 = createModel(context, () => MartDaftarMenuModel());
  }

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    martDaftarMenuModel1.dispose();
    martDaftarMenuModel2.dispose();
    martDaftarMenuModel3.dispose();
    martDaftarMenuModel4.dispose();
    martDaftarMenuModel5.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
