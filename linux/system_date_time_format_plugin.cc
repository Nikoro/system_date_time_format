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
	if (!formatted_date) return nullptr;
	
	int pos = 0;
	int i = 0;
	while (date[i] != '\0' && pos < BUFFER_LENGTH - 11) {
		if (date[i] == '%' && date[i + 1] != '\0') {
			char specifier = date[i + 1];
			const char* replacement = nullptr;
			switch (specifier) {
			case 'a': replacement = "ddd"; break;
			case 'A': replacement = "dddd"; break;
			case 'b':
			case 'h': replacement = "MMM"; break;
			case 'B': replacement = "MMMM"; break;
			case 'C': replacement = "yy"; break;
			case 'd': replacement = "dd"; break;
			case 'D': replacement = "MM/dd/yy"; break;
			case 'e': replacement = "d"; break;
			case 'F': replacement = "yyyy-MM-dd"; break;
			case 'g': replacement = "yy"; break;
			case 'G': replacement = "yyyy"; break;
			case 'j': replacement = "DDD"; break;
			case 'm': replacement = "MM"; break;
			case 'y': replacement = "yy"; break;
			case 'Y': replacement = "yyyy"; break;
			case '%': 
				formatted_date[pos++] = '%';
				break;
			default: 
				formatted_date[pos++] = date[i + 1];
				break;
			}
			if (replacement) {
				int len = strlen(replacement);
				if (pos + len < BUFFER_LENGTH) {
					memcpy(formatted_date + pos, replacement, len);
					pos += len;
				}
			}
			i += 2;
		}
		else {
			formatted_date[pos++] = date[i];
			i++;
		}
	}
	formatted_date[pos] = '\0';
	return trim(formatted_date);
}

char* format_time(const char* time) {
	const int BUFFER_LENGTH = strlen(time) * 3 + 1;
	char* formatted_time = (char*)malloc(BUFFER_LENGTH);
	if (!formatted_time) return nullptr;
	
	const int MAX_REPLACEMENT_LENGTH = 10; // "hh:mm:ss a" is the longest
	int pos = 0;
	int i = 0;
	while (time[i] != '\0' && (time[i] != '%' || time[i + 1] != '\0') && pos < BUFFER_LENGTH - MAX_REPLACEMENT_LENGTH) {
		if (time[i] == '%' && time[i + 1] != '\0') {
			char specifier = time[i + 1];
			const char* replacement = nullptr;
			switch (specifier) {
			case 'H': replacement = "HH"; break;
			case 'I': replacement = "hh"; break;
			case 'M': replacement = "mm"; break;
			case 'n': replacement = "\n"; break;
			case 'p': replacement = "a"; break;
			case 'r': replacement = "hh:mm:ss a"; break;
			case 'R': replacement = "HH:mm"; break;
			case 'S': replacement = "ss"; break;
			case 't': replacement = "\t"; break;
			case 'T': replacement = "HH:mm:ss"; break;
			case '%': 
				formatted_time[pos++] = '%';
				break;
			default: 
				formatted_time[pos++] = time[i + 1];
				break;
			}
			if (replacement) {
				int len = strlen(replacement);
				if (pos + len < BUFFER_LENGTH) {
					memcpy(formatted_time + pos, replacement, len);
					pos += len;
				}
			}
			i += 2;
		}
		else {
			formatted_time[pos++] = time[i];
			i++;
		}
	}
	formatted_time[pos] = '\0';
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
    else if (strcmp(method, "getFullDateFormat") == 0) {
        response = FL_METHOD_RESPONSE(fl_method_success_response_new(fl_value_new_string("")));
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



