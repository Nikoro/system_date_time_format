//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <system_date_time_format/system_date_time_format_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) system_date_time_format_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SystemDateTimeFormatPlugin");
  system_date_time_format_plugin_register_with_registrar(system_date_time_format_registrar);
}
