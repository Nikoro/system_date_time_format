#ifndef FLUTTER_PLUGIN_SYSTEM_DATE_TIME_FORMAT_PLUGIN_H_
#define FLUTTER_PLUGIN_SYSTEM_DATE_TIME_FORMAT_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _SystemDateTimeFormatPlugin SystemDateTimeFormatPlugin;
typedef struct {
  GObjectClass parent_class;
} SystemDateTimeFormatPluginClass;

FLUTTER_PLUGIN_EXPORT GType system_date_time_format_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void system_date_time_format_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_SYSTEM_DATE_TIME_FORMAT_PLUGIN_H_
