import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/toaster.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../../domain/usecases/update_user_info_usecase.dart';
import '../cubit/control_panel_cubit/control_panel_cubit.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _userNameController;
  late final TextEditingController _cityController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    final x = serviceLocator<ControlPanelCubit>().state.user!;
    _userNameController = TextEditingController(text: x.username);
    _nameController = TextEditingController(text: x.name);
    _cityController = TextEditingController(text: x.city);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ControlPanelCubit, ControlPanelState>(
      bloc: serviceLocator<ControlPanelCubit>(),
      listener: _listener,
      child: Scaffold(
        appBar: RecipeAppBar(
          context: context,
          centerText: true,
          title: 'تعديل الملف الشخصي',
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              AuthTextField(
                icon: Icons.person,
                label: serviceLocator<LocalizationClass>().appLocalizations!.username,
                hint: serviceLocator<LocalizationClass>().appLocalizations!.username,
                validator: (text) {
                  if ((text != null && text.length < 3)) {
                    return serviceLocator<LocalizationClass>().appLocalizations!.addValidUsername;
                  }
                  return null;
                },
                controller: _userNameController,
              ),
              AuthTextField(
                icon: Icons.offline_bolt_rounded,
                hint: 'الاسم',
                label: 'الاسم',
                controller: _nameController,
              ),
              AuthTextField(
                icon: Icons.person,
                label: 'المدينة',
                hint: 'المدينة',
                validator: (text) {
                  if ((text != null && text.length < 3)) {
                    return 'أدخل مدينة صحيحة';
                  }
                  return null;
                },
                controller: _cityController,
              ),
              const Spacer(),
              MainButton(
                text: serviceLocator<LocalizationClass>().appLocalizations!.edit,
                color: AppColors.mainColor,
                width: context.width,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    serviceLocator<ControlPanelCubit>().updateUserInfo(
                      UpdateUserInfoParams(
                        name: _nameController.text,
                        username: _userNameController.text,
                        city: _cityController.text,
                      ),
                    );
                  }
                },
              ),
            ],
          ).padding(AppConfig.pagePadding),
        ),
      ),
    );
  }

  void _listener(BuildContext context, ControlPanelState state) {
    if (state.updateUserInfoStatus == CubitStatus.loading) {
      Toaster.showLoading();
    } else if (state.updateUserInfoStatus == CubitStatus.failure) {
      Toaster.closeLoading();
      Toaster.showToast('حدث خطأ، أعد المحاولة');
    } else if (state.updateUserInfoStatus == CubitStatus.success) {
      context.myPop();
      Toaster.closeLoading();
      Toaster.showToast('تم تعديل المعلومات بنجاح');
      serviceLocator<ControlPanelCubit>().getUserInfo();
    }
  }
}
