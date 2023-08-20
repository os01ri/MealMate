import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/features/control_panel/presentation/cubit/control_panel_cubit/control_panel_cubit.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/yes_no_dialog.dart';
import '../../../../dependency_injection.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../../../store/data/models/index_ingredients_response_model.dart';
import '../../../store/presentation/widgets/ingredient_card.dart';

class AddRestrictionPage extends StatelessWidget {
  AddRestrictionPage({super.key});
  final ControlPanelCubit cubit = ControlPanelCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        title: 'إضافة استثناء',
      ),
      body: BlocConsumer<ControlPanelCubit, ControlPanelState>(
          bloc: cubit..indexIngredients(),
          builder: (context, state) {
            return SizedBox(
                height: context.height,
                child: state.indexRestrictionsStatus == CubitStatus.success
                    ? state.restrictions.isEmpty
                        ? Center(
                            child: Text(serviceLocator<LocalizationClass>()
                                .appLocalizations!
                                .thereIsNoData),
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
                                              name: state
                                                  .restrictions[index].name,
                                              hash: state
                                                  .restrictions[index].hash,
                                              url:
                                                  state.restrictions[index].url,
                                              price: state
                                                  .restrictions[index].price,
                                              priceBy: state
                                                  .restrictions[index].priceBy))
                                      .onTap(() => showDialog(
                                          context: context,
                                          builder: (_) {
                                            return YesNoDialog(
                                                size: context.deviceSize,
                                                title: serviceLocator<
                                                        LocalizationClass>()
                                                    .appLocalizations!
                                                    .areYouSure,
                                                onTapYes: () {
                                                  cubit.addRestriction(state
                                                      .restrictions[index].id!);
                                                });
                                          })),
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
