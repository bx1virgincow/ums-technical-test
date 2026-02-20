import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final T? data;
  final String message;
  final DateTime timeStamp;

  ApiResponse({
    required this.success,
    this.data,
    required this.message,
    DateTime? timeStamp,
  }) : timeStamp = timeStamp ?? DateTime.now();

  factory ApiResponse.success(T data, {String? message}) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message ?? 'Request successful',
      timeStamp: DateTime.now(),
    );
  }

  factory ApiResponse.error(String message, {T? data}) {
    return ApiResponse<T>(
      success: false,
      data: data,
      message: message,
      timeStamp: DateTime.now(),
    );
  }

  //fromJson
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    try {
      return ApiResponse<T>(
        message: json['message'] ?? '',
        data: json['data'] != null ? fromJsonT(json['data']) : null,
        success: json['success'] ?? false,
        timeStamp: json['timeStamp'] != null
            ? DateTime.parse(json['timeStamp'])
            : DateTime.now(),
      );
    } catch (e) {
      return ApiResponse.error('Failed to parse response: $e');
    }
  }

  //toJson
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': data != null ? toJsonT(data as T) : null,
      'timeStamp': timeStamp,
    };
  }

  @override
  List<Object?> get props => [success, data, message, timeStamp];
}
