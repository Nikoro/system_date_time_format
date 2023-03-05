#include "include/system_date_time_format/system_date_time_format_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "system_date_time_format_plugin.h"

void SystemDateTimeFormatPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  system_date_time_format::SystemDateTimeFormatPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
