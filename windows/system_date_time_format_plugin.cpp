#include "system_date_time_format_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <memory>

using namespace std;
using namespace flutter;

namespace system_date_time_format {

	// static
	void SystemDateTimeFormatPlugin::RegisterWithRegistrar(
		flutter::PluginRegistrarWindows* registrar) {
		auto channel =
			make_unique<MethodChannel<EncodableValue>>(
				registrar->messenger(), "system_date_time_format",
				&StandardMethodCodec::GetInstance());

		auto plugin = make_unique<SystemDateTimeFormatPlugin>();

		channel->SetMethodCallHandler(
			[plugin_pointer = plugin.get()](const auto& call, auto result) {
				plugin_pointer->HandleMethodCall(call, move(result));
			});

		registrar->AddPlugin(move(plugin));
	}

	SystemDateTimeFormatPlugin::SystemDateTimeFormatPlugin() {}

	SystemDateTimeFormatPlugin::~SystemDateTimeFormatPlugin() {}

	void SystemDateTimeFormatPlugin::HandleMethodCall(
		const MethodCall<EncodableValue>& method_call,
		std::unique_ptr<MethodResult<EncodableValue>> result) {

		if (method_call.method_name() == "getDateFormat") {
			result->Success(EncodableValue(SystemDateTimeFormatPlugin::getDateFormat()));
			return;
		}

		if (method_call.method_name() == "getMediumDateFormat") {
			result->Success(EncodableValue(""));
			return;
		}

		if (method_call.method_name() == "getLongDateFormat") {
			result->Success(EncodableValue(SystemDateTimeFormatPlugin::getLongDateFormat()));
			return;
		}

        if (method_call.method_name() == "getFullDateFormat") {
            result->Success(EncodableValue(""));
            return;
        }

		if (method_call.method_name() == "getTimeFormat") {
			result->Success(EncodableValue(SystemDateTimeFormatPlugin::getTimeFormat()));
			return;
		}

		result->NotImplemented();
	}

	string SystemDateTimeFormatPlugin::getDateFormat() {
		return getFormat(LOCALE_SSHORTDATE);
	}

	string SystemDateTimeFormatPlugin::getLongDateFormat() {
		return getFormat(LOCALE_SLONGDATE);
	}

	string SystemDateTimeFormatPlugin::getTimeFormat() {
		return getFormat(LOCALE_SSHORTTIME);
	}

	string SystemDateTimeFormatPlugin::getFormat(LCTYPE infoType) {
		TCHAR buffer[80];
		GetLocaleInfo(LOCALE_USER_DEFAULT, infoType, buffer, 80);

		int size = WideCharToMultiByte(CP_UTF8, 0, buffer, -1, nullptr, 0, nullptr, nullptr);
		string result(size - 1, 0); // subtract 1 to remove the null terminator
		WideCharToMultiByte(CP_UTF8, 0, buffer, -1, &result[0], size, nullptr, nullptr);

		return result;
	}

}  // namespace system_date_time_format
