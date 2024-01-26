import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/verification/detail_verification.dart';

import 'controller.dart';
import 'phone_verification.dart';

class Verification extends GetView<VerificationController> {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.verificationState ==
        VerificationState.phoneOnly.toString()) {
      return phoneVerification(context, controller);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            controller.verificationState == VerificationState.full.toString()
                ? Column(
                    children: [
                      Obx(
                        () => EasyStepper(
                          activeStep: controller.activeStep.value,
                          activeStepTextColor: Colors.black87,
                          finishedStepTextColor: Colors.black87,
                          internalPadding: 20,
                          showLoadingAnimation: false,
                          stepRadius: 8,
                          lineStyle: const LineStyle(
                            lineLength: 60,
                            lineWidth: 20,
                          ),
                          showStepBorder: false,
                          padding: const EdgeInsets.only(top: 60),
                          steps: [
                            EasyStep(
                              customStep: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 7,
                                  backgroundColor:
                                      controller.activeStep.value >= 0
                                          ? const Color(0xFF3978EF)
                                          : Colors.white,
                                ),
                              ),
                              title: 'Phone',
                            ),
                            EasyStep(
                              customStep: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 7,
                                  backgroundColor:
                                      controller.activeStep.value >= 1
                                          ? const Color(0xFF3978EF)
                                          : Colors.black,
                                ),
                              ),
                              title: 'Details',
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => verificationStep(
                            context, controller.activeStep.value),
                      )
                    ],
                  )
                : phoneVerificationView(context, controller),
          ],
        ),
      ),
    );
  }

  Widget verificationStep(context, int index) {
    if (index == 0) {
      return Column(
        children: [phoneVerificationView(context, controller)],
      );
    } else {
      return detailVerification(context, controller);
    }
  }
}
