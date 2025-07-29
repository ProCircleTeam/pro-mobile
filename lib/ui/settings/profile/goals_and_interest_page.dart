import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/settings/profile/profile_view_model.dart';
import 'package:pro_mobile/ui/utils/flush_bar/app_flush_bar.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/form/custom_dropdown_input.dart';
import 'package:pro_mobile/ui/widgets/form/custom_text_input_2.dart';
import 'package:pro_mobile/ui/widgets/form/multiline_text_input.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/unfocus_widget.dart';

class GoalsAndInterestPage extends StatefulWidget {
  const GoalsAndInterestPage({super.key});

  @override
  State<GoalsAndInterestPage> createState() => _GoalsAndInterestPageState();
}

class _GoalsAndInterestPageState extends State<GoalsAndInterestPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    Widget formItemSpace = SizedBox(height: size.height * .02);

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText("Goals and Interest", weight: FontWeight.bold),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: BaseView<ProfileViewModel>(
          model: ProfileViewModel(sl.get<UserService>()),
          builder: (context, model, _) {
            return SizedBox(
              height: size.height,
              child: PaddedContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: model.personalInfoFormKey,
                          child: Column(
                            children: [
                              formItemSpace,
                              formItemSpace,
                              CustomTextInput2(
                                labelText: "Preferred partner trait",
                                controller:
                                    model.preferredPartnersTraitController,
                              ),
                              formItemSpace,
                              CustomDropdownInput(
                                value: model.selectedInterest,
                                items: [
                                  ...interests.map(
                                    (el) => DropdownMenuItem(
                                      value: el,
                                      child: Text(el),
                                    ),
                                  ),
                                ],
                                onChanged: (val) {
                                  if (val != null) {
                                    model.selectedInterest = val;
                                  }
                                },
                              ),
                              formItemSpace,
                              Row(
                                children: [
                                  CustomText(
                                    "Long term goal (personal / professional)",
                                    size: size.height * 0.016,
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * .007),
                              MultilineTextInput(
                                maxLength: 300,
                                controller: model.longTermGoalController,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ActionButton(
                          title: "Update",
                          onTap: () {
                            String partnerTrait =
                                model.preferredPartnersTraitController.text;
                            String interest = model.selectedInterest;
                            String longTermGoal =
                                model.longTermGoalController.text;

                            print(
                              "partnerTrait ==================> $partnerTrait",
                            );
                            print("interest ==================> $interest");
                            print(
                              "longTermGoal ==================> $longTermGoal",
                            );

                            bool canSubmit = model.isGoalAndInterestFormValid(
                              interest: interest,
                              partnerTrait: partnerTrait,
                              longTermGoal: longTermGoal,
                              onError: (e) {
                                AppFlushBar().showError(
                                  message: e,
                                  context: context,
                                );
                              },
                            );

                            if (canSubmit) {}
                          },
                        ),

                        SizedBox(
                          height: viewInsets.bottom > 0 ? 0 : size.height * .04,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
