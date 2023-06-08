import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width * .75,
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: context.width * .25),
              const Text("Meal Mate"),
              SizedBox(height: context.width * .075),
              // BlocProvider(
              //   create: (context) => AppBarManagerBloc(),
              //   child: BlocBuilder<AppBarManagerBloc, AppBarManagerState>(
              //     builder: (context, state) {
              //       return TextButton(
              //         onPressed: () {
              //           context.read<AppBarManagerBloc>().add(
              //                 LogOutEvent(context: context),
              //               );
              //         },
              //         style: ButtonStyle(
              //           fixedSize: MaterialStateProperty.all(
              //             Size.fromWidth(
              //               size.width,
              //             ),
              //           ),
              //         ),
              //         child: Text(
              //           "تسجيل الخروج",
              //           style: TextStyle(
              //             color: AppColors.purple,
              //             fontSize: size.width * .04,
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  // void onTapNavigator({
  //   required String routeName,
  //   required BuildContext context,
  // }) {
  //   var route = ModalRoute.of(context);
  //   if (route != null) {
  //     if (route.settings.name == routeName) {
  //       Navigator.of(context).pop();
  //       return;
  //     }
  //   }
  //   Navigator.of(context).pop();

  //   Navigator.of(context).pushNamedAndRemoveUntil(
  //     routeName,
  //     (route) {
  //       return route.settings.name == HomeScreen.routeName;
  //     },
  //   );
  // }
}
