import 'package:flutter/material.dart';

import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/main_app_bar.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../core/ui/widgets/main_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late Size size;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(size: size, titleText: 'Create an Account'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthTextField(label: 'User Name', hint: 'username'),
            Row(
              children: [
                Expanded(
                  child: AuthTextField(hint: 'first name', label: 'First Name'),
                ),
                Expanded(
                  child: AuthTextField(hint: 'last name', label: 'Last Name'),
                ),
              ],
            ),
            AuthTextField(hint: 'you@example.com', label: 'E-mail'),
            AuthTextField(label: 'Password', hint: '********'),
            AuthTextField(label: 'Confirm Password', hint: '********'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MainButton(
                text: 'Sign Up',
                color: AppColors.buttonColor,
                onPressed: () {},
                width: MediaQuery.of(context).size.width,
              ),
            ),
            RichText(
                text: TextSpan(
                    text: 'By continuing you agree to the\n',
                    style: AppTextStyles.styleWeight400(color: Colors.grey),
                    children: [
                  TextSpan(
                      text: 'Terms of Services',
                      style: AppTextStyles.styleWeight600(
                          color: AppColors.buttonColor)),
                  TextSpan(text: ' & '),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: AppTextStyles.styleWeight600(
                          color: AppColors.buttonColor))
                ]))
          ],
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({super.key, required this.hint, required this.label});

  final String hint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.topLeft,
            child: Text(
              label,
            ),
          ),
          MainTextField(
            fillColor: AppColors.scaffoldBackgroundColor,
            controller: TextEditingController(),
            hint: hint,
          ),
        ],
      ),
    );
  }
}
