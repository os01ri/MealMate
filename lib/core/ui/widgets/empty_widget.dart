import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // SvgPicture.asset(SvgPath.noData),
        const SizedBox(height: 16),
        Text(
          'noData',
          style: AppTextStyles.styleWeight500(
              fontSize: MediaQuery.of(context).size.width * .04, color: Colors.grey.shade500),
        )
      ],
    );
  }
}
