import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/domain/models/time_zone.dart';
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

class EngagementPage extends StatefulWidget {
  const EngagementPage({super.key});

  @override
  State<EngagementPage> createState() => _EngagementPageState();
}

class _EngagementPageState extends State<EngagementPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    Widget formItemSpace = SizedBox(height: size.height * .02);

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText("Engagement", weight: FontWeight.bold),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: BaseView<ProfileViewModel>(
          model: ProfileViewModel(),
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
                                labelText: "Days available",
                                controller: model.availabilityDaysController,
                              ),
                              formItemSpace,
                              CustomDropdownInput<TimeZoneModel>(
                                value: model.selectedTimeZone,
                                items: [
                                  ...timeZones.map(
                                    (el) => DropdownMenuItem(
                                      value: el,
                                      child: Text(
                                        "${el.name} (${el.abbreviation})",
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (val) {
                                  if (val != null) {
                                    model.selectedTimeZone = val;
                                  }
                                },
                              ),
                              formItemSpace,
                              Row(
                                children: [
                                  CustomText(
                                    "Fun fact",
                                    size: size.height * 0.016,
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * .007),
                              MultilineTextInput(
                                maxLength: 300,
                                controller: model.funFactController,
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
                            String availableDays =
                                model.availabilityDaysController.text;
                            TimeZoneModel selectedTimeZone =
                                model.selectedTimeZone;
                            String funFact = model.funFactController.text;

                            print(
                              "partnerTrait ==================> $availableDays",
                            );
                            print(
                              "interest ==================> $selectedTimeZone",
                            );
                            print("longTermGoal ==================> $funFact");

                            bool canSubmit = model.isEngagementFormValid(
                              availableDays: availableDays,
                              timeZone: selectedTimeZone.id,
                              funFact: funFact,
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
