import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/di/injection.dart';
import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/domain/notification/entities/app_notification.dart';
import 'package:maori_health/presentation/notification/bloc/bloc.dart';
import 'package:maori_health/presentation/notification/widgets/notification_shimmer.dart';
import 'package:maori_health/presentation/notification/widgets/notification_tile.dart';
import 'package:maori_health/presentation/shared/widgets/error_view_widget.dart';
import 'package:maori_health/presentation/shared/widgets/no_data_found_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationBloc>()..add(const NotificationsFetched()),
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                StringConstants.notification,
                style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, state) {
                    return switch (state.status) {
                      NotificationPageStatus.initial || NotificationPageStatus.loading => const NotificationShimmer(),
                      NotificationPageStatus.error => ErrorViewWidget(
                        message: state.errorMessage ?? StringConstants.somethingWentWrong,
                        onRetry: () => context.read<NotificationBloc>().add(const NotificationsFetched()),
                      ),
                      NotificationPageStatus.loaded =>
                        state.notifications.isEmpty
                            ? const NoDataFoundWidget(message: StringConstants.noData)
                            : _buildNotificationList(context, state.notifications),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context, List<AppNotification> notifications) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        final item = notifications[index];
        return NotificationTile(
          message: item.message,
          jobId: item.jobId,
          dateTime: item.createdAt,
          isRead: item.isRead,
        );
      },
    );
  }
}
