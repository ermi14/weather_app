import 'package:coopah_frontend_dev_task/core/network_exception.dart';

class DataWrapper<T> {
  final T? data;
  final NetworkException? error;
  final bool loading;

  DataWrapper({this.data, this.error, this.loading = false});

  factory DataWrapper.success(T data) {
    return DataWrapper(data: data, loading: false);
  }

  factory DataWrapper.error(NetworkException error) {
    return DataWrapper(error: error, loading: false);
  }

  factory DataWrapper.loading() {
    return DataWrapper(loading: true);
  }
}