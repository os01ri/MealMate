import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/features/recipe/domain/usecases/index_recipes_usecase.dart';
import 'package:mealmate/features/recipe/presentation/cubit/recipe_cubit.dart';

import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';

class FloatingSearchTextFailed extends StatelessWidget {
  const FloatingSearchTextFailed({
    super.key,
    required this.floatingSearchBarController,
  });
  final FloatingSearchBarController floatingSearchBarController;

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      margins: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      hint: 'بحث ...',
      width: context.width,
      controller: floatingSearchBarController,
      elevation: 5,
      borderRadius: BorderRadius.zero,
      backgroundColor: Colors.white,
      height: context.width * .15,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        log(query);
      },
      iconColor: AppColors.mainColor,
      clearQueryOnClose: false,
      closeOnBackdropTap: false,
      onSubmitted: (query) {
        floatingSearchBarController.query = query;
        floatingSearchBarController.close();
        context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(name: query));
      },
      hintStyle: AppTextStyles.styleWeight500(
        color: Colors.black54,
        fontSize: context.width * .04,
      ),
      transition: CircularFloatingSearchBarTransition(),
      // actions: const [
      // FloatingSearchBarAction(
      //   showIfOpened: false,
      //   child: IconButton(
      //     splashRadius: size.width * .06,
      //     icon: Stack(
      //       clipBehavior: Clip.none,
      //       children: [
      //         SvgPicture.asset(
      //           SvgPath.filterShop,
      //           color: AppColors.blue,
      //           width: size.width * .045,
      //         ),
      //         BlocBuilder<SearchBloc, SearchState>(
      //           bloc: context.read<SearchBloc>(),
      //           builder: (context, state) {
      //             return state.hasFilter
      //                 ? PositionedDirectional(
      //                     start: -2,
      //                     top: -2,
      //                     child: Container(
      //                       width: 7,
      //                       height: 7,
      //                       decoration: const BoxDecoration(
      //                         color: Colors.red,
      //                         shape: BoxShape.circle,
      //                       ),
      //                     ),
      //                   )
      //                 : const SizedBox();
      //           },
      //         )
      //       ],
      //     ),
      //     onPressed: () {
      //       showModalBottomSheet(
      //         context: context,
      //         backgroundColor: Colors.transparent,
      //         builder: (_) => BottomSheetFilterToSearch(
      //           size: size,
      //           isContent: isContent,
      //           appLocalizations: appLocalizations,
      //           searchBloc: context.read<SearchBloc>(),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      // FloatingSearchBarAction(
      //   showIfClosed: false,
      //   showIfOpened: true,
      //   child: IconButton(
      //     splashRadius: size.width * .06,
      //     icon: SvgPicture.asset(
      //       SvgPath.search,
      //       width: size.width * .045,
      //     ),
      //     onPressed: () {
      //       floatingSearchBarController.close();
      //       context.read<SearchBloc>().add(
      //             StartAllSearchEvent(
      //               allSearch: floatingSearchBarController.query,
      //             ),
      //           );
      //     },
      //   ),
      // ),
      // ],
      builder: (_, __) => const SizedBox.shrink(),
    );
  }
}
