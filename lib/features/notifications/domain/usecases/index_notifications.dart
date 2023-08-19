import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/notifications_response_model.dart';
import '../repositories/notifications_repository.dart';

class IndexNotificationsUseCase implements UseCase<NotificationsResponseModel, NoParams> {
  final NotificationsRepository repository;

  IndexNotificationsUseCase({required this.repository});

  @override
  Future<Either<Failure, NotificationsResponseModel>> call(NoParams params) async {
    return repository.indexNotifications();
  }
}
