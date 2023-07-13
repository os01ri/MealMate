import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/helper/assets_paths.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../router/routes_names.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.mainColor.withOpacity(.3),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mainColor.withOpacity(.2),
                ),
                child: SvgPicture.asset(
                  SvgPath.orderSvg,
                  colorFilter:
                      const ColorFilter.mode(AppColors.mainColor, BlendMode.srcIn),
                  width: context.width * .5,
                ),
              ),
              SizedBox(
                height: context.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Your Order Is Placed Successfully',
                    style: AppTextStyles.styleWeight500(
                        fontSize: 20, color: AppColors.mainColor)),
              ),
              MainButton(
                  text: 'Go To Home',
                  color: AppColors.brown,
                  onPressed: () {
                    context.goNamed(RoutesNames.storePage);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
