import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/cubit/follow_cubit.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/widgets/error_widget.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/dependency_injection.dart';

import '../../../../core/ui/theme/colors.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../data/model/show_user_model.dart';
import '../cubit/profile_cubit.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, required this.userId});
  final int userId;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = ProfileCubit()..showUser(widget.userId);
  }

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
                  bloc: profileCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state.showUserStatus == CubitStatus.success) {
                      return UserProfileLayout(user: state.user!);
                    }
                    if (state.showUserStatus == CubitStatus.failure) {
                      return Center(
                        child: MainErrorWidget(onTap: () {
                          profileCubit.showUser(widget.userId);
                        }),
                      );
                    }
                    if (state.showUserStatus == CubitStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ))));
  }
}

class UserProfileLayout extends StatelessWidget {
  const UserProfileLayout({super.key, required this.user});
  final ProfileModel user;
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
                  ' Profile',
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
                            Text(
                              "${user.username}",
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            BlocBuilder<FollowCubit, FollowState>(
                              bloc: serviceLocator<FollowCubit>(),
                              builder: (context, state) {
                                return state.followStatus == CubitStatus.loading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : MainButton(
                                        width: context.width * .18,
                                        text: 'Follow',
                                        color: AppColors.mainColor,
                                        onPressed: () {
                                          serviceLocator<FollowCubit>()
                                              .followUser(user.id!);
                                        });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ).paddingAll(5),
                        Text(
                          "${user.city}",
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ).paddingAll(5),
                        Text(
                          "Following by  ${user.followby?.length ?? Random().nextInt(250)}",
                          style: const TextStyle(
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
                            itemCount: user.recipes!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //Show Recipe
                                  print(user.logo);
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
                                              url: user.recipes?[index].url ??
                                                  SvgPath.defaultImage,
                                              hash: user.recipes?[index].hash ??
                                                  SvgPath.defaultHash,
                                              width: context.width * .3,
                                              height: context.width * .3,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              user.recipes![index].name!,
                                              style: const TextStyle(
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
                  child: CachedNetworkImage(
                      hash: user.hash ?? SvgPath.defaultHash,
                      borderRadius: BorderRadius.circular(6),
                      url: user.logo ?? SvgPath.defaultImage,
                      width: context.width * .2,
                      height: context.width * .2)),
            ),
          ],
        ),
      ],
    );
  }
}
