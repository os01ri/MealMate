import 'package:bloc/bloc.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/notifications_response_model.dart';
import '../../data/repositories/notifications_repository_impl.dart';
import '../../domain/usecases/index_notifications.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final _index = IndexNotificationsUseCase(repository: NotificationsRepositoryImpl());

  NotificationCubit() : super(const NotificationState());

  indexNotifications() async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _index(NoParams());

    result.fold(
      (l) => emit(state.copyWith(status: CubitStatus.failure)),
      (r) => emit(state.copyWith(status: CubitStatus.success, notifications: r.data)),
    );
  }
}
