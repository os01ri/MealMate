part of 'notification_cubit.dart';

class NotificationState {
  final CubitStatus status;
  final List<NotificationModel> notifications;

  const NotificationState({
    this.status = CubitStatus.initial,
    this.notifications = const [],
  });

  NotificationState copyWith({
    CubitStatus? status,
    List<NotificationModel>? notifications,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
    );
  }
}
