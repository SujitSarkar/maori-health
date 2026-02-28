import 'package:flutter/material.dart';

import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/domain/dashboard/entities/job.dart';
import 'package:maori_health/presentation/dashboard/widgets/job_card.dart';

class JobCarousel extends StatefulWidget {
  final List<Job> jobs;
  final void Function(Job job)? onJobTap;
  final double height;

  const JobCarousel({super.key, required this.jobs, this.onJobTap, this.height = 160});

  @override
  State<JobCarousel> createState() => _JobCarouselState();
}

class _JobCarouselState extends State<JobCarousel> {
  final _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int delta) {
    final next = (_currentPage + delta).clamp(0, widget.jobs.length - 1);
    _pageController.animateToPage(next, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final jobs = widget.jobs;
    if (jobs.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: jobs.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, i) {
              final job = jobs[i];
              return Padding(
                padding: const .symmetric(horizontal: 4),
                child: JobCard(job: job, onTap: widget.onJobTap != null ? () => widget.onJobTap!(job) : null),
              );
            },
          ),
          if (jobs.length > 1) ...[
            _CarouselArrow(
              icon: Icons.chevron_left,
              alignment: Alignment.centerLeft,
              onTap: _currentPage > 0 ? () => _goToPage(-1) : null,
            ),
            _CarouselArrow(
              icon: Icons.chevron_right,
              alignment: Alignment.centerRight,
              onTap: _currentPage < jobs.length - 1 ? () => _goToPage(1) : null,
            ),
          ],
        ],
      ),
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  final IconData icon;
  final AlignmentGeometry alignment;
  final VoidCallback? onTap;

  const _CarouselArrow({required this.icon, required this.alignment, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const .all(2),
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withAlpha(220),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 4)],
          ),
          child: Icon(
            icon,
            size: 22,
            color: onTap != null ? context.colorScheme.onSurface : context.colorScheme.onSurface.withAlpha(80),
          ),
        ),
      ),
    );
  }
}
