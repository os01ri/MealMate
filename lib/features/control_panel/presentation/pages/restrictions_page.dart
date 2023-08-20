import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/error_widget.dart';
import 'package:mealmate/core/ui/widgets/yes_no_dialog.dart';
import 'package:mealmate/features/control_panel/presentation/cubit/control_panel_cubit/control_panel_cubit.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/presentation/widgets/ingredient_card.dart';

import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';

class RestrictionsPage extends StatelessWidget {
  RestrictionsPage({super.key});
  final ControlPanelCubit cubit = ControlPanelCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        title: 'الاستثناءات',
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.myPushNamed(RoutesNames.addRestriction),
      ),
      body: BlocConsumer<ControlPanelCubit, ControlPanelState>(
          bloc: cubit..indexRestrictions(),
          builder: (context, state) {
            return SizedBox(
                height: context.height,
                child: state.indexRestrictionsStatus == CubitStatus.success
                    ? state.restrictions.isEmpty
                        ? Center(
                            child: Text(serviceLocator<LocalizationClass>()
                                .appLocalizations!
                                .thereIsNoRestrictionsYet),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: .77,
                            ),
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  IngredientCard(
                                      ingredient: IngredientModel(
                                          id: state.restrictions[index].id,
                                          name: state.restrictions[index].name,
                                          hash: state.restrictions[index].hash,
                                          url: state.restrictions[index].url,
                                          price:
                                              state.restrictions[index].price,
                                          priceBy: state
                                              .restrictions[index].priceBy)),
                                  PositionedDirectional(
                                      top: -10,
                                      end: 10,
                                      child: const Icon(
                                        Icons.remove_circle,
                                        color: AppColors.mainColor,
                                      ).onTap(() => showDialog(
                                          context: context,
                                          builder: (_) {
                                            return YesNoDialog(
                                                size: context.deviceSize,
                                                title: serviceLocator<
                                                        LocalizationClass>()
                                                    .appLocalizations!
                                                    .areYouSureYouWantToRemoveRestrictionFromThisIngredient,
                                                onTapYes: () {
                                                  cubit.deleteRestriction(state
                                                      .restrictions[index].id!);
                                                });
                                          })))
                                ],
                              );
                            },
                            itemCount: state.restrictions.length,
                          ).paddingAll(10)
                    : Center(
                        child:
                            state.indexRestrictionsStatus == CubitStatus.loading
                                ? const CircularProgressIndicator.adaptive()
                                : MainErrorWidget(onTap: () {
                                    cubit.indexRestrictions();
                                  }),
                      ));
          },
          listener: (context, state) {}),
    );
  }
}
