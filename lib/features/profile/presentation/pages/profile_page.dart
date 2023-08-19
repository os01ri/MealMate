import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';

import '../../../../core/cubit/follow_cubit.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/assets_paths.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../../recipe/presentation/pages/recipes_home_page.dart';
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
      appBar: RecipeAppBar(
        context: context,
        title: 'الملف الشخصي',
        centerText: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
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
                  'Profile',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${user.name}",
                              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                                        text: serviceLocator<LocalizationClass>().appLocalizations!.follow,
                                        color: AppColors.mainColor,
                                        onPressed: () => serviceLocator<FollowCubit>().followUser(user.id!),
                                      );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0).paddingAll(5),
                        Text(
                          "${user.city}",
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ).paddingAll(5),
                        Text(
                          "${serviceLocator<LocalizationClass>().appLocalizations!.followersNumber}  ${user.followby?.length ?? Random().nextInt(250)}  ${serviceLocator<LocalizationClass>().appLocalizations!.people}",
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ).paddingAll(5),
                        // Container(
                        //   alignment: AlignmentDirectional.centerStart,
                        //   child: Text(
                        //     serviceLocator<LocalizationClass>().appLocalizations!.recipes,
                        //     style: const TextStyle().largeFontSize.bold,
                        //   ).paddingVertical(25),
                        // ),
                        SizedBox(
                          width: context.width * .4,
                          child: MainButton(
                            text: serviceLocator<LocalizationClass>().appLocalizations!.recipes,
                            color: AppColors.mainColor,
                            onPressed: () {},
                          ).paddingVertical(25),
                        ),
                        SizedBox(
                          height: context.height * .45,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: .8,
                            ),
                            itemCount: user.recipes!.length,
                            itemBuilder: (context, index) => RecipeCard(recipe: user.recipes![index]),
                          ),
                        ),
                        const SizedBox(height: 30),
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
                      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
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
