import '/akun_saldo/saldo_dana_car/saldo_dana_car_widget.dart';
import '/akun_saldo/saldo_dana_deliv/saldo_dana_deliv_widget.dart';
import '/akun_saldo/saldo_dana_food/saldo_dana_food_widget.dart';
import '/akun_saldo/saldo_dana_mart/saldo_dana_mart_widget.dart';
import '/akun_saldo/saldo_dana_ride/saldo_dana_ride_widget.dart';
import '/akun_saldo/saldo_dana_topup/saldo_dana_topup_widget.dart';
import '/akun_saldo/saldo_dana_withdraw/saldo_dana_withdraw_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
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
  late SaldoDanaTopupModel saldoDanaTopupModel;
  // Model for Saldo_dana_withdraw component.
  late SaldoDanaWithdrawModel saldoDanaWithdrawModel;
  // Model for Saldo_dana_ride component.
  late SaldoDanaRideModel saldoDanaRideModel;
  // Model for Saldo_dana_car component.
  late SaldoDanaCarModel saldoDanaCarModel;
  // Model for Saldo_dana_food component.
  late SaldoDanaFoodModel saldoDanaFoodModel;
  // Model for Saldo_dana_mart component.
  late SaldoDanaMartModel saldoDanaMartModel;
  // Model for Saldo_dana_deliv component.
  late SaldoDanaDelivModel saldoDanaDelivModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    saldoDanaTopupModel = createModel(context, () => SaldoDanaTopupModel());
    saldoDanaWithdrawModel =
        createModel(context, () => SaldoDanaWithdrawModel());
    saldoDanaRideModel = createModel(context, () => SaldoDanaRideModel());
    saldoDanaCarModel = createModel(context, () => SaldoDanaCarModel());
    saldoDanaFoodModel = createModel(context, () => SaldoDanaFoodModel());
    saldoDanaMartModel = createModel(context, () => SaldoDanaMartModel());
    saldoDanaDelivModel = createModel(context, () => SaldoDanaDelivModel());
  }

  void dispose() {
    unfocusNode.dispose();
    saldoDanaTopupModel.dispose();
    saldoDanaWithdrawModel.dispose();
    saldoDanaRideModel.dispose();
    saldoDanaCarModel.dispose();
    saldoDanaFoodModel.dispose();
    saldoDanaMartModel.dispose();
    saldoDanaDelivModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
