import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/lu_mart/mart_daftar_liat/mart_daftar_liat_widget.dart';
import 'mart2_widget.dart' show Mart2Widget;
import 'package:badges/badges.dart' as badges;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Mart2Model extends FlutterFlowModel<Mart2Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for Mart_daftar_liat component.
  late MartDaftarLiatModel martDaftarLiatModel1;
  // Model for Mart_daftar_liat component.
  late MartDaftarLiatModel martDaftarLiatModel2;
  // Model for Mart_daftar_liat component.
  late MartDaftarLiatModel martDaftarLiatModel3;
  // Model for Mart_daftar_liat component.
  late MartDaftarLiatModel martDaftarLiatModel4;
  // Model for Mart_daftar_liat component.
  late MartDaftarLiatModel martDaftarLiatModel5;
  // Model for Mart_daftar_liat component.
  late MartDaftarLiatModel martDaftarLiatModel6;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    martDaftarLiatModel1 = createModel(context, () => MartDaftarLiatModel());
    martDaftarLiatModel2 = createModel(context, () => MartDaftarLiatModel());
    martDaftarLiatModel3 = createModel(context, () => MartDaftarLiatModel());
    martDaftarLiatModel4 = createModel(context, () => MartDaftarLiatModel());
    martDaftarLiatModel5 = createModel(context, () => MartDaftarLiatModel());
    martDaftarLiatModel6 = createModel(context, () => MartDaftarLiatModel());
  }

  void dispose() {
    unfocusNode.dispose();
    martDaftarLiatModel1.dispose();
    martDaftarLiatModel2.dispose();
    martDaftarLiatModel3.dispose();
    martDaftarLiatModel4.dispose();
    martDaftarLiatModel5.dispose();
    martDaftarLiatModel6.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
