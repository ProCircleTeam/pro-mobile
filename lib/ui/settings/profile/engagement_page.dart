import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/domain/models/time_zone.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/user_provider.dart';
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
import 'package:provider/provider.dart';

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
    final iconWidth = size.width * .027;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? user = userProvider.user;

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText("Engagement", weight: FontWeight.bold),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: BaseView<ProfileViewModel>(
          model: ProfileViewModel(sl.get<UserService>()),
          onModelReady: (model) {
            model.availabilityDaysController.text =
                user?.availabilityDays?[0] ?? "";
            model.funFactController.text =
                user?.funFact ?? "";
            model.getSupportedTimeZones((e) {
              AppFlushBar().showError(message: e, context: context);
            });
          },
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
                                icon:
                                    model.isFetchingTimeZones
                                        ? SizedBox(
                                          width: iconWidth,
                                          height: iconWidth,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.richBlue,
                                          ),
                                        )
                                        : null,
                                items: [
                                  ...model.supportedTimeZones.map(
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
                          isLoading: model.isUpdatingEngagementInfo,
                          onTap:
                              model.isUpdatingEngagementInfo
                                  ? () {}
                                  : () {
                                    String availableDays =
                                        model.availabilityDaysController.text;
                                    TimeZoneModel selectedTimeZone =
                                        model.selectedTimeZone;
                                    String funFact =
                                        model.funFactController.text;

                                    bool canSubmit = model
                                        .isEngagementFormValid(
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

                                    if (canSubmit) {
                                      model.updateEngagementInfo(
                                        availabilityDays: [availableDays],
                                        funFact: funFact,
                                        timeZone: selectedTimeZone.id,
                                        onSuccess: (msg) {
                                          AppFlushBar().showSuccess(
                                            message: msg,
                                            context: context,
                                          );
                                          Future.delayed(
                                            Duration(seconds: 3),
                                            () {
                                              Navigator.pop(context);
                                              Navigator.pushReplacementNamed(
                                                context,
                                                AppRouter.profileUpdate,
                                              );
                                            },
                                          );
                                        },
                                        onError: (e) {
                                          AppFlushBar().showError(
                                            message: e,
                                            context: context,
                                          );
                                        },
                                      );
                                    }
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
