import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/date_converter.dart';
import 'package:maori_health/core/utils/extensions.dart';

import 'package:maori_health/domain/dashboard/entities/job.dart';
import 'package:maori_health/core/utils/dashboard_utils.dart';
import 'package:maori_health/presentation/dashboard/widgets/job_details_info_card.dart';
import 'package:maori_health/presentation/shared/widgets/solid_button.dart';

enum JobStatus { pending, accepted, started }

class JobDetailsPage extends StatefulWidget {
  final Job? job;
  final int? jobScheduleId;
  const JobDetailsPage({super.key, this.job, this.jobScheduleId});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              JobDetailsInfoCard(
                date: DateConverter.formatIso(widget.job?.scheduleStartTime, pattern: 'dd-MM-yyyy'),
                jobType: DashboardUtils.formatJobType(widget.job?.jobType),
                clientName: '-',
                clientAddress: 'Job #${widget.job?.id ?? '-'}',
                duration: widget.job?.scheduleTotalTime.toStringAsFixed(2) ?? '-',
                startTime: DateConverter.formatIso(widget.job?.scheduleStartTime, pattern: 'h:mm a'),
                endTime: DateConverter.formatIso(widget.job?.scheduleEndTime, pattern: 'h:mm a'),
                status: DashboardUtils.mapJobStatus(widget.job?.status),
                jobStartedTime: widget.job?.workStartTime != null
                    ? DateConverter.formatIso(widget.job!.workStartTime, pattern: 'h:mm a')
                    : null,
              ),
              const SizedBox(height: 24),
              if (widget.job != null) _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(onTap: () => Navigator.maybePop(context), child: const Icon(Icons.arrow_back)),
        const SizedBox(width: 8),
        Text(
          StringConstants.jobDetails,
          style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return switch (DashboardUtils.mapJobStatus(widget.job!.status)) {
      JobStatus.pending => _buildPendingActions(),
      JobStatus.accepted => _buildAcceptedActions(),
      JobStatus.started => _buildStartedActions(),
    };
  }

  Widget _buildPendingActions() {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        SolidButton(onPressed: () {}, child: const Text(StringConstants.acceptJob)),
        const SizedBox(height: 24),
        SolidButton(
          onPressed: () => Navigator.maybePop(context),
          backgroundColor: AppColors.primary.withAlpha(250),
          child: const Text(StringConstants.backToDashboard),
        ),
      ],
    );
  }

  Widget _buildAcceptedActions() {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        SolidButton(onPressed: () {}, child: const Text(StringConstants.startJob)),
        const SizedBox(height: 12),
        SolidButton(
          onPressed: () {
            // TODO: Dispatch cancel job
          },
          backgroundColor: AppColors.amber,
          foregroundColor: Colors.black87,
          child: const Text(StringConstants.cancelJob),
        ),
        const SizedBox(height: 12),
        SolidButton(
          onPressed: () => Navigator.maybePop(context),
          backgroundColor: AppColors.primary.withAlpha(150),
          child: const Text(StringConstants.backToDashboard),
        ),
      ],
    );
  }

  Widget _buildStartedActions() {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        SolidButton(
          onPressed: () {
            // TODO: Dispatch finish job
          },
          child: const Text(StringConstants.finishJob),
        ),
        const SizedBox(height: 12),
        SolidButton(
          onPressed: () {
            // TODO: Dispatch cancel job
          },
          backgroundColor: AppColors.amber,
          foregroundColor: Colors.black87,
          child: const Text(StringConstants.cancelJob),
        ),
        const SizedBox(height: 12),
        SolidButton(
          onPressed: () => Navigator.maybePop(context),
          backgroundColor: AppColors.primary,
          child: const Text(StringConstants.backToDashboard),
        ),
      ],
    );
  }
}
