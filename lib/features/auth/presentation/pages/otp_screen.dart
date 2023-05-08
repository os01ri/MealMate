import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/router/app_routes.dart';
import '../widgets/key_board_widget.dart';

class ConfirmPhoneNumberScreen extends StatefulWidget {
  static const String routeName = "confirm_phone_number_screen";
  const ConfirmPhoneNumberScreen({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);
  final String? phoneNumber;
  @override
  _ConfirmPhoneNumberScreenState createState() =>
      _ConfirmPhoneNumberScreenState();
}

class _ConfirmPhoneNumberScreenState extends State<ConfirmPhoneNumberScreen> {
  late Size size;
  late TextEditingController controller;

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
                Positioned(bottom: size.width * .025, child: Icon(Icons.login)),
                Container(
                  height: size.height,
                  width: size.width,
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.6),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * .06),
                      Text('Enter Otp Code',
                          style: AppTextStyles.styleWeight600(fontSize: 16)),
                      SizedBox(height: size.height * .06),
                      const Text('رجاء ادخال رمز التأكيد'),
                      SizedBox(height: size.height * .02),
                      Text(
                        '+963932728290',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 22,
                          color: AppColors.buttonColor,
                        ),
                      ),
                      SizedBox(height: size.height * .04),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MainTextField(
                              controller: controller,
                              enabled: false,
                              width: context.width * .1,
                            ),
                            MainTextField(
                              controller: controller,
                              enabled: false,
                              width: context.width * .1,
                            ),
                            MainTextField(
                              controller: controller,
                              enabled: false,
                              width: context.width * .1,
                            ),
                            MainTextField(
                              controller: controller,
                              enabled: false,
                              width: context.width * .1,
                            ),
                          ]),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .145),
                            child: Row()),
                      ),
                      SizedBox(height: size.width * .05),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'ارسال الرمز مرة ثانية',
                          style: TextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * .05),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'تغير رقم التلفون',
                          style: TextStyle(
                            color: AppColors.buttonColor,
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
