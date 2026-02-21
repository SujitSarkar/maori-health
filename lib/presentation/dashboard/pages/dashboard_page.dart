import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/assets.dart';
import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/utils/extensions.dart';

import 'package:maori_health/presentation/auth/bloc/bloc.dart';
import 'package:maori_health/presentation/dashboard/widgets/job_carousel.dart';
import 'package:maori_health/presentation/dashboard/widgets/stat_card.dart';
import 'package:maori_health/presentation/dashboard/widgets/job_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildSectionTitle(context, StringConstants.availableJobs),
              const SizedBox(height: 12),
              JobCarousel(items: _dummyJobs),
              const SizedBox(height: 24),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.3,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _dummyStats.length,
                itemBuilder: (context, index) =>
                    StatCard(value: _dummyStats[index].value, label: _dummyStats[index].label),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(context, StringConstants.currentScheduled),
              const SizedBox(height: 12),
              ..._dummyScheduled.map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: JobCard(
                    date: job.date,
                    title: job.title,
                    address: job.address,
                    startedAt: job.startedAt,
                    startTime: job.startTime,
                    endTime: job.endTime,
                    totalHours: job.totalHours,
                  ),
                ),
              ),
              _buildSectionTitle(context, StringConstants.nextSchedule),
              const SizedBox(height: 12),
              ..._dummyScheduled.map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: JobCard(
                    date: job.date,
                    title: job.title,
                    address: job.address,
                    startedAt: job.startedAt,
                    startTime: job.startTime,
                    endTime: job.endTime,
                    totalHours: job.totalHours,
                  ),
                ),
              ),
              _buildSectionTitle(context, StringConstants.todaySchedule),
              const SizedBox(height: 12),
              ..._dummyScheduled.map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: JobCard(
                    date: job.date,
                    title: job.title,
                    address: job.address,
                    startedAt: job.startedAt,
                    startTime: job.startTime,
                    endTime: job.endTime,
                    totalHours: job.totalHours,
                  ),
                ),
              ),
              _buildSectionTitle(context, StringConstants.upcomingSchedule),
              const SizedBox(height: 12),
              ..._dummyScheduled.map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: JobCard(
                    date: job.date,
                    title: job.title,
                    address: job.address,
                    startedAt: job.startedAt,
                    startTime: job.startTime,
                    endTime: job.endTime,
                    totalHours: job.totalHours,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final textTheme = context.textTheme;

    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (prev, curr) => prev.user != curr.user,
      builder: (context, state) {
        final name = state.user?.firstName ?? '';
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, $name', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(
                    StringConstants.welcomeTo,
                    style: textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Image.asset(Assets.assetsImagesBannerLogo, height: 48),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold));
  }
}

// ── Placeholder data (will be replaced with BLoC-driven data) ──
final _dummyJobs = [
  const JobCarouselItem(
    date: 'Thursday, January 2, 2024',
    title: 'Personal Care - John Doe is a long title that needs to be truncated',
    address: '64 Hinerangi St, Turangi',
    startedAt: '9:10 AM',
    startTime: '9:00AM',
    endTime: '11:00AM',
    totalHours: '2.00',
  ),
  const JobCarouselItem(
    date: 'Friday, January 3, 2024',
    title: 'Personal Care - Rodrick',
    address: '12 Lakeside Ave, Taupo',
    startedAt: '10:00 AM',
    startTime: '10:00AM',
    endTime: '12:00PM',
    totalHours: '2.00',
  ),
  const JobCarouselItem(
    date: 'Friday, January 4, 2024',
    title: 'Personal Care - Rodrick',
    address: '12 Lakeside Ave, Taupo',
    startedAt: '10:00 AM',
    startTime: '10:00AM',
    endTime: '12:00PM',
    totalHours: '2.00',
  ),
];

const _dummyStats = [
  StatsGridItem(value: '22', label: StringConstants.totalJob),
  StatsGridItem(value: '07', label: StringConstants.activeJob),
  StatsGridItem(value: '02', label: StringConstants.cancelJob),
  StatsGridItem(value: '11', label: StringConstants.completeJob),
  StatsGridItem(value: '13', label: StringConstants.totalClient),
  StatsGridItem(value: '13H', label: StringConstants.missedTimesheets),
];

const _dummyScheduled = [
  JobCarouselItem(
    date: 'Thursday, January 2, 2024',
    title: 'Personal Care - John Doe',
    address: '64 Hinerangi St, Turangi',
    startTime: '9:00AM',
    endTime: '11:00AM',
    totalHours: '2.00',
  ),
  JobCarouselItem(
    date: 'Thursday, January 3, 2024',
    title: 'Personal Care - John Doe',
    address: '64 Hinerangi St, Turangi',
    startTime: '9:00AM',
    endTime: '11:00AM',
    totalHours: '2.00',
  ),
];

class StatsGridItem {
  final String value;
  final String label;

  const StatsGridItem({required this.value, required this.label});
}
