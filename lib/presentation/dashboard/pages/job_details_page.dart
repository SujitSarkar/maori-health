import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';

import 'package:maori_health/presentation/dashboard/widgets/job_carousel.dart';
import 'package:maori_health/presentation/dashboard/widgets/job_details_info_card.dart';
import 'package:maori_health/presentation/shared/widgets/solid_button.dart';

enum JobStatus { pending, accepted, started }

class JobDetailsPage extends StatefulWidget {
  final JobCarouselItem job;
  const JobDetailsPage({super.key, required this.job});

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
                date: '01-01-2025',
                jobType: 'Personal Care',
                clientName: 'Jane Doe',
                clientAddress: '64 Hinerangi, St, Turangi',
                duration: '2',
                startTime: '9:00 AM',
                endTime: '11:00 AM',
                status: widget.job.status,
                jobStartedTime: widget.job.status == JobStatus.started ? 'Start at 9.00 am' : null,
              ),
              const SizedBox(height: 24),
              _buildActions(),
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
    return switch (widget.job.status) {
      JobStatus.pending => _buildPendingActions(),
      JobStatus.accepted => _buildAcceptedActions(),
      JobStatus.started => _buildStartedActions(),
    };
  }

  Widget _buildPendingActions() {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        SolidButton(onPressed: () => widget.job.onTap?.call(), child: const Text(StringConstants.acceptJob)),
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
        SolidButton(onPressed: () => widget.job.onTap?.call(), child: const Text(StringConstants.startJob)),
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
