import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/ui/widgets/error_widget.dart';

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
                      return _buildProfile(state);
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

  _buildProfile(profileResponseModel) => ListView(
        children: [
          Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'profileResponseModel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2.5,
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
                          horizontal: 2,
                          vertical: 2,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 8.0,
                            ),
                            const SizedBox(
                              width: 100,
                              child: Text(
                                "my addresses",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            const LimitedBox(
                              maxHeight: 10,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [],
                              ),
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  child: const Row(
                                    children: [
                                      Text("Add a new title"),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 15.0,
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 4.0,
                            ),
                            if ('profileResponseModel' == null) ...{
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  "Country",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 2.0,
                              ),
                              const SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: CachedNetworkImage(
                                          url: ('profileResponseModel') ?? "",
                                          hash: '',
                                          height: 50,
                                          width: 50),
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "hello",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            },
                            const SizedBox(
                              height: 3.0,
                            ),
                            const SizedBox(
                              width: 100,
                              child: Text(
                                "my occasions",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            SizedBox(
                              height: 20.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: ListView.builder(
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            //check event existing
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: AppColors.mainColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.0))),
                                              child: const Column(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CachedNetworkImage(
                                                            url:
                                                                'profileResponseModel',
                                                            hash: '',
                                                            width: 50,
                                                            height: 50,
                                                          )),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                        width: 20,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Text(
                                                            'profileResponseModel',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10.0),
                                                            maxLines: 1,
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
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
                  right: 4,
                  top: 0,
                  child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0)),
                          border:
                              Border.all(width: 1, color: AppColors.mainColor)),
                      child: 'profileResponseModel' == null
                          ? Container(
                              decoration: const BoxDecoration(),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage('profileResponseModel'),
                                fit: BoxFit.cover,
                              )),
                            )),
                ),
              ],
            ),
          ),
        ],
      );
}
