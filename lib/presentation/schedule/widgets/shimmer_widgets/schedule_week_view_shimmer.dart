import 'package:flutter/material.dart';

import 'package:maori_health/presentation/shared/widgets/app_shimmer.dart';

class ScheduleWeekViewShimmer extends StatelessWidget {
  const ScheduleWeekViewShimmer({super.key});

  static const int _startHour = 7;
  static const int _endHour = 19;
  static const double _hourHeight = 64;
  static const double _timeColumnWidth = 46;

  @override
  Widget build(BuildContext context) {
    final totalGridHeight = (_endHour - _startHour) * _hourHeight;
    final dividerColor = Theme.of(context).dividerColor;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: _timeColumnWidth + 2),
              Expanded(
                child: Row(
                  children: List.generate(
                    7,
                    (_) => const Expanded(
                      child: Column(
                        children: [
                          AppShimmer.text(width: 18, height: 18, borderRadius: 6),
                          SizedBox(height: 4),
                          AppShimmer.text(width: 28, height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: totalGridHeight + 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: _timeColumnWidth, child: _TimeScaleShimmer()),
                const SizedBox(width: 2),
                Expanded(
                  child: Row(
                    children: List.generate(
                      7,
                      (dayIndex) => Expanded(
                        child: Container(
                          height: totalGridHeight + 1,
                          decoration: BoxDecoration(
                            border: Border(left: BorderSide(color: dividerColor)),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: List.generate(
                                  _endHour - _startHour,
                                  (_) => Container(
                                    height: _hourHeight,
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: dividerColor)),
                                    ),
                                  ),
                                ),
                              ),
                              if (dayIndex == 0) ...const [
                                Positioned(
                                  top: 8,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 78, borderRadius: 10),
                                ),
                                Positioned(
                                  top: 188,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 90, borderRadius: 10),
                                ),
                                Positioned(
                                  top: 318,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 155, borderRadius: 10),
                                ),
                              ],
                              if (dayIndex == 1) ...const [
                                Positioned(
                                  top: 72,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 160, borderRadius: 10),
                                ),
                                Positioned(
                                  top: 302,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 125, borderRadius: 10),
                                ),
                              ],
                              if (dayIndex == 2)
                                const Positioned(
                                  top: 72,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 90, borderRadius: 10),
                                ),
                              if (dayIndex == 3)
                                const Positioned(
                                  top: 140,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 120, borderRadius: 10),
                                ),
                              if (dayIndex == 6) ...const [
                                Positioned(
                                  top: 8,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 78, borderRadius: 10),
                                ),
                                Positioned(
                                  top: 188,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 90, borderRadius: 10),
                                ),
                                Positioned(
                                  top: 318,
                                  left: 4,
                                  right: 4,
                                  child: AppShimmer.card(height: 155, borderRadius: 10),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeScaleShimmer extends StatelessWidget {
  const _TimeScaleShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        7,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index == 6 ? 0 : 96),
          child: const AppShimmer.text(width: 28, height: 12),
        ),
      ),
    );
  }
}
