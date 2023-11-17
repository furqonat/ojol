import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/halaman_depan_history/history_buttom_sheet/history_buttom_sheet_widget.dart';
import 'history_widget.dart' show HistoryWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HistoryModel extends FlutterFlowModel<HistoryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for History_buttom_sheet component.
  late HistoryButtomSheetModel historyButtomSheetModel1;
  // Model for History_buttom_sheet component.
  late HistoryButtomSheetModel historyButtomSheetModel2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    historyButtomSheetModel1 =
        createModel(context, () => HistoryButtomSheetModel());
    historyButtomSheetModel2 =
        createModel(context, () => HistoryButtomSheetModel());
  }

  void dispose() {
    unfocusNode.dispose();
    historyButtomSheetModel1.dispose();
    historyButtomSheetModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
