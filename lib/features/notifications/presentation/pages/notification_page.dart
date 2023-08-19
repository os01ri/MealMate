import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/skelton_loading.dart';
import '../../../../services/shared_prefrences_service.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../../data/models/notifications_response_model.dart';
import '../cubit/notification_cubit.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit()..indexNotifications(),
      child: Scaffold(
        appBar: RecipeAppBar(
          context: context,
          title: 'Notifications',
          centerText: false,
          leadingWidget: const SizedBox.shrink(),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list_alt),
              onPressed: () async {
                final token = await SharedPreferencesService.getToken();
                log(token ?? "omar");
              },
            )
          ],
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state.status == CubitStatus.loading) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => SkeltonLoading(
                  height: 100,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(15),
                ).paddingAll(16),
              );
            } else if (state.status == CubitStatus.success) {
              return NotificationList(
                notifications: state.notifications,
              ).padding(AppConfig.pagePadding);
            } else {
              return MainErrorWidget(
                onTap: () => context.read<NotificationCubit>().indexNotifications(),
              ).center();
            }
          },
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key, required this.notifications});

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListTile(
          onTap: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.all(8),
          title: Text(
            notifications[index].title!,
            style: AppTextStyles.styleWeight600(fontSize: 16),
          ),
          subtitle: Text(notifications[index].body!).paddingAll(10),
          iconColor: Colors.green,
          trailing: Icon(Icons.circle, color: Colors.red, size: context.width * .02).paddingHorizontal(10),
          leading: const Icon(
            Icons.notifications_active,
          ).paddingHorizontal(10),
        ),
      ),
    );
  }
}
