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

class ProfessionalInfoUpdatePage extends StatefulWidget {
  const ProfessionalInfoUpdatePage({super.key});

  @override
  State<ProfessionalInfoUpdatePage> createState() =>
      _ProfessionalInfoUpdatePageState();
}

class _ProfessionalInfoUpdatePageState
    extends State<ProfessionalInfoUpdatePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    Widget formItemSpace = SizedBox(height: size.height * .02);

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText("Professional Info", weight: FontWeight.bold),
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
                                labelText: "Job Title",
                                controller: model.jobTitleController,
                              ),
                              formItemSpace,
                              CustomTextInput2(
                                labelText: "Years of Experience",
                                controller: model.yearsOfExperienceController,
                              ),
                              formItemSpace,
                              CustomDropdownInput(
                                value: model.selectedIndustrySector,
                                items: [
                                  ...industrySectors.map(
                                    (el) => DropdownMenuItem(
                                      value: el,
                                      child: Text(el),
                                    ),
                                  ),
                                ],
                                onChanged: (val) {
                                  if (val != null) {
                                    model.selectedIndustrySector = val;
                                  }
                                },
                              ),
                              formItemSpace,
                              Row(
                                children: [
                                  CustomText(
                                    "Work Experience / Career Summary",
                                    size: size.height * 0.016,
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * .007),
                              MultilineTextInput(
                                maxLength: 300,
                                controller: model.careerSummaryController,
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
                            String jobTitle = model.jobTitleController.text;
                            String industrySector =
                                model.selectedIndustrySector;
                            String careerSummary =
                                model.careerSummaryController.text;
                            String yearsOfExperience =
                                model.yearsOfExperienceController.text;

                            bool canSubmit = model.isProfessionalInfoFormValid(
                              jobTitle: jobTitle,
                              yearsOfExperience: yearsOfExperience,
                              careerSummary: careerSummary,
                              industrySector: industrySector,
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
