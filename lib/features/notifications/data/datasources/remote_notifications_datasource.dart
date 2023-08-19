import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../models/notifications_response_model.dart';

class NotificationsDataSource {
  const NotificationsDataSource._();

  static Future<NotificationsResponseModel> indexNotifications() async {
    GetApi api = GetApi(
      uri: ApiVariables.indexNotifications(),
      fromJson: notificationsResponseModelFromJson,
    );
    final result = await api();
    return result;
  }
}
