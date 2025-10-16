import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pro_mobile/app/core/di/service_locator.dart';
import 'package:pro_mobile/app/routes/app_router.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/constants/constants.dart';
import 'package:pro_mobile/data/remote/calendar/calendar_service.dart';
import 'package:pro_mobile/data/remote/user/user_service.dart';
import 'package:pro_mobile/domain/models/user_model.dart';
import 'package:pro_mobile/providers/user_provider.dart';
import 'package:pro_mobile/ui/base/base_view.dart';
import 'package:pro_mobile/ui/settings/profile/profile_view_model.dart';
import 'package:pro_mobile/ui/utils/flush_bar/app_flush_bar.dart';
import 'package:pro_mobile/ui/utils/image_picker_helper.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/circular_image_widget.dart';
import 'package:pro_mobile/ui/widgets/custom_text.dart';
import 'package:pro_mobile/ui/widgets/form/custom_text_input_2.dart';
import 'package:pro_mobile/ui/widgets/form/multiline_text_input.dart';
import 'package:pro_mobile/ui/widgets/form/phone_number_input.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:pro_mobile/ui/widgets/unfocus_widget.dart';
import 'package:provider/provider.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    Widget formItemSpace = SizedBox(height: size.height * .02);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? user = userProvider.user;

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText("Personal Info", weight: FontWeight.bold),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: BaseView<ProfileViewModel>(
          model: ProfileViewModel(userService:  sl.get<UserService>(), calendarService: sl.get<CalendarService>()),
          onModelReady: (model) {
            model.usernameController.text = user?.username ?? "";
            model.firstNameController.text = user?.firstName ?? "";
            model.lastNameController.text = user?.lastName ?? "";
            model.phoneNumberController.text = user?.phoneNumber ?? "";
            model.bioController.text = user?.bio ?? "";
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
                              Center(
                                child: Stack(
                                  children: [
                                    model.pickedProfileImage != null
                                        ? InkWell(
                                          onTap: () async {
                                            File? pickedFile =
                                                await ImagePickerHelper()
                                                    .pickImageFromGallery();
                                            if (pickedFile != null) {
                                              model.pickedProfileImage =
                                                  pickedFile;
                                            }
                                          },
                                          child: CircularImageWidget(
                                            image: model.pickedProfileImage!,
                                            size: size.width * .3,
                                          ),
                                        )
                                        : InkWell(
                                          onTap: () async {
                                            File? pickedFile =
                                                await ImagePickerHelper()
                                                    .pickImageFromGallery();
                                            if (pickedFile != null) {
                                              model.pickedProfileImage =
                                                  pickedFile;
                                            }
                                          },
                                          child: CircularNetworkImageWidget(
                                            imageUrl:
                                                userProvider
                                                    .user
                                                    ?.profilePhoto ??
                                                StringConstants
                                                    .sampleProfileImage,
                                            size: size.width * .3,
                                          ),
                                        ),
                                    Positioned(
                                      left: size.width * .22,
                                      top: size.height * .1,
                                      child: InkWell(
                                        onTap: () async {
                                          File? pickedFile =
                                              await ImagePickerHelper()
                                                  .pickImageFromGallery();
                                          if (pickedFile != null) {
                                            model.pickedProfileImage =
                                                pickedFile;
                                          }
                                        },
                                        child: Container(
                                          height: size.height * .03,
                                          width: size.height * .03,
                                          decoration: BoxDecoration(
                                            color: AppColors.richBlue
                                                .withValues(alpha: .7),
                                            borderRadius: BorderRadius.circular(
                                              size.height * .015,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            size: size.height * .015,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              formItemSpace,
                              formItemSpace,
                              CustomTextInput2(
                                labelText: "Username",
                                controller: model.usernameController,
                              ),
                              formItemSpace,
                              CustomTextInput2(
                                labelText: "First Name",
                                controller: model.firstNameController,
                              ),
                              formItemSpace,
                              CustomTextInput2(
                                labelText: "Last Name",
                                controller: model.lastNameController,
                              ),
                              formItemSpace,
                              PhoneNumberInput(
                                number: model.number,
                                controller: model.phoneNumberController,
                              ),
                              formItemSpace,
                              Row(
                                children: [
                                  CustomText(
                                    "Your Bio",
                                    size: size.height * 0.016,
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * .007),
                              MultilineTextInput(
                                maxLength: 500,
                                controller: model.bioController,
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
                          isLoading: model.isUpdatingPersonalInfo,
                          onTap: () {
                            String username = model.usernameController.text;
                            String firstName = model.firstNameController.text;
                            String lastName = model.lastNameController.text;
                            String phoneNumber =
                                model.phoneNumberController.text;
                            String bio = model.bioController.text;
                            File? profilePics = model.pickedProfileImage;

                            bool canSubmit = model.isPersonalInfoFormValid(
                              username: username,
                              firstName: firstName,
                              lastName: lastName,
                              phoneNumber: phoneNumber,
                              bio: bio,
                              existingProfileImage: user?.profilePhoto,
                              image: profilePics,
                              onError: (e) {
                                AppFlushBar().showError(
                                  message: e,
                                  context: context,
                                );
                              },
                            );

                            if (canSubmit) {
                              model.updatePersonalInfo(
                                username: username,
                                firstName: firstName,
                                lastName: lastName,
                                phone: phoneNumber,
                                bio: bio,
                                profilePhoto: profilePics,
                                onSuccess: (msg) {
                                  AppFlushBar().showSuccess(
                                    message: msg,
                                    context: context,
                                  );
                                  Future.delayed(Duration(seconds: 3), () {
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRouter.profileUpdate,
                                    );
                                  });
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
