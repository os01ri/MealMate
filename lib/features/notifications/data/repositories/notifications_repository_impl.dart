import 'package:dartz/dartz.dart';

import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/remote_notifications_datasource.dart';

class NotificationsRepositoryImpl with HandlingExceptionManager implements NotificationsRepository {
  @override
  indexNotifications() async {
    return wrapHandling(tryCall: () async {
      final result = await NotificationsDataSource.indexNotifications();
      return Right(result);
    });
  }
}
