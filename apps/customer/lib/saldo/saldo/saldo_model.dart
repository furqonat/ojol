import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/saldo/saldo_dana_potongan_car/saldo_dana_potongan_car_widget.dart';
import '/saldo/saldo_dana_potongan_deliv/saldo_dana_potongan_deliv_widget.dart';
import '/saldo/saldo_dana_potongan_food/saldo_dana_potongan_food_widget.dart';
import '/saldo/saldo_dana_potongan_mart/saldo_dana_potongan_mart_widget.dart';
import '/saldo/saldo_dana_potongan_ride/saldo_dana_potongan_ride_widget.dart';
import '/saldo/saldo_dana_topup/saldo_dana_topup_widget.dart';
import '/saldo/saldo_dana_withdraw/saldo_dana_withdraw_widget.dart';
import 'saldo_widget.dart' show SaldoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SaldoModel extends FlutterFlowModel<SaldoWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for Saldo_dana_withdraw component.
  late SaldoDanaWithdrawModel saldoDanaWithdrawModel;
  // Model for Saldo_dana_topup component.
  late SaldoDanaTopupModel saldoDanaTopupModel;
  // Model for Saldo_dana_potongan_mart component.
  late SaldoDanaPotonganMartModel saldoDanaPotonganMartModel;
  // Model for Saldo_dana_potongan_food component.
  late SaldoDanaPotonganFoodModel saldoDanaPotonganFoodModel;
  // Model for Saldo_dana_potongan_deliv component.
  late SaldoDanaPotonganDelivModel saldoDanaPotonganDelivModel;
  // Model for Saldo_dana_potongan_ride component.
  late SaldoDanaPotonganRideModel saldoDanaPotonganRideModel;
  // Model for Saldo_dana_potongan_car component.
  late SaldoDanaPotonganCarModel saldoDanaPotonganCarModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    saldoDanaWithdrawModel =
        createModel(context, () => SaldoDanaWithdrawModel());
    saldoDanaTopupModel = createModel(context, () => SaldoDanaTopupModel());
    saldoDanaPotonganMartModel =
        createModel(context, () => SaldoDanaPotonganMartModel());
    saldoDanaPotonganFoodModel =
        createModel(context, () => SaldoDanaPotonganFoodModel());
    saldoDanaPotonganDelivModel =
        createModel(context, () => SaldoDanaPotonganDelivModel());
    saldoDanaPotonganRideModel =
        createModel(context, () => SaldoDanaPotonganRideModel());
    saldoDanaPotonganCarModel =
        createModel(context, () => SaldoDanaPotonganCarModel());
  }

  void dispose() {
    unfocusNode.dispose();
    saldoDanaWithdrawModel.dispose();
    saldoDanaTopupModel.dispose();
    saldoDanaPotonganMartModel.dispose();
    saldoDanaPotonganFoodModel.dispose();
    saldoDanaPotonganDelivModel.dispose();
    saldoDanaPotonganRideModel.dispose();
    saldoDanaPotonganCarModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
