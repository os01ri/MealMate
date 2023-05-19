import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';

import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/main_text_field.dart';
import '../../../../router/app_routes.dart';
import '../widgets/key_board_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Size size;
  late TextEditingController controller;
  ValueNotifier<String> otpController = ValueNotifier('');
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    controller = TextEditingController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(bottom: size.width * .025, child: const Icon(Icons.login)),
                Container(
                  height: size.height,
                  width: size.width,
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * .06),
                      Text('Enter Otp Code', style: AppTextStyles.styleWeight600(fontSize: 24)),
                      SizedBox(height: size.height * .06),
                      Text('رجاء ادخال رمز التأكيد', style: AppTextStyles.styleWeight500(fontSize: 16)),
                      SizedBox(height: size.height * .02),
                      const Text(
                        '+963932728290',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 22,
                          color: AppColors.mainColor,
                        ),
                      ),
                      SizedBox(height: size.height * .04),
                      ValueListenableBuilder(
                          valueListenable: otpController,
                          builder: (context, value, _) {
                            return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  MainTextField(
                                    controller: TextEditingController(text: value.isNotEmpty ? value[0] : ''),
                                    enabled: false,
                                    width: context.width * .1,
                                  ),
                                  MainTextField(
                                    controller: TextEditingController(text: value.length > 1 ? value[1] : ''),
                                    enabled: false,
                                    width: context.width * .1,
                                  ),
                                  MainTextField(
                                    controller: TextEditingController(text: value.length > 2 ? value[2] : ''),
                                    enabled: false,
                                    width: context.width * .1,
                                  ),
                                  MainTextField(
                                    controller: TextEditingController(text: value.length > 3 ? value[3] : ''),
                                    enabled: false,
                                    width: context.width * .1,
                                  ),
                                ]);
                          }),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child:
                            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * .145), child: const Row()),
                      ),
                      SizedBox(height: size.width * .05),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'ارسال الرمز مرة ثانية',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * .05),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'تغير رقم التلفون',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * .035),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: KeyboardNumber(
                          textEditingController: controller,
                          size: size,
                          value: otpController,
                          maxLength: 4,
                          onTap: () {
                            context.push(Routes.accountCreationLoading);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
