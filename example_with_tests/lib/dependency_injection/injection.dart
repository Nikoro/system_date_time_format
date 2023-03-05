import 'package:get_it/get_it.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<SystemDateTimeFormat>(SystemDateTimeFormat());
}
