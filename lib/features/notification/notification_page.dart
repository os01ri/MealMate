import 'dart:developer';

import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/extensions/widget_extensions.dart';
import '../../core/helper/app_config.dart';
import '../../core/ui/theme/colors.dart';
import '../../core/ui/theme/text_styles.dart';
import '../../core/ui/widgets/main_button.dart';
import '../../services/shared_prefrences_service.dart';
import '../recipe/presentation/widgets/app_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with TickerProviderStateMixin {
  late TabController tabController;
  late ValueNotifier<int> index;

  @override
  void initState() {
    tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    index = ValueNotifier(tabController.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: index,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return Row(
                children: [
                  MainButton(
                    fontSize: 14,
                    text: 'All',
                    elevation: 0,
                    textColor: switch (tabController.index) {
                      0 => AppColors.scaffoldBackgroundColor,
                      _ => Colors.black
                    },
                    color: switch (tabController.index) {
                      0 => AppColors.mainColor,
                      _ => AppColors.scaffoldBackgroundColor
                    },
                    onPressed: () {
                      tabController.animateTo(0);
                      index.value = 0;
                    },
                  ),
                  MainButton(
                    fontSize: 14,
                    text: 'Read',
                    elevation: 0,
                    textColor: switch (tabController.index) {
                      1 => AppColors.scaffoldBackgroundColor,
                      _ => Colors.black
                    },
                    color: switch (tabController.index) {
                      1 => AppColors.mainColor,
                      _ => AppColors.scaffoldBackgroundColor
                    },
                    onPressed: () {
                      tabController.animateTo(1);
                      index.value = 1;
                    },
                  ),
                  MainButton(
                    fontSize: 14,
                    elevation: 0,
                    text: 'UnRead',
                    textColor: switch (tabController.index) {
                      2 => AppColors.scaffoldBackgroundColor,
                      _ => Colors.black
                    },
                    color: switch (tabController.index) {
                      2 => AppColors.mainColor,
                      _ => AppColors.scaffoldBackgroundColor
                    },
                    onPressed: () {
                      tabController.animateTo(2);
                      index.value = 2;
                    },
                  ),
                ],
              ).paddingAll(20);
            },
          ),
          SizedBox(
            height: context.height * .5,
            child: TabBarView(
              controller: tabController,
              children: const [
                NotificationList(
                  count: 1,
                ),
                NotificationList(
                  count: 2,
                ),
                NotificationList(
                  count: 3,
                ),
              ],
            ).padding(AppConfig.pagePadding),
          ),
        ],
      ),
    );
  }
}

//TODO When Api Is Ready use notification Model
class NotificationList extends StatelessWidget {
  const NotificationList({super.key, this.count, this.notifications});
  final int? count;
  final List<Map<String, String>>? notifications;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListTile(
          onTap: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.all(8),
          title: Text(
            notifications?[index]['title'] ?? 'وصفة جديدة من الشيف بوراك!',
            style: AppTextStyles.styleWeight600(fontSize: 16),
          ),
          subtitle: Text(notifications?[index]['description'] ??
                  'قام الشيف بورك بنشر وصفته الجديدة "معكرونة بالباشاميل" على طريقته الخاصة، قم بتحضيرها اﻵن!')
              .paddingAll(10),
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
