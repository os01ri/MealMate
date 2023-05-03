import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'main_button.dart';

class DeleteRequestDialog extends StatelessWidget {
  const DeleteRequestDialog({
    Key? key,
    required this.onCancel,
    required this.onDelete,
  }) : super(key: key);

  final VoidCallback onCancel;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(size.width * .05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'delete!',
              style: AppTextStyles.styleWeight700(
                color: Colors.black,
                fontSize: size.width * .05,
              ),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'sure?',
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainButton(
                  text: 'cancel',
                  color: AppColors.grey,
                  textColor: Colors.grey.shade700,
                  onPressed: onCancel,
                ),
                MainButton(
                  text: 'delete',
                  color: AppColors.orange,
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
