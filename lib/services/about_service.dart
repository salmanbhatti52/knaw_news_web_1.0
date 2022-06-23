
import 'package:knaw_news/model/about_model.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:retrofit/retrofit.dart';
import '_config.dart';
part   'about_service.g.dart';


@RestApi(baseUrl: AppConstants.apiUrl)
abstract class AboutServices {
  factory AboutServices() => _AboutServices(defaultDio);

@GET('get_about_desc')
Future<AboutModel> get();

}

