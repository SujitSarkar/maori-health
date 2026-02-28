import 'package:dio/dio.dart';

import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/network/dio_client.dart';

import 'package:maori_health/data/timesheet/models/timesheet_response_model.dart';

abstract class TimeSheetRemoteDataSource {
  Future<TimesheetResponseModel> getTimeSheets({int? clientUserId, String? startDate, String? endDate, int page = 1});
}

class TimeSheetRemoteDataSourceImpl implements TimeSheetRemoteDataSource {
  final DioClient _client;

  TimeSheetRemoteDataSourceImpl({required DioClient client}) : _client = client;

  @override
  Future<TimesheetResponseModel> getTimeSheets({
    int? clientUserId,
    String? startDate,
    String? endDate,
    int page = 1,
  }) async {
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
      return TimesheetResponseModel.fromJson(data);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to fetch timesheets',
      );
    }
  }
}
