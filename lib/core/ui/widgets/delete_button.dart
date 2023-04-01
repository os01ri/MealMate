import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'delete_request_dialog.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return DeleteRequestDialog(
              onCancel: () => Navigator.of(context).pop(),
              onDelete: () {
                onTap();
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.lightRed,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.all(10),
        // child: SvgPicture.asset(
        //   SvgPath.deleteIcon,
        //   color: MealMateColors.red,
        // ),
      ),
    );
  }
}
