// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../theme/colors.dart';
// import '../theme/text_styles.dart';

// class CodeTextField extends StatelessWidget {
//   const CodeTextField({
//     Key? key,
//     this.length = 5,
//     this.keyboardType = TextInputType.number,
//     required this.controller,
//   }) : super(key: key);
//   final int length;
//   final TextInputType keyboardType;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: size.width * .035),
//       child: Directionality(
//         textDirection: TextDirection.ltr,
//         child: PinCodeTextField(
//           appContext: context,
//           controller: controller,
//           length: 5,
//           textStyle: AppTextStyles.styleWeight600(
//             fontSize: size.width * .065,
//           ),
//           onChanged: (text) {
//             // controller.text = text.toUpperCase();
//           },
//           keyboardType: keyboardType,
//           enableActiveFill: true,
//           pinTheme: PinTheme(
//             inactiveFillColor: AppColors.grey2,
//             inactiveColor: AppColors.grey2,
//             activeColor: Theme.of(context).primaryColor,
//             activeFillColor: Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(12.5),
//             shape: PinCodeFieldShape.box,
//             fieldHeight: size.width * .175,
//             fieldWidth: size.width * .15,
//             borderWidth: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }
