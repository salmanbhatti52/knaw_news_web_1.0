// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _AboutServices implements AboutServices {
  _AboutServices(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://app.knawnews.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AboutModel> get() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AboutModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'get_about_desc',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AboutModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
