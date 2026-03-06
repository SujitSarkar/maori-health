import 'package:dio/dio.dart';

import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/network/dio_client.dart';
import 'package:maori_health/core/utils/data_parse_util.dart';

import 'package:maori_health/data/dashboard/models/job_model.dart';
import 'package:maori_health/data/schedule/models/paginated_schedule_response.dart';

abstract class ScheduleRemoteDataSource {
  Future<PaginatedScheduleResponse> getSchedules({
    required int page,
    String? clientUserId,
    String? startDate,
    String? endDate,
  });
  Future<JobModel> getScheduleById({required int scheduleId});
  Future<JobModel> acceptSchedule({required int scheduleId});
  Future<JobModel> startSchedule({required int scheduleId});
  Future<JobModel> finishSchedule({required int scheduleId});
  Future<JobModel> cancelSchedule({required int scheduleId});
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final DioClient _client;

  ScheduleRemoteDataSourceImpl({required DioClient client}) : _client = client;

  @override
  Future<PaginatedScheduleResponse> getSchedules({
    required int page,
    String? clientUserId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _client.get(ApiEndpoints.schedules);
      return PaginatedScheduleResponse(
        schedules: (response.data['data']?['data'] as List).map((e) => JobModel.fromJson(e)).toList(),
        currentPage: DataParseUtil.parseInt(response.data['data']?['current_page'], defaultValue: 1),
        lastPage: DataParseUtil.parseInt(response.data['data']?['last_page'], defaultValue: 1),
      );
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to fetch schedules',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<JobModel> getScheduleById({required int scheduleId}) async {
    try {
      final response = await _client.get(ApiEndpoints.scheduleById(scheduleId));
      return JobModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to fetch schedule details',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<JobModel> acceptSchedule({required int scheduleId}) async {
    try {
      final response = await _client.post(ApiEndpoints.acceptSchedule(scheduleId));
      return JobModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to accept schedule',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<JobModel> startSchedule({required int scheduleId}) async {
    try {
      final response = await _client.post(ApiEndpoints.startSchedule(scheduleId));
      return JobModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to start schedule',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<JobModel> finishSchedule({required int scheduleId}) async {
    try {
      final response = await _client.post(ApiEndpoints.finishSchedule(scheduleId));
      return JobModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to finish schedule',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<JobModel> cancelSchedule({required int scheduleId}) async {
    try {
      final response = await _client.post(ApiEndpoints.cancelSchedule(scheduleId));
      return JobModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to cancel schedule',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: e.toString());
    }
  }
}
