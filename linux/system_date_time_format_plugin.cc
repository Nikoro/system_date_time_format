#include "include/system_date_time_format/system_date_time_format_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <cstring>
#include <langinfo.h>
#include <ctype.h>

#define SYSTEM_DATE_TIME_FORMAT_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), system_date_time_format_plugin_get_type(), \
                              SystemDateTimeFormatPlugin))

struct _SystemDateTimeFormatPlugin {
	GObject parent_instance;
};

G_DEFINE_TYPE(SystemDateTimeFormatPlugin, system_date_time_format_plugin, g_object_get_type())

char* ltrim(char* s) {
	while (isspace(*s)) s++;
	return s;
}

char* rtrim(char* s) {
	char* back = s + strlen(s);
	while (isspace(*--back));
	*(back + 1) = '\0';
	return s;
}

char* trim(char* s) {
	return rtrim(ltrim(s));
}

char* format_date(const char* date) {
	const int BUFFER_LENGTH = strlen(date) * 3 + 1;
	char* formatted_date = (char*)malloc(BUFFER_LENGTH);
	memset(formatted_date, 0, BUFFER_LENGTH);

	int i = 0;
	while (date[i] != '\0') {
		if (date[i] == '%') {
			char specifier = date[i + 1];
			switch (specifier) {
			case 'a': strcat(formatted_date, "ddd"); break;
			case 'A': strcat(formatted_date, "dddd"); break;
			case 'b':
			case 'h': strcat(formatted_date, "MMM"); break;
			case 'B': strcat(formatted_date, "MMMM"); break;
			case 'c': strcat(formatted_date, ""); break;
			case 'C': strcat(formatted_date, "yy"); break;
			case 'd': strcat(formatted_date, "dd"); break;
			case 'D': strcat(formatted_date, "MM/dd/yy"); break;
			case 'e': strcat(formatted_date, "d"); break;
			case 'F': strcat(formatted_date, "yyyy-MM-dd"); break;
			case 'g': strcat(formatted_date, "yy"); break;
			case 'G': strcat(formatted_date, "yyyy"); break;
			case 'H':
			case 'I':
			case 'j': strcat(formatted_date, "DDD"); break;
			case 'm': strcat(formatted_date, "MM"); break;
			case 'M':
			case 'n':
			case 'p':
			case 'r':
			case 'R':
			case 'S':
			case 't':
			case 'T':
			case 'u':
			case 'U':
			case 'V':
			case 'w':
			case 'W':
			case 'x':
			case 'X': strcat(formatted_date, ""); break;
			case 'y': strcat(formatted_date, "yy"); break;
			case 'Y': strcat(formatted_date, "yyyy"); break;
			case 'z':
			case 'Z':
			case '%': strcat(formatted_date, ""); break;
			default: formatted_date[strlen(formatted_date)] = date[i + 1]; break;
			}
			i += 2;
		}
		else {
			formatted_date[strlen(formatted_date)] = date[i];
			i++;
		}
	}
	formatted_date[strlen(formatted_date)] = '\0';
	return trim(formatted_date);
}

char* format_time(const char* time) {
	const int BUFFER_LENGTH = strlen(time) * 3 + 1;
	char* formatted_time = (char*)malloc(BUFFER_LENGTH);
	memset(formatted_time, 0, BUFFER_LENGTH);

	int i = 0;
	while (time[i] != '\0') {
		if (time[i] == '%') {
			char specifier = time[i + 1];
			switch (specifier) {
			case 'a':
			case 'A':
			case 'b':
			case 'h':
			case 'B':
			case 'c':
			case 'C':
			case 'd':
			case 'D':
			case 'e':
			case 'F':
			case 'g':
			case 'G': strcat(formatted_time, ""); break;
			case 'H': strcat(formatted_time, "HH"); break;
			case 'I': strcat(formatted_time, "hh"); break;
			case 'j':
			case 'm': strcat(formatted_time, ""); break;
			case 'M': strcat(formatted_time, "mm"); break;
			case 'n': strcat(formatted_time, "\n"); break;
			case 'p': strcat(formatted_time, "tt"); break;
			case 'r': strcat(formatted_time, "hh:mm:ss tt"); break;
			case 'R': strcat(formatted_time, "HH:mm"); break;
			case 'S': strcat(formatted_time, "ss"); break;
			case 't': strcat(formatted_time, "\t"); break;
			case 'T': strcat(formatted_time, "HH:mm:ss"); break;
			case 'u':
			case 'U':
			case 'V':
			case 'w':
			case 'W':
			case 'x':
			case 'X':
			case 'y':
			case 'Y':
			case 'z':
			case 'Z':
			case '%': strcat(formatted_time, ""); break;
			default: formatted_time[strlen(formatted_time)] = time[i + 1]; break;
			}
			i += 2;
		}
		else {
			formatted_time[strlen(formatted_time)] = time[i];
			i++;
		}
	}
	formatted_time[strlen(formatted_time)] = '\0';
	return trim(formatted_time);
}

// Called when a method call is received from Flutter.
static void system_date_time_format_plugin_handle_method_call(
	SystemDateTimeFormatPlugin* self,
	FlMethodCall* method_call) {
	g_autoptr(FlMethodResponse) response = nullptr;

	const gchar* method = fl_method_call_get_name(method_call);

	if (strcmp(method, "getDateFormat") == 0) {
		char* date = nl_langinfo(D_FMT);
		char* formatted_date = format_date(date);
		response = FL_METHOD_RESPONSE(fl_method_success_response_new(fl_value_new_string(formatted_date)));
		free(formatted_date);
	}
	else if (strcmp(method, "getMediumDateFormat") == 0) {
		response = FL_METHOD_RESPONSE(fl_method_success_response_new(fl_value_new_string("")));
	}
	else if (strcmp(method, "getLongDateFormat") == 0) {
		char* date = nl_langinfo(D_T_FMT);
		char* formatted_date = format_date(date);
		response = FL_METHOD_RESPONSE(fl_method_success_response_new(fl_value_new_string(formatted_date)));
		free(formatted_date);
	}
	else if (strcmp(method, "getTimeFormat") == 0) {
		char* time = nl_langinfo(T_FMT);
		char* formatted_time = format_time(time);
		response = FL_METHOD_RESPONSE(fl_method_success_response_new(fl_value_new_string(formatted_time)));
		free(formatted_time);
	}
	else {
		response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
	}

	fl_method_call_respond(method_call, response, nullptr);
}

static void system_date_time_format_plugin_dispose(GObject* object) {
	G_OBJECT_CLASS(system_date_time_format_plugin_parent_class)->dispose(object);
}

static void system_date_time_format_plugin_class_init(SystemDateTimeFormatPluginClass* klass) {
	G_OBJECT_CLASS(klass)->dispose = system_date_time_format_plugin_dispose;
}

static void system_date_time_format_plugin_init(SystemDateTimeFormatPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
	gpointer user_data) {
	SystemDateTimeFormatPlugin* plugin = SYSTEM_DATE_TIME_FORMAT_PLUGIN(user_data);
	system_date_time_format_plugin_handle_method_call(plugin, method_call);
}

void system_date_time_format_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
	SystemDateTimeFormatPlugin* plugin = SYSTEM_DATE_TIME_FORMAT_PLUGIN(
		g_object_new(system_date_time_format_plugin_get_type(), nullptr));

	g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
	g_autoptr(FlMethodChannel) channel =
		fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
			"system_date_time_format",
			FL_METHOD_CODEC(codec));
	fl_method_channel_set_method_call_handler(channel, method_call_cb,
		g_object_ref(plugin),
		g_object_unref);

	g_object_unref(plugin);
}



