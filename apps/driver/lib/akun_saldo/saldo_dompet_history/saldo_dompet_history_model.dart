import '/akun_saldo/saldo_dompet_potongan_car/saldo_dompet_potongan_car_widget.dart';
import '/akun_saldo/saldo_dompet_potongan_deliv/saldo_dompet_potongan_deliv_widget.dart';
import '/akun_saldo/saldo_dompet_potongan_food/saldo_dompet_potongan_food_widget.dart';
import '/akun_saldo/saldo_dompet_potongan_mart/saldo_dompet_potongan_mart_widget.dart';
import '/akun_saldo/saldo_dompet_potongan_ride/saldo_dompet_potongan_ride_widget.dart';
import '/akun_saldo/saldo_dompet_topup/saldo_dompet_topup_widget.dart';
import '/akun_saldo/saldo_dompet_withdraw/saldo_dompet_withdraw_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
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
  // Model for Saldo_dompet_withdraw component.
  late SaldoDompetWithdrawModel saldoDompetWithdrawModel;
  // Model for Saldo_dompet_topup component.
  late SaldoDompetTopupModel saldoDompetTopupModel;
  // Model for Saldo_dompet_potongan_ride component.
  late SaldoDompetPotonganRideModel saldoDompetPotonganRideModel;
  // Model for Saldo_dompet_potongan_car component.
  late SaldoDompetPotonganCarModel saldoDompetPotonganCarModel;
  // Model for Saldo_dompet_potongan_food component.
  late SaldoDompetPotonganFoodModel saldoDompetPotonganFoodModel;
  // Model for Saldo_dompet_potongan_mart component.
  late SaldoDompetPotonganMartModel saldoDompetPotonganMartModel;
  // Model for Saldo_dompet_potongan_deliv component.
  late SaldoDompetPotonganDelivModel saldoDompetPotonganDelivModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    saldoDompetWithdrawModel =
        createModel(context, () => SaldoDompetWithdrawModel());
    saldoDompetTopupModel = createModel(context, () => SaldoDompetTopupModel());
    saldoDompetPotonganRideModel =
        createModel(context, () => SaldoDompetPotonganRideModel());
    saldoDompetPotonganCarModel =
        createModel(context, () => SaldoDompetPotonganCarModel());
    saldoDompetPotonganFoodModel =
        createModel(context, () => SaldoDompetPotonganFoodModel());
    saldoDompetPotonganMartModel =
        createModel(context, () => SaldoDompetPotonganMartModel());
    saldoDompetPotonganDelivModel =
        createModel(context, () => SaldoDompetPotonganDelivModel());
  }

  void dispose() {
    unfocusNode.dispose();
    saldoDompetWithdrawModel.dispose();
    saldoDompetTopupModel.dispose();
    saldoDompetPotonganRideModel.dispose();
    saldoDompetPotonganCarModel.dispose();
    saldoDompetPotonganFoodModel.dispose();
    saldoDompetPotonganMartModel.dispose();
    saldoDompetPotonganDelivModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
