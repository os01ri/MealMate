import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/toaster.dart';
import '../../../../core/ui/widgets/loading_widget.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../../data/models/index_grocery_response_model.dart';
import '../cubit/grocery_cubit.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  State<GroceryPage> createState() => GroceryPageState();
}

class GroceryPageState extends State<GroceryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: RecipeAppBar(
        context: context,
        centerText: true,
        actions: const [],
        title: "Your Grocery",
      ),
      body: BlocProvider(
        create: (context) => GroceryCubit()..getGroceryItems(),
        child: BlocConsumer<GroceryCubit, GroceryState>(
          listener: (context, state) {
            if (state.deleteGroceryItemStatus == DeleteGroceryItemStatus.loading) {
              Toaster.showLoading();
            } else if (state.deleteGroceryItemStatus == DeleteGroceryItemStatus.init ||
                state.deleteGroceryItemStatus == DeleteGroceryItemStatus.success) {
              Toaster.closeLoading();
            } else if (state.deleteGroceryItemStatus == DeleteGroceryItemStatus.failed) {
              Toaster.closeLoading();
              Toaster.showToast('try again');
            }
          },
          builder: (context, state) {
            return state.status == GroceryStatus.success
                ? Container(
                    color: AppColors.mainColor.withOpacity(.1),
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GroceryItemWidget(
                            item: state.cartItems[index],
                            onAdd: () {},
                            onRemove: () {},
                            onDelete: () {
                              context.read<GroceryCubit>().deleteGroceryItem(state.cartItems[index].id!);
                            },
                          ),
                        );
                      },
                    ),
                  )
                : state.status == GroceryStatus.failed
                    ? const SizedBox.shrink()
                    : const LoadingWidget();
          },
        ),
      ),
    );
  }
}

class GroceryItemWidget extends StatefulWidget {
  const GroceryItemWidget({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  final IndexGroceryDataModel item;
  final VoidCallback onAdd, onDelete, onRemove;

  @override
  State<GroceryItemWidget> createState() => _GroceryItemWidgetState();
}

class _GroceryItemWidgetState extends State<GroceryItemWidget> {
  @override
  void initState() {
    log('${widget.item..ingredient!.name}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Row(
        children: [
          CachedNetworkImage(
            hash: widget.item.ingredient!.hash ?? '',
            url: widget.item.ingredient!.url ?? '',
            fit: BoxFit.fitHeight,
            width: context.width * .2,
            height: context.width * .2,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item.ingredient!.name ?? "Ingredients"),
              Text('${(widget.item.quantity! * widget.item.ingredient!.priceBy!)} ${widget.item.unit!.code}'),
              // Text(
              // "total ${widget.item.ingredient!.priceBy! * widget.item.ingredient!.quantity} ${widget.item.ingredient!.unit!.code}"),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.mainColor,
              size: 30,
            ),
            onPressed: () => widget.onDelete(),
          ),
        ],
      ),
    );
  }
}
