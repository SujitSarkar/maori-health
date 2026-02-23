import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/presentation/dashboard/pages/job_details_page.dart';

abstract class DashboardUtils {
  static String formatJobType(String? type) => switch (type) {
        'pc' => 'Personal Care',
        'hm' => 'Home Management',
        _ => type?.capitalize() ?? 'Job',
      };

  static JobStatus mapJobStatus(String? status) => switch (status) {
        'accepted' => JobStatus.accepted,
        'started' || 'in_progress' => JobStatus.started,
        _ => JobStatus.pending,
      };
}
