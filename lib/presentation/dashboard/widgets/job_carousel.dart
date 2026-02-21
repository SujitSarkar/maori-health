import 'package:flutter/material.dart';

import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/presentation/dashboard/pages/job_details_page.dart';
import 'package:maori_health/presentation/dashboard/widgets/job_card.dart';

class JobCarouselItem {
  final String date;
  final String title;
  final String address;
  final String? startedAt;
  final String startTime;
  final String endTime;
  final String totalHours;
  final JobStatus status;
  final VoidCallback? onTap;

  const JobCarouselItem({
    required this.date,
    required this.title,
    required this.address,
    this.startedAt,
    required this.startTime,
    required this.endTime,
    required this.totalHours,
    required this.status,
    this.onTap,
  });
}

class JobCarousel extends StatefulWidget {
  final List<JobCarouselItem> items;
  final double height;

  const JobCarousel({super.key, required this.items, this.height = 160});

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
    final next = (_currentPage + delta).clamp(0, widget.items.length - 1);
    _pageController.animateToPage(next, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    if (items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, i) {
              final job = items[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: JobCard(
                  date: job.date,
                  title: job.title,
                  address: job.address,
                  startedAt: job.startedAt,
                  startTime: job.startTime,
                  endTime: job.endTime,
                  totalHours: job.totalHours,
                  status: job.status,
                  onTap: job.onTap,
                ),
              );
            },
          ),
          if (items.length > 1) ...[
            _CarouselArrow(
              icon: Icons.chevron_left,
              alignment: Alignment.centerLeft,
              onTap: _currentPage > 0 ? () => _goToPage(-1) : null,
            ),
            _CarouselArrow(
              icon: Icons.chevron_right,
              alignment: Alignment.centerRight,
              onTap: _currentPage < items.length - 1 ? () => _goToPage(1) : null,
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
          padding: const EdgeInsets.all(2),
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
