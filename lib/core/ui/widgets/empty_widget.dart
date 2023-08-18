import 'package:flutter/material.dart';

import '../../../dependency_injection.dart';
import '../../localization/localization_class.dart';
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
          serviceLocator<LocalizationClass>().appLocalizations!.thereIsNoData,
          style: AppTextStyles.styleWeight500(
              fontSize: MediaQuery.of(context).size.width * .04,
              color: Colors.grey.shade500),
        )
      ],
    );
  }
}
