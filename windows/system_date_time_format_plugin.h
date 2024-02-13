#ifndef FLUTTER_PLUGIN_SYSTEM_DATE_TIME_FORMAT_PLUGIN_H_
#define FLUTTER_PLUGIN_SYSTEM_DATE_TIME_FORMAT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <memory>

using namespace std;
using namespace flutter;

namespace system_date_time_format {

	class SystemDateTimeFormatPlugin : public Plugin {
	public:
		static void RegisterWithRegistrar(PluginRegistrarWindows* registrar);

		SystemDateTimeFormatPlugin();

		virtual ~SystemDateTimeFormatPlugin();

		// Disallow copy and assign.
		SystemDateTimeFormatPlugin(const SystemDateTimeFormatPlugin&) = delete;
		SystemDateTimeFormatPlugin& operator=(const SystemDateTimeFormatPlugin&) = delete;

	private:
		// Called when a method is called on this plugin's channel from Dart.
		void HandleMethodCall(
			const MethodCall<EncodableValue>& method_call,
			unique_ptr<MethodResult<EncodableValue>> result);
		string getDateFormat();
		string getMediumDateFormat();
		string getLongDateFormat();
		string getFullDateFormat();
		string getTimeFormat();
		string getFormat(LCTYPE infoType);
	};

}  // namespace system_date_time_format

#endif  // FLUTTER_PLUGIN_SYSTEM_DATE_TIME_FORMAT_PLUGIN_H_
