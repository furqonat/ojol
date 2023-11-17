import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/halaman_depan_pesanan/pesanan_baru/pesanan_baru_widget.dart';
import '/halaman_depan_pesanan/pesanan_proses/pesanan_proses_widget.dart';
import '/halaman_depan_pesanan/pesanan_selesai/pesanan_selesai_widget.dart';
import 'halaman_pesanan1_widget.dart' show HalamanPesanan1Widget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HalamanPesanan1Model extends FlutterFlowModel<HalamanPesanan1Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for Pesanan_baru component.
  late PesananBaruModel pesananBaruModel;
  // Model for Pesanan_proses component.
  late PesananProsesModel pesananProsesModel;
  // Model for Pesanan_selesai component.
  late PesananSelesaiModel pesananSelesaiModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    pesananBaruModel = createModel(context, () => PesananBaruModel());
    pesananProsesModel = createModel(context, () => PesananProsesModel());
    pesananSelesaiModel = createModel(context, () => PesananSelesaiModel());
  }

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    pesananBaruModel.dispose();
    pesananProsesModel.dispose();
    pesananSelesaiModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
