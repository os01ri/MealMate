import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/widgets/error_widget.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';

import '../../../../core/ui/theme/colors.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../cubit/profile_cubit.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key, required this.userId});
  final int userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.lightGrey),
          backgroundColor: AppColors.mainColor,
          actions: [
            InkWell(
                onTap: () {},
                child: Container(
                    width: context.width * .013,
                    height: context.width * .013,
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Image.asset(SvgPath.introSvg))),
          ],
          elevation: 0,
        ),
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: AppColors.mainColor,
                body: BlocConsumer<ProfileCubit, ProfileState>(
                  bloc: ProfileCubit(),
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state != false) {
                      //TODO send profileModel
                      return const UserProfileLayout();
                    }
                    if (state == false) {
                      return MainErrorWidget(onTap: () {});
                    }
                    if (state == false) {
                      return const CircularProgressIndicator();
                    } else {
                      return SizedBox(
                        width: 100,
                        height: 100.0,
                        child: Center(child: Text("state is $state")),
                      );
                    }
                  },
                ))));
  }
}

class UserProfileLayout extends StatelessWidget {
  const UserProfileLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 50,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                const Text(
                  'User \$X Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "\$username",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            MainButton(
                                width: context.width * .18,
                                text: 'Follow',
                                color: AppColors.mainColor,
                                onPressed: () {}),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ).paddingAll(5),
                        const Text(
                          "Country",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ).paddingAll(5),
                        const Text(
                          "Following by \$ 100",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ).paddingAll(5),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            'Recipes',
                            style: const TextStyle().largeFontSize.bold,
                          ).paddingVertical(25),
                        ),
                        SizedBox(
                          height: context.height * .45,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: 25,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //Show Recipe
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            AppColors.mainColor.withOpacity(.5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0))),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: CachedNetworkImage(
                                              url:
                                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZeAxmjEiBWqDFmnAq7cvlXRWq_WaaEBVyDolxUAZ0l-B9w4rAAotFfqIVWi1B9l6UBc&usqp=CAU',
                                              hash:
                                                  'LPODnIj[~qof-;fQM{fQoffQM{ay',
                                              width: context.width * .3,
                                              height: context.width * .3,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '\$recipe Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: context.width * .06,
              top: -25,
              child: Container(
                  height: context.width * .2,
                  width: context.width * .2,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0)),
                      border: Border.all(width: 1, color: AppColors.mainColor)),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZeAxmjEiBWqDFmnAq7cvlXRWq_WaaEBVyDolxUAZ0l-B9w4rAAotFfqIVWi1B9l6UBc&usqp=CAU'),
                      fit: BoxFit.cover,
                    )),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
