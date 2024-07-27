import 'package:coopah_frontend_dev_task/core/network_exception.dart';

class DataWrapper<T> {
  final T? data;
  final NetworkException? error;

  DataWrapper({this.data, this.error});

  factory DataWrapper.success(T data) {
    return DataWrapper(data: data);
  }

  factory DataWrapper.error(NetworkException error) {
    return DataWrapper(error: error);
  }
}
