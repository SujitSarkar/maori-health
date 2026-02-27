import 'package:dio/dio.dart';

import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/network/dio_client.dart';
import 'package:maori_health/data/timesheet/models/timesheet_model.dart';

class TimeSheetResponse {
  final List<TimeSheetModel> entries;
  final int currentPage;
  final int lastPage;
  final int totalSchedules;
  final double totalTime;

  const TimeSheetResponse({
    required this.entries,
    required this.currentPage,
    required this.lastPage,
    required this.totalSchedules,
    required this.totalTime,
  });

  bool get hasMore => currentPage < lastPage;
}

abstract class TimeSheetRemoteDataSource {
  Future<TimeSheetResponse> getTimeSheets({int? clientUserId, String? startDate, String? endDate, int page = 1});
}

class TimeSheetRemoteDataSourceImpl implements TimeSheetRemoteDataSource {
  final DioClient _client;

  TimeSheetRemoteDataSourceImpl({required DioClient client}) : _client = client;

  @override
  Future<TimeSheetResponse> getTimeSheets({int? clientUserId, String? startDate, String? endDate, int page = 1}) async {
    try {
      final queryParams = <String, dynamic>{'page': page};
      if (clientUserId != null) queryParams['client_user_id'] = clientUserId;
      if (startDate != null) queryParams['start_date'] = startDate;
      if (endDate != null) queryParams['end_date'] = endDate;

      final response = await _client.get(ApiEndpoints.timeSheets, queryParameters: queryParams);
      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw ApiException(
          statusCode: response.statusCode,
          message: body['message']?.toString() ?? 'Failed to fetch timesheets',
        );
      }

      final data = body['data'] as Map<String, dynamic>;
      final schedules = data['schedules'] as Map<String, dynamic>;
      final list = schedules['data'] as List<dynamic>? ?? [];

      return TimeSheetResponse(
        entries: list.map((e) => TimeSheetModel.fromJson(e as Map<String, dynamic>)).toList(),
        currentPage: schedules['current_page'] as int? ?? 1,
        lastPage: schedules['last_page'] as int? ?? 1,
        totalSchedules: data['total_schedules'] as int? ?? 0,
        totalTime: (data['total_time'] as num?)?.toDouble() ?? 0,
      );
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to fetch timesheets',
      );
    }
  }
}
