import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'chat1_widget.dart' show Chat1Widget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Chat1Model extends FlutterFlowModel<Chat1Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Pencarian widget.
  FocusNode? pencarianFocusNode;
  TextEditingController? pencarianController;
  String? Function(BuildContext, String?)? pencarianControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    pencarianFocusNode?.dispose();
    pencarianController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
