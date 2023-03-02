/*
  Copyright(C) 2009-2018  Brazil
  Copyright(C) 2018-2022  Sutou Kouhei <kou@clear-code.com>

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/
module groonga.groonga;


private static import core.stdc.config;
private static import core.stdc.stdarg;
private static import core.stdc.string;
private static import core.sys.posix.sys.types;
private static import core.sys.windows.basetsd;
private static import groonga.geo;

version (GNU) {
	private static import gcc.attributes;
}

//ToDo: example
///
template GRN_LOG(string ctx, string level, ARGUMENTS ...)
{
	enum GRN_LOG = () {
		string output =
		`
			if (groonga.groonga.grn_logger_pass((` ~ ctx ~ `) , (` ~ level ~ `))) {
				groonga.groonga.grn_logger_put((` ~ ctx ~ `), (` ~ level ~ `), __FILE__.ptr, __LINE__, __FUNCTION__.ptr`;

		assert(ARGUMENTS.length != 0);

		foreach (ARGUMENT; ARGUMENTS) {
			assert(is(typeof(ARGUMENT) == string));
			output ~= `, `;
			output ~= ARGUMENT;
		}

		output ~= `);`;
		output ~=
		`
			}
		`;

		return output;
	}();
}

///Ditto
template GRN_QUERY_LOG(string ctx, string flag, string mark, string format, ARGUMENTS ...)
{
	enum GRN_QUERY_LOG = () {
		string output =
		`
			if (.grn_query_logger_pass((` ~ ctx ~ `), (` ~ flag ~ `))) {
				.grn_query_logger_put((` ~ ctx ~ `), (` ~ flag ~ `), (` ~ mark ~ `), ` ~ format;

		if (ARGUMENTS.length != 0) {
			foreach (ARGUMENT; ARGUMENTS) {
				assert(is(typeof(ARGUMENT) == string));
				output ~= `, `;
				output ~= ARGUMENT;
			}
		}

		output ~= `);`;
		output ~=
		`
			}
		`;

		return output;
	}();
}

extern(C):
nothrow @nogc:

//ToDo: temp
version (Windows) {
	alias off_t = core.stdc.config.c_ulong;
	alias ssize_t = core.sys.windows.basetsd.SSIZE_T;
} else version (Posix) {
	alias off_t = core.sys.posix.sys.types.off_t;
	alias ssize_t = core.sys.posix.sys.types.ssize_t;
}

/+
#ifndef GRN_API
	#if defined(_WIN32) || defined(_WIN64)
		#define GRN_API __declspec(dllimport)
	#else
		#define GRN_API
	#endif /* defined(_WIN32) || defined(_WIN64) */
#endif /* GRN_API */
+/

enum GRN_API;

alias grn_id = uint;
/* Deprecated since 9.0.2. Use bool directly. */
deprecated alias grn_bool = bool;

enum GRN_ID_NIL = 0x00;
enum GRN_ID_MAX = 0x3FFFFFFF;

enum GRN_TRUE = true;
enum GRN_FALSE = false;

enum grn_rc
{
	GRN_SUCCESS = 0,
	GRN_END_OF_DATA = 1,
	GRN_UNKNOWN_ERROR = -1,
	GRN_OPERATION_NOT_PERMITTED = -2,
	GRN_NO_SUCH_FILE_OR_DIRECTORY = -3,
	GRN_NO_SUCH_PROCESS = -4,
	GRN_INTERRUPTED_FUNCTION_CALL = -5,
	GRN_INPUT_OUTPUT_ERROR = -6,
	GRN_NO_SUCH_DEVICE_OR_ADDRESS = -7,
	GRN_ARG_LIST_TOO_LONG = -8,
	GRN_EXEC_FORMAT_ERROR = -9,
	GRN_BAD_FILE_DESCRIPTOR = -10,
	GRN_NO_CHILD_PROCESSES = -11,
	GRN_RESOURCE_TEMPORARILY_UNAVAILABLE = -12,
	GRN_NOT_ENOUGH_SPACE = -13,
	GRN_PERMISSION_DENIED = -14,
	GRN_BAD_ADDRESS = -15,
	GRN_RESOURCE_BUSY = -16,
	GRN_FILE_EXISTS = -17,
	GRN_IMPROPER_LINK = -18,
	GRN_NO_SUCH_DEVICE = -19,
	GRN_NOT_A_DIRECTORY = -20,
	GRN_IS_A_DIRECTORY = -21,
	GRN_INVALID_ARGUMENT = -22,
	GRN_TOO_MANY_OPEN_FILES_IN_SYSTEM = -23,
	GRN_TOO_MANY_OPEN_FILES = -24,
	GRN_INAPPROPRIATE_I_O_CONTROL_OPERATION = -25,
	GRN_FILE_TOO_LARGE = -26,
	GRN_NO_SPACE_LEFT_ON_DEVICE = -27,
	GRN_INVALID_SEEK = -28,
	GRN_READ_ONLY_FILE_SYSTEM = -29,
	GRN_TOO_MANY_LINKS = -30,
	GRN_BROKEN_PIPE = -31,
	GRN_DOMAIN_ERROR = -32,
	GRN_RESULT_TOO_LARGE = -33,
	GRN_RESOURCE_DEADLOCK_AVOIDED = -34,
	GRN_NO_MEMORY_AVAILABLE = -35,
	GRN_FILENAME_TOO_LONG = -36,
	GRN_NO_LOCKS_AVAILABLE = -37,
	GRN_FUNCTION_NOT_IMPLEMENTED = -38,
	GRN_DIRECTORY_NOT_EMPTY = -39,
	GRN_ILLEGAL_BYTE_SEQUENCE = -40,
	GRN_SOCKET_NOT_INITIALIZED = -41,
	GRN_OPERATION_WOULD_BLOCK = -42,
	GRN_ADDRESS_IS_NOT_AVAILABLE = -43,
	GRN_NETWORK_IS_DOWN = -44,
	GRN_NO_BUFFER = -45,
	GRN_SOCKET_IS_ALREADY_CONNECTED = -46,
	GRN_SOCKET_IS_NOT_CONNECTED = -47,
	GRN_SOCKET_IS_ALREADY_SHUTDOWNED = -48,
	GRN_OPERATION_TIMEOUT = -49,
	GRN_CONNECTION_REFUSED = -50,
	GRN_RANGE_ERROR = -51,
	GRN_TOKENIZER_ERROR = -52,
	GRN_FILE_CORRUPT = -53,
	GRN_INVALID_FORMAT = -54,
	GRN_OBJECT_CORRUPT = -55,
	GRN_TOO_MANY_SYMBOLIC_LINKS = -56,
	GRN_NOT_SOCKET = -57,
	GRN_OPERATION_NOT_SUPPORTED = -58,
	GRN_ADDRESS_IS_IN_USE = -59,
	GRN_ZLIB_ERROR = -60,
	GRN_LZ4_ERROR = -61,

	/**
	 * Just for backward compatibility. We'll remove it at 5.0.0.
	 */
	GRN_LZO_ERROR = GRN_LZ4_ERROR,

	GRN_STACK_OVER_FLOW = -62,
	GRN_SYNTAX_ERROR = -63,
	GRN_RETRY_MAX = -64,
	GRN_INCOMPATIBLE_FILE_FORMAT = -65,
	GRN_UPDATE_NOT_ALLOWED = -66,
	GRN_TOO_SMALL_OFFSET = -67,
	GRN_TOO_LARGE_OFFSET = -68,
	GRN_TOO_SMALL_LIMIT = -69,
	GRN_CAS_ERROR = -70,
	GRN_UNSUPPORTED_COMMAND_VERSION = -71,
	GRN_NORMALIZER_ERROR = -72,
	GRN_TOKEN_FILTER_ERROR = -73,
	GRN_COMMAND_ERROR = -74,
	GRN_PLUGIN_ERROR = -75,
	GRN_SCORER_ERROR = -76,
	GRN_CANCEL = -77,
	GRN_WINDOW_FUNCTION_ERROR = -78,
	GRN_ZSTD_ERROR = -79,
	GRN_CONNECTION_RESET = -80,
}

//Declaration name in C language
enum
{
	GRN_SUCCESS = .grn_rc.GRN_SUCCESS,
	GRN_END_OF_DATA = .grn_rc.GRN_END_OF_DATA,
	GRN_UNKNOWN_ERROR = .grn_rc.GRN_UNKNOWN_ERROR,
	GRN_OPERATION_NOT_PERMITTED = .grn_rc.GRN_OPERATION_NOT_PERMITTED,
	GRN_NO_SUCH_FILE_OR_DIRECTORY = .grn_rc.GRN_NO_SUCH_FILE_OR_DIRECTORY,
	GRN_NO_SUCH_PROCESS = .grn_rc.GRN_NO_SUCH_PROCESS,
	GRN_INTERRUPTED_FUNCTION_CALL = .grn_rc.GRN_INTERRUPTED_FUNCTION_CALL,
	GRN_INPUT_OUTPUT_ERROR = .grn_rc.GRN_INPUT_OUTPUT_ERROR,
	GRN_NO_SUCH_DEVICE_OR_ADDRESS = .grn_rc.GRN_NO_SUCH_DEVICE_OR_ADDRESS,
	GRN_ARG_LIST_TOO_LONG = .grn_rc.GRN_ARG_LIST_TOO_LONG,
	GRN_EXEC_FORMAT_ERROR = .grn_rc.GRN_EXEC_FORMAT_ERROR,
	GRN_BAD_FILE_DESCRIPTOR = .grn_rc.GRN_BAD_FILE_DESCRIPTOR,
	GRN_NO_CHILD_PROCESSES = .grn_rc.GRN_NO_CHILD_PROCESSES,
	GRN_RESOURCE_TEMPORARILY_UNAVAILABLE = .grn_rc.GRN_RESOURCE_TEMPORARILY_UNAVAILABLE,
	GRN_NOT_ENOUGH_SPACE = .grn_rc.GRN_NOT_ENOUGH_SPACE,
	GRN_PERMISSION_DENIED = .grn_rc.GRN_PERMISSION_DENIED,
	GRN_BAD_ADDRESS = .grn_rc.GRN_BAD_ADDRESS,
	GRN_RESOURCE_BUSY = .grn_rc.GRN_RESOURCE_BUSY,
	GRN_FILE_EXISTS = .grn_rc.GRN_FILE_EXISTS,
	GRN_IMPROPER_LINK = .grn_rc.GRN_IMPROPER_LINK,
	GRN_NO_SUCH_DEVICE = .grn_rc.GRN_NO_SUCH_DEVICE,
	GRN_NOT_A_DIRECTORY = .grn_rc.GRN_NOT_A_DIRECTORY,
	GRN_IS_A_DIRECTORY = .grn_rc.GRN_IS_A_DIRECTORY,
	GRN_INVALID_ARGUMENT = .grn_rc.GRN_INVALID_ARGUMENT,
	GRN_TOO_MANY_OPEN_FILES_IN_SYSTEM = .grn_rc.GRN_TOO_MANY_OPEN_FILES_IN_SYSTEM,
	GRN_TOO_MANY_OPEN_FILES = .grn_rc.GRN_TOO_MANY_OPEN_FILES,
	GRN_INAPPROPRIATE_I_O_CONTROL_OPERATION = .grn_rc.GRN_INAPPROPRIATE_I_O_CONTROL_OPERATION,
	GRN_FILE_TOO_LARGE = .grn_rc.GRN_FILE_TOO_LARGE,
	GRN_NO_SPACE_LEFT_ON_DEVICE = .grn_rc.GRN_NO_SPACE_LEFT_ON_DEVICE,
	GRN_INVALID_SEEK = .grn_rc.GRN_INVALID_SEEK,
	GRN_READ_ONLY_FILE_SYSTEM = .grn_rc.GRN_READ_ONLY_FILE_SYSTEM,
	GRN_TOO_MANY_LINKS = .grn_rc.GRN_TOO_MANY_LINKS,
	GRN_BROKEN_PIPE = .grn_rc.GRN_BROKEN_PIPE,
	GRN_DOMAIN_ERROR = .grn_rc.GRN_DOMAIN_ERROR,
	GRN_RESULT_TOO_LARGE = .grn_rc.GRN_RESULT_TOO_LARGE,
	GRN_RESOURCE_DEADLOCK_AVOIDED = .grn_rc.GRN_RESOURCE_DEADLOCK_AVOIDED,
	GRN_NO_MEMORY_AVAILABLE = .grn_rc.GRN_NO_MEMORY_AVAILABLE,
	GRN_FILENAME_TOO_LONG = .grn_rc.GRN_FILENAME_TOO_LONG,
	GRN_NO_LOCKS_AVAILABLE = .grn_rc.GRN_NO_LOCKS_AVAILABLE,
	GRN_FUNCTION_NOT_IMPLEMENTED = .grn_rc.GRN_FUNCTION_NOT_IMPLEMENTED,
	GRN_DIRECTORY_NOT_EMPTY = .grn_rc.GRN_DIRECTORY_NOT_EMPTY,
	GRN_ILLEGAL_BYTE_SEQUENCE = .grn_rc.GRN_ILLEGAL_BYTE_SEQUENCE,
	GRN_SOCKET_NOT_INITIALIZED = .grn_rc.GRN_SOCKET_NOT_INITIALIZED,
	GRN_OPERATION_WOULD_BLOCK = .grn_rc.GRN_OPERATION_WOULD_BLOCK,
	GRN_ADDRESS_IS_NOT_AVAILABLE = .grn_rc.GRN_ADDRESS_IS_NOT_AVAILABLE,
	GRN_NETWORK_IS_DOWN = .grn_rc.GRN_NETWORK_IS_DOWN,
	GRN_NO_BUFFER = .grn_rc.GRN_NO_BUFFER,
	GRN_SOCKET_IS_ALREADY_CONNECTED = .grn_rc.GRN_SOCKET_IS_ALREADY_CONNECTED,
	GRN_SOCKET_IS_NOT_CONNECTED = .grn_rc.GRN_SOCKET_IS_NOT_CONNECTED,
	GRN_SOCKET_IS_ALREADY_SHUTDOWNED = .grn_rc.GRN_SOCKET_IS_ALREADY_SHUTDOWNED,
	GRN_OPERATION_TIMEOUT = .grn_rc.GRN_OPERATION_TIMEOUT,
	GRN_CONNECTION_REFUSED = .grn_rc.GRN_CONNECTION_REFUSED,
	GRN_RANGE_ERROR = .grn_rc.GRN_RANGE_ERROR,
	GRN_TOKENIZER_ERROR = .grn_rc.GRN_TOKENIZER_ERROR,
	GRN_FILE_CORRUPT = .grn_rc.GRN_FILE_CORRUPT,
	GRN_INVALID_FORMAT = .grn_rc.GRN_INVALID_FORMAT,
	GRN_OBJECT_CORRUPT = .grn_rc.GRN_OBJECT_CORRUPT,
	GRN_TOO_MANY_SYMBOLIC_LINKS = .grn_rc.GRN_TOO_MANY_SYMBOLIC_LINKS,
	GRN_NOT_SOCKET = .grn_rc.GRN_NOT_SOCKET,
	GRN_OPERATION_NOT_SUPPORTED = .grn_rc.GRN_OPERATION_NOT_SUPPORTED,
	GRN_ADDRESS_IS_IN_USE = .grn_rc.GRN_ADDRESS_IS_IN_USE,
	GRN_ZLIB_ERROR = .grn_rc.GRN_ZLIB_ERROR,
	GRN_LZ4_ERROR = .grn_rc.GRN_LZ4_ERROR,
	GRN_LZO_ERROR = .grn_rc.GRN_LZO_ERROR,
	GRN_STACK_OVER_FLOW = .grn_rc.GRN_STACK_OVER_FLOW,
	GRN_SYNTAX_ERROR = .grn_rc.GRN_SYNTAX_ERROR,
	GRN_RETRY_MAX = .grn_rc.GRN_RETRY_MAX,
	GRN_INCOMPATIBLE_FILE_FORMAT = .grn_rc.GRN_INCOMPATIBLE_FILE_FORMAT,
	GRN_UPDATE_NOT_ALLOWED = .grn_rc.GRN_UPDATE_NOT_ALLOWED,
	GRN_TOO_SMALL_OFFSET = .grn_rc.GRN_TOO_SMALL_OFFSET,
	GRN_TOO_LARGE_OFFSET = .grn_rc.GRN_TOO_LARGE_OFFSET,
	GRN_TOO_SMALL_LIMIT = .grn_rc.GRN_TOO_SMALL_LIMIT,
	GRN_CAS_ERROR = .grn_rc.GRN_CAS_ERROR,
	GRN_UNSUPPORTED_COMMAND_VERSION = .grn_rc.GRN_UNSUPPORTED_COMMAND_VERSION,
	GRN_NORMALIZER_ERROR = .grn_rc.GRN_NORMALIZER_ERROR,
	GRN_TOKEN_FILTER_ERROR = .grn_rc.GRN_TOKEN_FILTER_ERROR,
	GRN_COMMAND_ERROR = .grn_rc.GRN_COMMAND_ERROR,
	GRN_PLUGIN_ERROR = .grn_rc.GRN_PLUGIN_ERROR,
	GRN_SCORER_ERROR = .grn_rc.GRN_SCORER_ERROR,
	GRN_CANCEL = .grn_rc.GRN_CANCEL,
	GRN_WINDOW_FUNCTION_ERROR = .grn_rc.GRN_WINDOW_FUNCTION_ERROR,
	GRN_ZSTD_ERROR = .grn_rc.GRN_ZSTD_ERROR,
	GRN_CONNECTION_RESET = .grn_rc.GRN_CONNECTION_RESET,
}

@GRN_API
.grn_rc grn_init();

@GRN_API
.grn_rc grn_fin();

@GRN_API
const (char)* grn_get_global_error_message();

enum grn_encoding
{
	GRN_ENC_DEFAULT = 0,
	GRN_ENC_NONE,
	GRN_ENC_EUC_JP,
	GRN_ENC_UTF8,
	GRN_ENC_SJIS,
	GRN_ENC_LATIN1,
	GRN_ENC_KOI8R,
}

//Declaration name in C language
enum
{
	GRN_ENC_DEFAULT = .grn_encoding.GRN_ENC_DEFAULT,
	GRN_ENC_NONE = .grn_encoding.GRN_ENC_NONE,
	GRN_ENC_EUC_JP = .grn_encoding.GRN_ENC_EUC_JP,
	GRN_ENC_UTF8 = .grn_encoding.GRN_ENC_UTF8,
	GRN_ENC_SJIS = .grn_encoding.GRN_ENC_SJIS,
	GRN_ENC_LATIN1 = .grn_encoding.GRN_ENC_LATIN1,
	GRN_ENC_KOI8R = .grn_encoding.GRN_ENC_KOI8R,
}

enum grn_command_version
{
	GRN_COMMAND_VERSION_DEFAULT = 0,
	GRN_COMMAND_VERSION_1,
	GRN_COMMAND_VERSION_2,
	GRN_COMMAND_VERSION_3,
}

//Declaration name in C language
enum
{
	GRN_COMMAND_VERSION_DEFAULT = .grn_command_version.GRN_COMMAND_VERSION_DEFAULT,
	GRN_COMMAND_VERSION_1 = .grn_command_version.GRN_COMMAND_VERSION_1,
	GRN_COMMAND_VERSION_2 = .grn_command_version.GRN_COMMAND_VERSION_2,
	GRN_COMMAND_VERSION_3 = .grn_command_version.GRN_COMMAND_VERSION_3,
}

enum GRN_COMMAND_VERSION_MIN = .grn_command_version.GRN_COMMAND_VERSION_1;
enum GRN_COMMAND_VERSION_STABLE = .grn_command_version.GRN_COMMAND_VERSION_1;
enum GRN_COMMAND_VERSION_MAX = .grn_command_version.GRN_COMMAND_VERSION_3;

enum grn_log_level
{
	GRN_LOG_NONE = 0,
	GRN_LOG_EMERG,
	GRN_LOG_ALERT,
	GRN_LOG_CRIT,
	GRN_LOG_ERROR,
	GRN_LOG_WARNING,
	GRN_LOG_NOTICE,
	GRN_LOG_INFO,
	GRN_LOG_DEBUG,
	GRN_LOG_DUMP,
}

//Declaration name in C language
enum
{
	//GRN_LOG_NONE = .grn_log_level.GRN_LOG_NONE,
	GRN_LOG_EMERG = .grn_log_level.GRN_LOG_EMERG,
	GRN_LOG_ALERT = .grn_log_level.GRN_LOG_ALERT,
	GRN_LOG_CRIT = .grn_log_level.GRN_LOG_CRIT,
	GRN_LOG_ERROR = .grn_log_level.GRN_LOG_ERROR,
	GRN_LOG_WARNING = .grn_log_level.GRN_LOG_WARNING,
	GRN_LOG_NOTICE = .grn_log_level.GRN_LOG_NOTICE,
	GRN_LOG_INFO = .grn_log_level.GRN_LOG_INFO,
	GRN_LOG_DEBUG = .grn_log_level.GRN_LOG_DEBUG,
	GRN_LOG_DUMP = .grn_log_level.GRN_LOG_DUMP,
}

@GRN_API
const (char)* grn_log_level_to_string(.grn_log_level level);

@GRN_API
.grn_bool grn_log_level_parse(const (char)* string_, .grn_log_level* level);

/* query log flags */
enum GRN_QUERY_LOG_NONE = 0x00;
enum GRN_QUERY_LOG_COMMAND = 0x01 << 0;
enum GRN_QUERY_LOG_RESULT_CODE = 0x01 << 1;
enum GRN_QUERY_LOG_DESTINATION = 0x01 << 2;
enum GRN_QUERY_LOG_CACHE = 0x01 << 3;
enum GRN_QUERY_LOG_SIZE = 0x01 << 4;
enum GRN_QUERY_LOG_SCORE = 0x01 << 5;
enum GRN_QUERY_LOG_ALL = .GRN_QUERY_LOG_COMMAND | .GRN_QUERY_LOG_RESULT_CODE | .GRN_QUERY_LOG_DESTINATION | .GRN_QUERY_LOG_CACHE | .GRN_QUERY_LOG_SIZE | .GRN_QUERY_LOG_SCORE;
enum GRN_QUERY_LOG_DEFAULT = .GRN_QUERY_LOG_ALL;

enum grn_content_type
{
	GRN_CONTENT_NONE = 0,
	GRN_CONTENT_TSV,
	GRN_CONTENT_JSON,
	GRN_CONTENT_XML,
	GRN_CONTENT_MSGPACK,
	GRN_CONTENT_GROONGA_COMMAND_LIST,
	GRN_CONTENT_APACHE_ARROW,
}

//Declaration name in C language
enum
{
	GRN_CONTENT_NONE = .grn_content_type.GRN_CONTENT_NONE,
	GRN_CONTENT_TSV = .grn_content_type.GRN_CONTENT_TSV,
	GRN_CONTENT_JSON = .grn_content_type.GRN_CONTENT_JSON,
	GRN_CONTENT_XML = .grn_content_type.GRN_CONTENT_XML,
	GRN_CONTENT_MSGPACK = .grn_content_type.GRN_CONTENT_MSGPACK,
	GRN_CONTENT_GROONGA_COMMAND_LIST = .grn_content_type.GRN_CONTENT_GROONGA_COMMAND_LIST,
	GRN_CONTENT_APACHE_ARROW = .grn_content_type.GRN_CONTENT_APACHE_ARROW,
}

enum GRN_CTX_MSGSIZE = 0x80;
enum GRN_CTX_FIN = 0xFF;

alias grn_close_func = extern (C) void function (.grn_ctx* ctx, void* data);

union grn_user_data
{
	int int_value;
	.grn_id id;
	void* ptr_;

	deprecated
	alias ptr = ptr_;
}

alias grn_proc_func = extern (C) .grn_obj* function(.grn_ctx* ctx, int nargs, .grn_obj** args, .grn_user_data* user_data);

extern struct _grn_ctx_impl;

struct _grn_ctx
{
	.grn_rc rc;
	int flags;
	.grn_encoding encoding;
	ubyte ntrace;
	ubyte errlvl;
	ubyte stat;
	uint seqno;
	uint subno;
	uint seqno2;
	uint errline;
	.grn_user_data user_data;
	.grn_ctx* prev;
	.grn_ctx* next;
	const (char)* errfile;
	const (char)* errfunc;
	._grn_ctx_impl* impl;
	void*[16] trace;
	char[.GRN_CTX_MSGSIZE] errbuf = '\0';
}

alias grn_ctx = ._grn_ctx;

pragma(inline, true)
pure nothrow @trusted @nogc @live
.grn_user_data* GRN_CTX_USER_DATA(return scope .grn_ctx* ctx)

	in
	{
		assert(ctx != null);
	}

	do
	{
		return &(ctx.user_data);
	}

/* Deprecated since 4.0.3. Don't use it. */
enum GRN_CTX_USE_QL = 0x03;
/* Deprecated since 4.0.3. Don't use it. */
enum GRN_CTX_BATCH_MODE = 0x04;
enum GRN_CTX_PER_DB = 0x08;

@GRN_API
.grn_rc grn_ctx_init(.grn_ctx* ctx, int flags);

@GRN_API
.grn_rc grn_ctx_fin(.grn_ctx* ctx);

@GRN_API
.grn_ctx* grn_ctx_open(int flags);

@GRN_API
.grn_rc grn_ctx_close(.grn_ctx* ctx);

@GRN_API
.grn_rc grn_ctx_set_finalizer(.grn_ctx* ctx, .grn_proc_func* func);

@GRN_API
.grn_rc grn_ctx_push_temporary_open_space(.grn_ctx* ctx);

@GRN_API
.grn_rc grn_ctx_pop_temporary_open_space(.grn_ctx* ctx);

@GRN_API
.grn_rc grn_ctx_merge_temporary_open_space(.grn_ctx* ctx);

@GRN_API
.grn_encoding grn_get_default_encoding();

@GRN_API
.grn_rc grn_set_default_encoding(.grn_encoding encoding);

pragma(inline, true)
pure nothrow @trusted @nogc @live
.grn_encoding GRN_CTX_GET_ENCODING(scope const .grn_ctx* ctx)

	in
	{
		assert(ctx != null);
	}

	do
	{
		return ctx.encoding;
	}

pragma(inline, true)
void GRN_CTX_SET_ENCODING(scope .grn_ctx* ctx, .grn_encoding enc)

	in
	{
		assert(ctx != null);
	}

	do
	{
		ctx.encoding = (enc == .grn_encoding.GRN_ENC_DEFAULT) ? (.grn_get_default_encoding()) : (enc);
	}

@GRN_API
const (char)* grn_get_version();

@GRN_API
uint grn_get_version_major();

@GRN_API
uint grn_get_version_minor();

@GRN_API
uint grn_get_version_micro();

@GRN_API
const (char)* grn_get_package();

@GRN_API
const (char)* grn_get_package_label();

@GRN_API
.grn_command_version grn_get_default_command_version();

@GRN_API
.grn_rc grn_set_default_command_version(.grn_command_version input_version);

@GRN_API
.grn_command_version grn_ctx_get_command_version(.grn_ctx* ctx);

@GRN_API
.grn_rc grn_ctx_set_command_version(.grn_ctx* ctx, .grn_command_version input_version);

@GRN_API
long grn_ctx_get_match_escalation_threshold(.grn_ctx* ctx);

@GRN_API
.grn_rc grn_ctx_set_match_escalation_threshold(.grn_ctx* ctx, long threshold);

@GRN_API
.grn_bool grn_ctx_get_force_match_escalation(.grn_ctx* ctx);

@GRN_API
.grn_rc grn_ctx_set_force_match_escalation(.grn_ctx* ctx, .grn_bool force);

@GRN_API
long grn_get_default_match_escalation_threshold();

@GRN_API
.grn_rc grn_set_default_match_escalation_threshold(long threshold);

@GRN_API
bool grn_is_back_trace_enable();

@GRN_API
.grn_rc grn_set_back_trace_enable(bool enable);

@GRN_API
bool grn_is_reference_count_enable();

@GRN_API
.grn_rc grn_set_reference_count_enable(bool enable);

@GRN_API
.grn_rc grn_ctx_set_variable(.grn_ctx* ctx, const (char)* name, int name_size, void* data, .grn_close_func close_func);

@GRN_API
void* grn_ctx_get_variable(.grn_ctx* ctx, const (char)* name, int name_size);

@GRN_API
.grn_rc grn_unset_variable(const (char)* name, int name_size);

@GRN_API
int grn_get_lock_timeout();

@GRN_API
.grn_rc grn_set_lock_timeout(int timeout);

@GRN_API
size_t grn_get_memory_map_size();

/* .grn_encoding */

@GRN_API
const (char)* grn_encoding_to_string(.grn_encoding encoding);

@GRN_API
.grn_encoding grn_encoding_parse(const (char)* name);

/* obj */

alias grn_obj_flags = ushort;
alias grn_table_flags = uint;
alias grn_column_flags = uint;

/* flags for grn_obj_flags and grn_table_flags */

enum GRN_OBJ_FLAGS_MASK = 0xFFFF;

enum GRN_OBJ_TABLE_TYPE_MASK = 0x07;
enum GRN_OBJ_TABLE_HASH_KEY = 0x00;
enum GRN_OBJ_TABLE_PAT_KEY = 0x01;
enum GRN_OBJ_TABLE_DAT_KEY = 0x02;
enum GRN_OBJ_TABLE_NO_KEY = 0x03;

enum GRN_OBJ_KEY_MASK = 0x07 << 3;
enum GRN_OBJ_KEY_UINT = 0x00 << 3;
enum GRN_OBJ_KEY_INT = 0x01 << 3;
enum GRN_OBJ_KEY_FLOAT = 0x02 << 3;
enum GRN_OBJ_KEY_GEO_POINT = 0x03 << 3;

enum GRN_OBJ_KEY_WITH_SIS = 0x01 << 6;
enum GRN_OBJ_KEY_NORMALIZE = 0x01 << 7;

/* flags for grn_obj_flags and grn_column_flags */

enum GRN_OBJ_COLUMN_TYPE_MASK = 0x07;
enum GRN_OBJ_COLUMN_SCALAR = 0x00;
enum GRN_OBJ_COLUMN_VECTOR = 0x01;
enum GRN_OBJ_COLUMN_INDEX = 0x02;

enum GRN_OBJ_COMPRESS_MASK = 0x07 << 4;
enum GRN_OBJ_COMPRESS_NONE = 0x00 << 4;
enum GRN_OBJ_COMPRESS_ZLIB = 0x01 << 4;
enum GRN_OBJ_COMPRESS_LZ4 = 0x02 << 4;
/* Just for backward compatibility. We'll remove it at 5.0.0. */
enum GRN_OBJ_COMPRESS_LZO = .GRN_OBJ_COMPRESS_LZ4;
enum GRN_OBJ_COMPRESS_ZSTD = 0x03 << 4;

enum GRN_OBJ_WITH_SECTION = 0x01 << 7;
enum GRN_OBJ_WITH_WEIGHT = 0x01 << 8;
enum GRN_OBJ_WITH_POSITION = 0x01 << 9;
enum GRN_OBJ_RING_BUFFER = 0x01 << 10;

enum GRN_OBJ_UNIT_MASK = 0x0F << 8;
enum GRN_OBJ_UNIT_DOCUMENT_NONE = 0x00 << 8;
enum GRN_OBJ_UNIT_DOCUMENT_SECTION = 0x01 << 8;
enum GRN_OBJ_UNIT_DOCUMENT_POSITION = 0x02 << 8;
enum GRN_OBJ_UNIT_SECTION_NONE = 0x03 << 8;
enum GRN_OBJ_UNIT_SECTION_POSITION = 0x04 << 8;
enum GRN_OBJ_UNIT_POSITION_NONE = 0x05 << 8;
enum GRN_OBJ_UNIT_USERDEF_DOCUMENT = 0x06 << 8;
enum GRN_OBJ_UNIT_USERDEF_SECTION = 0x07 << 8;
enum GRN_OBJ_UNIT_USERDEF_POSITION = 0x08 << 8;

/* Don't use (0x01<<12) because it's used internally. */

enum GRN_OBJ_NO_SUBREC = 0x00 << 13;
enum GRN_OBJ_WITH_SUBREC = 0x01 << 13;

enum GRN_OBJ_KEY_VAR_SIZE = 0x01 << 14;

enum GRN_OBJ_TEMPORARY = 0x00 << 15;
enum GRN_OBJ_PERSISTENT = 0x01 << 15;

/* flags only for grn_table_flags */

enum GRN_OBJ_KEY_LARGE = 0x01 << 16;

/* flags only for grn_column_flags */

enum GRN_OBJ_INDEX_SMALL = 0x01 << 16;
enum GRN_OBJ_INDEX_MEDIUM = 0x01 << 17;
enum GRN_OBJ_INDEX_LARGE = 0x01 << 18;
enum GRN_OBJ_WEIGHT_FLOAT32 = 0x01 << 19;

enum GRN_OBJ_MISSING_MASK = 0x03 << 20;
enum GRN_OBJ_MISSING_ADD = 0x00 << 20;
enum GRN_OBJ_MISSING_IGNORE = 0x01 << 20;
enum GRN_OBJ_MISSING_NIL = 0x02 << 20;

enum GRN_OBJ_INVALID_MASK = 0x03 << 22;
enum GRN_OBJ_INVALID_ERROR = 0x00 << 22;
enum GRN_OBJ_INVALID_WARN = 0x01 << 22;
enum GRN_OBJ_INVALID_IGNORE = 0x02 << 22;

/* flags only for grn_table_flags and grn_column_flags */

/* GRN_COLUMN_INDEX only uses this for now */
enum GRN_OBJ_VISIBLE = cast(uint)(0x00 << 31);
enum GRN_OBJ_INVISIBLE = cast(uint)(0x01 << 31);

/* obj types */

enum GRN_VOID = 0x00;
enum GRN_BULK = 0x02;
enum GRN_PTR = 0x03;

/* vector of fixed size (uniform) data especially grn_id */
enum GRN_UVECTOR = 0x04;

/* vector of .grn_obj* */
enum GRN_PVECTOR = 0x05;

/* vector of arbitrary data */
enum GRN_VECTOR = 0x06;

enum GRN_MSG = 0x07;
enum GRN_QUERY = 0x08;
enum GRN_ACCESSOR = 0x09;
enum GRN_SNIP = 0x0B;
enum GRN_PATSNIP = 0x0C;
enum GRN_STRING = 0x0D;
enum GRN_HIGHLIGHTER = 0x0E;
enum GRN_CURSOR_TABLE_HASH_KEY = 0x10;
enum GRN_CURSOR_TABLE_PAT_KEY = 0x11;
enum GRN_CURSOR_TABLE_DAT_KEY = 0x12;
enum GRN_CURSOR_TABLE_NO_KEY = 0x13;
enum GRN_CURSOR_COLUMN_INDEX = 0x18;
enum GRN_CURSOR_COLUMN_GEO_INDEX = 0x1A;
enum GRN_CURSOR_CONFIG = 0x1F;
enum GRN_TYPE = 0x20;
enum GRN_PROC = 0x21;
enum GRN_EXPR = 0x22;
enum GRN_TABLE_HASH_KEY = 0x30;
enum GRN_TABLE_PAT_KEY = 0x31;
enum GRN_TABLE_DAT_KEY = 0x32;
enum GRN_TABLE_NO_KEY = 0x33;
enum GRN_DB = 0x37;
enum GRN_COLUMN_FIX_SIZE = 0x40;
enum GRN_COLUMN_VAR_SIZE = 0x41;
enum GRN_COLUMN_INDEX = 0x48;

struct _grn_section
{
	uint offset;
	uint length;
	float weight = 0;
	.grn_id domain;
}

alias grn_section = ._grn_section;

struct _grn_obj_header
{
	ubyte type;
	ubyte impl_flags;
	.grn_obj_flags flags;
	.grn_id domain;
}

alias grn_obj_header = ._grn_obj_header;

struct _grn_obj
{
	.grn_obj_header header;

	union u_
	{
		struct b_
		{
			char* head;
			char* curr;
			char* tail;
		}

		b_ b;

		struct v_
		{
			.grn_obj* body_;
			.grn_section* sections;
			uint n_sections;
		}

		v_ v;
	}

	u_ u;
}

alias grn_obj = ._grn_obj;

enum GRN_OBJ_REFER = 0x01 << 0;
enum GRN_OBJ_OUTPLACE = 0x01 << 1;
enum GRN_OBJ_OWN = 0x01 << 5;

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_OBJ_INIT(scope .grn_obj* obj, ubyte obj_type, ubyte obj_flags, .grn_id obj_domain)

	in
	{
		assert(obj != null);
	}

	do
	{
		obj.header.type = obj_type;
		obj.header.impl_flags = obj_flags;
		obj.header.flags = 0;
		obj.header.domain = obj_domain;
		obj.u.b.head = null;
		obj.u.b.curr = null;
		obj.u.b.tail = null;
	}

alias GRN_OBJ_FIN = .grn_obj_close;

@GRN_API
.grn_rc grn_ctx_use(.grn_ctx* ctx, .grn_obj* db);

@GRN_API
.grn_obj* grn_ctx_db(.grn_ctx* ctx);

@GRN_API
.grn_obj* grn_ctx_get(.grn_ctx* ctx, const (char)* name, int name_size);

@GRN_API
.grn_rc grn_ctx_get_all_tables(.grn_ctx* ctx, .grn_obj* tables_buffer);

@GRN_API
.grn_rc grn_ctx_get_all_types(.grn_ctx* ctx, .grn_obj* types_buffer);

@GRN_API
.grn_rc grn_ctx_get_all_tokenizers(.grn_ctx* ctx, .grn_obj* tokenizers_buffer);

@GRN_API
.grn_rc grn_ctx_get_all_normalizers(.grn_ctx* ctx, .grn_obj* normalizers_buffer);

@GRN_API
.grn_rc grn_ctx_get_all_token_filters(.grn_ctx* ctx, .grn_obj* token_filters_buffer);

enum grn_builtin_type
{
	GRN_DB_VOID = 0,
	GRN_DB_DB,
	GRN_DB_OBJECT,
	GRN_DB_BOOL,
	GRN_DB_INT8,
	GRN_DB_UINT8,
	GRN_DB_INT16,
	GRN_DB_UINT16,
	GRN_DB_INT32,
	GRN_DB_UINT32,
	GRN_DB_INT64,
	GRN_DB_UINT64,
	GRN_DB_FLOAT,
	GRN_DB_TIME,
	GRN_DB_SHORT_TEXT,
	GRN_DB_TEXT,
	GRN_DB_LONG_TEXT,
	GRN_DB_TOKYO_GEO_POINT,
	GRN_DB_WGS84_GEO_POINT,
	GRN_DB_FLOAT32,
}

//Declaration name in C language
enum
{
	GRN_DB_VOID = .grn_builtin_type.GRN_DB_VOID,
	GRN_DB_DB = .grn_builtin_type.GRN_DB_DB,
	GRN_DB_OBJECT = .grn_builtin_type.GRN_DB_OBJECT,
	GRN_DB_BOOL = .grn_builtin_type.GRN_DB_BOOL,
	GRN_DB_INT8 = .grn_builtin_type.GRN_DB_INT8,
	GRN_DB_UINT8 = .grn_builtin_type.GRN_DB_UINT8,
	GRN_DB_INT16 = .grn_builtin_type.GRN_DB_INT16,
	GRN_DB_UINT16 = .grn_builtin_type.GRN_DB_UINT16,
	GRN_DB_INT32 = .grn_builtin_type.GRN_DB_INT32,
	GRN_DB_UINT32 = .grn_builtin_type.GRN_DB_UINT32,
	GRN_DB_INT64 = .grn_builtin_type.GRN_DB_INT64,
	GRN_DB_UINT64 = .grn_builtin_type.GRN_DB_UINT64,
	GRN_DB_FLOAT = .grn_builtin_type.GRN_DB_FLOAT,
	GRN_DB_TIME = .grn_builtin_type.GRN_DB_TIME,
	GRN_DB_SHORT_TEXT = .grn_builtin_type.GRN_DB_SHORT_TEXT,
	GRN_DB_TEXT = .grn_builtin_type.GRN_DB_TEXT,
	GRN_DB_LONG_TEXT = .grn_builtin_type.GRN_DB_LONG_TEXT,
	GRN_DB_TOKYO_GEO_POINT = .grn_builtin_type.GRN_DB_TOKYO_GEO_POINT,
	GRN_DB_WGS84_GEO_POINT = .grn_builtin_type.GRN_DB_WGS84_GEO_POINT,
	GRN_DB_FLOAT32 = .grn_builtin_type.GRN_DB_FLOAT32,
}

enum grn_builtin_tokenizer
{
	GRN_DB_MECAB = 64,
	GRN_DB_DELIMIT,
	GRN_DB_UNIGRAM,
	GRN_DB_BIGRAM,
	GRN_DB_TRIGRAM,
}

//Declaration name in C language
enum
{
	GRN_DB_MECAB = .grn_builtin_tokenizer.GRN_DB_MECAB,
	GRN_DB_DELIMIT = .grn_builtin_tokenizer.GRN_DB_DELIMIT,
	GRN_DB_UNIGRAM = .grn_builtin_tokenizer.GRN_DB_UNIGRAM,
	GRN_DB_BIGRAM = .grn_builtin_tokenizer.GRN_DB_BIGRAM,
	GRN_DB_TRIGRAM = .grn_builtin_tokenizer.GRN_DB_TRIGRAM,
}

@GRN_API
.grn_obj* grn_ctx_at(.grn_ctx* ctx, .grn_id id);

@GRN_API
.grn_bool grn_ctx_is_opened(.grn_ctx* ctx, .grn_id id);

@GRN_API
.grn_rc grn_plugin_register(.grn_ctx* ctx, const (char)* name);

@GRN_API
.grn_rc grn_plugin_unregister(.grn_ctx* ctx, const (char)* name);

@GRN_API
.grn_rc grn_plugin_register_by_path(.grn_ctx* ctx, const (char)* path);

@GRN_API
.grn_rc grn_plugin_unregister_by_path(.grn_ctx* ctx, const (char)* path);

@GRN_API
const (char)* grn_plugin_get_system_plugins_dir();

@GRN_API
const (char)* grn_plugin_get_suffix();

@GRN_API
const (char)* grn_plugin_get_ruby_suffix();

@GRN_API
.grn_rc grn_plugin_get_names(.grn_ctx* ctx, .grn_obj* names);

struct grn_expr_var
{
	const (char)* name;
	uint name_size;
	.grn_obj value;
}

.grn_rc function (.grn_ctx* ctx) grn_plugin_func;

alias grn_table_cursor = .grn_obj;

enum grn_operator
{
	GRN_OP_PUSH = 0,
	GRN_OP_POP,
	GRN_OP_NOP,
	GRN_OP_CALL,
	GRN_OP_INTERN,
	GRN_OP_GET_REF,
	GRN_OP_GET_VALUE,
	GRN_OP_AND,
	GRN_OP_AND_NOT,

	/**
	 * Deprecated. Just for backward compatibility.
	 */
	GRN_OP_BUT = GRN_OP_AND_NOT,

	GRN_OP_OR,
	GRN_OP_ASSIGN,
	GRN_OP_STAR_ASSIGN,
	GRN_OP_SLASH_ASSIGN,
	GRN_OP_MOD_ASSIGN,
	GRN_OP_PLUS_ASSIGN,
	GRN_OP_MINUS_ASSIGN,
	GRN_OP_SHIFTL_ASSIGN,
	GRN_OP_SHIFTR_ASSIGN,
	GRN_OP_SHIFTRR_ASSIGN,
	GRN_OP_AND_ASSIGN,
	GRN_OP_XOR_ASSIGN,
	GRN_OP_OR_ASSIGN,
	GRN_OP_JUMP,
	GRN_OP_CJUMP,
	GRN_OP_COMMA,
	GRN_OP_BITWISE_OR,
	GRN_OP_BITWISE_XOR,
	GRN_OP_BITWISE_AND,
	GRN_OP_BITWISE_NOT,
	GRN_OP_EQUAL,
	GRN_OP_NOT_EQUAL,
	GRN_OP_LESS,
	GRN_OP_GREATER,
	GRN_OP_LESS_EQUAL,
	GRN_OP_GREATER_EQUAL,
	GRN_OP_IN,
	GRN_OP_MATCH,
	GRN_OP_NEAR,
	GRN_OP_NEAR_NO_OFFSET,
	GRN_OP_SIMILAR,
	GRN_OP_TERM_EXTRACT,
	GRN_OP_SHIFTL,
	GRN_OP_SHIFTR,
	GRN_OP_SHIFTRR,
	GRN_OP_PLUS,
	GRN_OP_MINUS,
	GRN_OP_STAR,
	GRN_OP_SLASH,
	GRN_OP_MOD,
	GRN_OP_DELETE,
	GRN_OP_INCR,
	GRN_OP_DECR,
	GRN_OP_INCR_POST,
	GRN_OP_DECR_POST,
	GRN_OP_NOT,
	GRN_OP_ADJUST,
	GRN_OP_EXACT,
	GRN_OP_LCP,
	GRN_OP_PARTIAL,
	GRN_OP_UNSPLIT,
	GRN_OP_PREFIX,
	GRN_OP_SUFFIX,
	GRN_OP_GEO_DISTANCE1,
	GRN_OP_GEO_DISTANCE2,
	GRN_OP_GEO_DISTANCE3,
	GRN_OP_GEO_DISTANCE4,
	GRN_OP_GEO_WITHINP5,
	GRN_OP_GEO_WITHINP6,
	GRN_OP_GEO_WITHINP8,
	GRN_OP_OBJ_SEARCH,
	GRN_OP_EXPR_GET_VAR,
	GRN_OP_TABLE_CREATE,
	GRN_OP_TABLE_SELECT,
	GRN_OP_TABLE_SORT,
	GRN_OP_TABLE_GROUP,
	GRN_OP_JSON_PUT,
	GRN_OP_GET_MEMBER,
	GRN_OP_REGEXP,
	GRN_OP_FUZZY,
	GRN_OP_QUORUM,
	GRN_OP_NEAR_PHRASE,
	GRN_OP_ORDERED_NEAR_PHRASE,
	GRN_OP_NEAR_PHRASE_PRODUCT,
	GRN_OP_ORDERED_NEAR_PHRASE_PRODUCT,
}

//Declaration name in C language
enum
{
	GRN_OP_PUSH = .grn_operator.GRN_OP_PUSH,
	GRN_OP_POP = .grn_operator.GRN_OP_POP,
	GRN_OP_NOP = .grn_operator.GRN_OP_NOP,
	GRN_OP_CALL = .grn_operator.GRN_OP_CALL,
	GRN_OP_INTERN = .grn_operator.GRN_OP_INTERN,
	GRN_OP_GET_REF = .grn_operator.GRN_OP_GET_REF,
	GRN_OP_GET_VALUE = .grn_operator.GRN_OP_GET_VALUE,
	GRN_OP_AND = .grn_operator.GRN_OP_AND,
	GRN_OP_AND_NOT = .grn_operator.GRN_OP_AND_NOT,
	GRN_OP_BUT = .grn_operator.GRN_OP_BUT,
	GRN_OP_OR = .grn_operator.GRN_OP_OR,
	GRN_OP_ASSIGN = .grn_operator.GRN_OP_ASSIGN,
	GRN_OP_STAR_ASSIGN = .grn_operator.GRN_OP_STAR_ASSIGN,
	GRN_OP_SLASH_ASSIGN = .grn_operator.GRN_OP_SLASH_ASSIGN,
	GRN_OP_MOD_ASSIGN = .grn_operator.GRN_OP_MOD_ASSIGN,
	GRN_OP_PLUS_ASSIGN = .grn_operator.GRN_OP_PLUS_ASSIGN,
	GRN_OP_MINUS_ASSIGN = .grn_operator.GRN_OP_MINUS_ASSIGN,
	GRN_OP_SHIFTL_ASSIGN = .grn_operator.GRN_OP_SHIFTL_ASSIGN,
	GRN_OP_SHIFTR_ASSIGN = .grn_operator.GRN_OP_SHIFTR_ASSIGN,
	GRN_OP_SHIFTRR_ASSIGN = .grn_operator.GRN_OP_SHIFTRR_ASSIGN,
	GRN_OP_AND_ASSIGN = .grn_operator.GRN_OP_AND_ASSIGN,
	GRN_OP_XOR_ASSIGN = .grn_operator.GRN_OP_XOR_ASSIGN,
	GRN_OP_OR_ASSIGN = .grn_operator.GRN_OP_OR_ASSIGN,
	GRN_OP_JUMP = .grn_operator.GRN_OP_JUMP,
	GRN_OP_CJUMP = .grn_operator.GRN_OP_CJUMP,
	GRN_OP_COMMA = .grn_operator.GRN_OP_COMMA,
	GRN_OP_BITWISE_OR = .grn_operator.GRN_OP_BITWISE_OR,
	GRN_OP_BITWISE_XOR = .grn_operator.GRN_OP_BITWISE_XOR,
	GRN_OP_BITWISE_AND = .grn_operator.GRN_OP_BITWISE_AND,
	GRN_OP_BITWISE_NOT = .grn_operator.GRN_OP_BITWISE_NOT,
	GRN_OP_EQUAL = .grn_operator.GRN_OP_EQUAL,
	GRN_OP_NOT_EQUAL = .grn_operator.GRN_OP_NOT_EQUAL,
	GRN_OP_LESS = .grn_operator.GRN_OP_LESS,
	GRN_OP_GREATER = .grn_operator.GRN_OP_GREATER,
	GRN_OP_LESS_EQUAL = .grn_operator.GRN_OP_LESS_EQUAL,
	GRN_OP_GREATER_EQUAL = .grn_operator.GRN_OP_GREATER_EQUAL,
	GRN_OP_IN = .grn_operator.GRN_OP_IN,
	GRN_OP_MATCH = .grn_operator.GRN_OP_MATCH,
	GRN_OP_NEAR = .grn_operator.GRN_OP_NEAR,
	GRN_OP_NEAR_NO_OFFSET = .grn_operator.GRN_OP_NEAR_NO_OFFSET,
	GRN_OP_SIMILAR = .grn_operator.GRN_OP_SIMILAR,
	GRN_OP_TERM_EXTRACT = .grn_operator.GRN_OP_TERM_EXTRACT,
	GRN_OP_SHIFTL = .grn_operator.GRN_OP_SHIFTL,
	GRN_OP_SHIFTR = .grn_operator.GRN_OP_SHIFTR,
	GRN_OP_SHIFTRR = .grn_operator.GRN_OP_SHIFTRR,
	GRN_OP_PLUS = .grn_operator.GRN_OP_PLUS,
	GRN_OP_MINUS = .grn_operator.GRN_OP_MINUS,
	GRN_OP_STAR = .grn_operator.GRN_OP_STAR,
	GRN_OP_SLASH = .grn_operator.GRN_OP_SLASH,
	GRN_OP_MOD = .grn_operator.GRN_OP_MOD,
	GRN_OP_DELETE = .grn_operator.GRN_OP_DELETE,
	GRN_OP_INCR = .grn_operator.GRN_OP_INCR,
	GRN_OP_DECR = .grn_operator.GRN_OP_DECR,
	GRN_OP_INCR_POST = .grn_operator.GRN_OP_INCR_POST,
	GRN_OP_DECR_POST = .grn_operator.GRN_OP_DECR_POST,
	GRN_OP_NOT = .grn_operator.GRN_OP_NOT,
	GRN_OP_ADJUST = .grn_operator.GRN_OP_ADJUST,
	GRN_OP_EXACT = .grn_operator.GRN_OP_EXACT,
	GRN_OP_LCP = .grn_operator.GRN_OP_LCP,
	GRN_OP_PARTIAL = .grn_operator.GRN_OP_PARTIAL,
	GRN_OP_UNSPLIT = .grn_operator.GRN_OP_UNSPLIT,
	GRN_OP_PREFIX = .grn_operator.GRN_OP_PREFIX,
	GRN_OP_SUFFIX = .grn_operator.GRN_OP_SUFFIX,
	GRN_OP_GEO_DISTANCE1 = .grn_operator.GRN_OP_GEO_DISTANCE1,
	GRN_OP_GEO_DISTANCE2 = .grn_operator.GRN_OP_GEO_DISTANCE2,
	GRN_OP_GEO_DISTANCE3 = .grn_operator.GRN_OP_GEO_DISTANCE3,
	GRN_OP_GEO_DISTANCE4 = .grn_operator.GRN_OP_GEO_DISTANCE4,
	GRN_OP_GEO_WITHINP5 = .grn_operator.GRN_OP_GEO_WITHINP5,
	GRN_OP_GEO_WITHINP6 = .grn_operator.GRN_OP_GEO_WITHINP6,
	GRN_OP_GEO_WITHINP8 = .grn_operator.GRN_OP_GEO_WITHINP8,
	GRN_OP_OBJ_SEARCH = .grn_operator.GRN_OP_OBJ_SEARCH,
	GRN_OP_EXPR_GET_VAR = .grn_operator.GRN_OP_EXPR_GET_VAR,
	GRN_OP_TABLE_CREATE = .grn_operator.GRN_OP_TABLE_CREATE,
	GRN_OP_TABLE_SELECT = .grn_operator.GRN_OP_TABLE_SELECT,
	GRN_OP_TABLE_SORT = .grn_operator.GRN_OP_TABLE_SORT,
	GRN_OP_TABLE_GROUP = .grn_operator.GRN_OP_TABLE_GROUP,
	GRN_OP_JSON_PUT = .grn_operator.GRN_OP_JSON_PUT,
	GRN_OP_GET_MEMBER = .grn_operator.GRN_OP_GET_MEMBER,
	GRN_OP_REGEXP = .grn_operator.GRN_OP_REGEXP,
	GRN_OP_FUZZY = .grn_operator.GRN_OP_FUZZY,
	GRN_OP_QUORUM = .grn_operator.GRN_OP_QUORUM,
	GRN_OP_NEAR_PHRASE = .grn_operator.GRN_OP_NEAR_PHRASE,
	GRN_OP_ORDERED_NEAR_PHRASE = .grn_operator.GRN_OP_ORDERED_NEAR_PHRASE,
	GRN_OP_NEAR_PHRASE_PRODUCT = .grn_operator.GRN_OP_NEAR_PHRASE_PRODUCT,
	GRN_OP_ORDERED_NEAR_PHRASE_PRODUCT = .grn_operator.GRN_OP_ORDERED_NEAR_PHRASE_PRODUCT,
}

/* Deprecated. Just for backward compatibility. */
deprecated alias GRN_OP_NEAR2 = .GRN_OP_NEAR_NO_OFFSET;

@GRN_API
.grn_obj* grn_obj_column(.grn_ctx* ctx, .grn_obj* table, const (char)* name, uint name_size);

/*-------------------------------------------------------------
 * API for db, table and/or column
 */

enum grn_info_type
{
	GRN_INFO_ENCODING = 0,
	GRN_INFO_SOURCE,
	GRN_INFO_DEFAULT_TOKENIZER,
	GRN_INFO_ELEMENT_SIZE,
	GRN_INFO_CURR_MAX,
	GRN_INFO_MAX_ELEMENT_SIZE,
	GRN_INFO_SEG_SIZE,
	GRN_INFO_CHUNK_SIZE,
	GRN_INFO_MAX_SECTION,
	GRN_INFO_HOOK_LOCAL_DATA,
	GRN_INFO_ELEMENT_A,
	GRN_INFO_ELEMENT_CHUNK,
	GRN_INFO_ELEMENT_CHUNK_SIZE,
	GRN_INFO_ELEMENT_BUFFER_FREE,
	GRN_INFO_ELEMENT_NTERMS,
	GRN_INFO_ELEMENT_NTERMS_VOID,
	GRN_INFO_ELEMENT_SIZE_IN_CHUNK,
	GRN_INFO_ELEMENT_POS_IN_CHUNK,
	GRN_INFO_ELEMENT_SIZE_IN_BUFFER,
	GRN_INFO_ELEMENT_POS_IN_BUFFER,
	GRN_INFO_ELEMENT_ESTIMATE_SIZE,
	GRN_INFO_NGRAM_UNIT_SIZE,
	/*
	GRN_INFO_VERSION,
	GRN_INFO_CONFIGURE_OPTIONS,
	GRN_INFO_CONFIG_PATH,
	*/
	GRN_INFO_PARTIAL_MATCH_THRESHOLD,
	GRN_INFO_II_SPLIT_THRESHOLD,
	GRN_INFO_SUPPORT_ZLIB,
	GRN_INFO_SUPPORT_LZ4,
	/* Just for backward compatibility. We'll remove it at 5.0.0. */
	GRN_INFO_SUPPORT_LZO = GRN_INFO_SUPPORT_LZ4,
	GRN_INFO_NORMALIZER,
	GRN_INFO_TOKEN_FILTERS,
	GRN_INFO_SUPPORT_ZSTD,

	GRN_INFO_SUPPORT_APACHE_ARROW,
	GRN_INFO_NORMALIZERS,
}

//Declaration name in C language
enum
{
	GRN_INFO_ENCODING = .grn_info_type.GRN_INFO_ENCODING,
	GRN_INFO_SOURCE = .grn_info_type.GRN_INFO_SOURCE,
	GRN_INFO_DEFAULT_TOKENIZER = .grn_info_type.GRN_INFO_DEFAULT_TOKENIZER,
	GRN_INFO_ELEMENT_SIZE = .grn_info_type.GRN_INFO_ELEMENT_SIZE,
	GRN_INFO_CURR_MAX = .grn_info_type.GRN_INFO_CURR_MAX,
	GRN_INFO_MAX_ELEMENT_SIZE = .grn_info_type.GRN_INFO_MAX_ELEMENT_SIZE,
	GRN_INFO_SEG_SIZE = .grn_info_type.GRN_INFO_SEG_SIZE,
	GRN_INFO_CHUNK_SIZE = .grn_info_type.GRN_INFO_CHUNK_SIZE,
	GRN_INFO_MAX_SECTION = .grn_info_type.GRN_INFO_MAX_SECTION,
	GRN_INFO_HOOK_LOCAL_DATA = .grn_info_type.GRN_INFO_HOOK_LOCAL_DATA,
	GRN_INFO_ELEMENT_A = .grn_info_type.GRN_INFO_ELEMENT_A,
	GRN_INFO_ELEMENT_CHUNK = .grn_info_type.GRN_INFO_ELEMENT_CHUNK,
	GRN_INFO_ELEMENT_CHUNK_SIZE = .grn_info_type.GRN_INFO_ELEMENT_CHUNK_SIZE,
	GRN_INFO_ELEMENT_BUFFER_FREE = .grn_info_type.GRN_INFO_ELEMENT_BUFFER_FREE,
	GRN_INFO_ELEMENT_NTERMS = .grn_info_type.GRN_INFO_ELEMENT_NTERMS,
	GRN_INFO_ELEMENT_NTERMS_VOID = .grn_info_type.GRN_INFO_ELEMENT_NTERMS_VOID,
	GRN_INFO_ELEMENT_SIZE_IN_CHUNK = .grn_info_type.GRN_INFO_ELEMENT_SIZE_IN_CHUNK,
	GRN_INFO_ELEMENT_POS_IN_CHUNK = .grn_info_type.GRN_INFO_ELEMENT_POS_IN_CHUNK,
	GRN_INFO_ELEMENT_SIZE_IN_BUFFER = .grn_info_type.GRN_INFO_ELEMENT_SIZE_IN_BUFFER,
	GRN_INFO_ELEMENT_POS_IN_BUFFER = .grn_info_type.GRN_INFO_ELEMENT_POS_IN_BUFFER,
	GRN_INFO_ELEMENT_ESTIMATE_SIZE = .grn_info_type.GRN_INFO_ELEMENT_ESTIMATE_SIZE,
	GRN_INFO_NGRAM_UNIT_SIZE = .grn_info_type.GRN_INFO_NGRAM_UNIT_SIZE,
	/*
	GRN_INFO_VERSION = .grn_info_type.GRN_INFO_VERSION,
	GRN_INFO_CONFIGURE_OPTIONS = .grn_info_type.GRN_INFO_CONFIGURE_OPTIONS,
	GRN_INFO_CONFIG_PATH = .grn_info_type.GRN_INFO_CONFIG_PATH,
	*/
	GRN_INFO_PARTIAL_MATCH_THRESHOLD = .grn_info_type.GRN_INFO_PARTIAL_MATCH_THRESHOLD,
	GRN_INFO_II_SPLIT_THRESHOLD = .grn_info_type.GRN_INFO_II_SPLIT_THRESHOLD,
	GRN_INFO_SUPPORT_ZLIB = .grn_info_type.GRN_INFO_SUPPORT_ZLIB,
	GRN_INFO_SUPPORT_LZ4 = .grn_info_type.GRN_INFO_SUPPORT_LZ4,
	GRN_INFO_SUPPORT_LZO = .grn_info_type.GRN_INFO_SUPPORT_LZO,
	GRN_INFO_NORMALIZER = .grn_info_type.GRN_INFO_NORMALIZER,
	GRN_INFO_TOKEN_FILTERS = .grn_info_type.GRN_INFO_TOKEN_FILTERS,
	GRN_INFO_SUPPORT_ZSTD = .grn_info_type.GRN_INFO_SUPPORT_ZSTD,

	GRN_INFO_SUPPORT_APACHE_ARROW = .grn_info_type.GRN_INFO_SUPPORT_APACHE_ARROW,
}

/* Just for backward compatibility. */
package alias GRN_INFO_SUPPORT_ARROW = .grn_info_type.GRN_INFO_SUPPORT_APACHE_ARROW;

@GRN_API
.grn_obj* grn_obj_get_info(.grn_ctx* ctx, .grn_obj* obj, .grn_info_type type, .grn_obj* valuebuf);

@GRN_API
.grn_rc grn_obj_set_info(.grn_ctx* ctx, .grn_obj* obj, .grn_info_type type, .grn_obj* value);

@GRN_API
.grn_obj* grn_obj_get_element_info(.grn_ctx* ctx, .grn_obj* obj, .grn_id id, .grn_info_type type, .grn_obj* value);

@GRN_API
.grn_rc grn_obj_set_element_info(.grn_ctx* ctx, .grn_obj* obj, .grn_id id, .grn_info_type type, .grn_obj* value);

@GRN_API
.grn_obj* grn_obj_get_value(.grn_ctx* ctx, .grn_obj* obj, .grn_id id, .grn_obj* value);

@GRN_API
int grn_obj_get_values(.grn_ctx* ctx, .grn_obj* obj, .grn_id offset, void** values);

//ToDo: example
template GRN_COLUMN_EACH(string ctx, string column, string id, string value, string block)
{
	enum GRN_COLUMN_EACH =
	`
		do
		{
			int _n;
			.grn_id ` ~ id ~ ` = 1;

			while ((_n = .grn_obj_get_values((` ~ ctx ~ `), (` ~ column ~ `), (` ~ id ~ `), cast(void**)(&` ~ value ~ `))) > 0) {
				for (; _n; _n--, ` ~ id ~ `++, ` ~ value ~ `++) {
					` ~ block ~ `
				}
			}
		} while (false);
	`;
}

enum GRN_OBJ_SET_MASK = 0x07;
enum GRN_OBJ_SET = 0x01;
enum GRN_OBJ_INCR = 0x02;
enum GRN_OBJ_DECR = 0x03;
enum GRN_OBJ_APPEND = 0x04;
enum GRN_OBJ_PREPEND = 0x05;
enum GRN_OBJ_GET = 0x01 << 4;
enum GRN_OBJ_COMPARE = 0x01 << 5;
enum GRN_OBJ_LOCK = 0x01 << 6;
enum GRN_OBJ_UNLOCK = 0x01 << 7;

@GRN_API
.grn_rc grn_obj_set_value(.grn_ctx* ctx, .grn_obj* obj, .grn_id id, .grn_obj* value, int flags);

@GRN_API
.grn_rc grn_obj_remove(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_remove_dependent(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_remove_force(.grn_ctx* ctx, const (char)* name, int name_size);

@GRN_API
.grn_rc grn_obj_rename(.grn_ctx* ctx, .grn_obj* obj, const (char)* name, uint name_size);

@GRN_API
.grn_rc grn_table_rename(.grn_ctx* ctx, .grn_obj* table, const (char)* name, uint name_size);

@GRN_API
.grn_rc grn_column_rename(.grn_ctx* ctx, .grn_obj* column, const (char)* name, uint name_size);

@GRN_API
.grn_rc grn_obj_close(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_reinit(.grn_ctx* ctx, .grn_obj* obj, .grn_id domain, ubyte flags);
/* On non reference count mode (default):
* This closes the following objects immediately:
*
*   * Acceessor
*   * Bulk
*   * DB
*   * Temporary column
*   * Temporary table
*
* This does nothing for other objects such as persisted tables and
* columns.
*
* On reference count mode (GRN_ENABLE_REFERENCE_COUNT=yes):
* This closes the following objects immediately:
*
*   * Bulk
*   * DB
*
* This decreases the reference count of the following objects:
*
*   * Acceessor
*   * Column (both persisted and temporary)
*   * Table (both persisted and temporary)
*
* If the decreased reference count is zero, the object is closed.
*/
@GRN_API
void grn_obj_unlink(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_refer(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_refer_recursive(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_refer_recursive_dependent(.grn_ctx* ctx, .grn_obj* obj);
/* This calls grn_obj_unlink() only on reference count mode
* (GRN_ENABLE_REFERENCE_COUNT=yes) */
@GRN_API
void grn_obj_unref(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
void grn_obj_unref_recursive(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
void grn_obj_unref_recursive_dependent(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_user_data* grn_obj_user_data(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_set_finalizer(.grn_ctx* ctx, .grn_obj* obj, .grn_proc_func* func);

@GRN_API
const (char)* grn_obj_path(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
int grn_obj_name(.grn_ctx* ctx, .grn_obj* obj, char* namebuf, int buf_size);

@GRN_API
int grn_column_name(.grn_ctx* ctx, .grn_obj* obj, char* namebuf, int buf_size);

@GRN_API
.grn_id grn_obj_get_range(.grn_ctx* ctx, .grn_obj* obj);

pragma(inline, true)
pure nothrow @trusted @nogc @live
.grn_id GRN_OBJ_GET_DOMAIN(scope const .grn_obj* obj)

	in
	{
		assert(obj != null);
	}

	do
	{
		return (obj.header.type == .GRN_TABLE_NO_KEY) ? (.GRN_ID_NIL) : (obj.header.domain);
	}

@GRN_API
int grn_obj_expire(.grn_ctx* ctx, .grn_obj* obj, int threshold);

@GRN_API
int grn_obj_check(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_lock(.grn_ctx* ctx, .grn_obj* obj, .grn_id id, int timeout);

@GRN_API
.grn_rc grn_obj_unlock(.grn_ctx* ctx, .grn_obj* obj, .grn_id id);

@GRN_API
.grn_rc grn_obj_clear_lock(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
uint grn_obj_is_locked(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_flush(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_flush_recursive(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_flush_recursive_dependent(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_rc grn_obj_flush_only_opened(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
int grn_obj_defrag(.grn_ctx* ctx, .grn_obj* obj, int threshold);

@GRN_API
.grn_obj* grn_obj_db(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_id grn_obj_id(.grn_ctx* ctx, .grn_obj* obj);

/* Flags for grn_fuzzy_search_optarg.flags. */
enum GRN_TABLE_FUZZY_SEARCH_WITH_TRANSPOSITION = 0x01;

struct _grn_fuzzy_search_optarg
{
	uint max_distance;
	uint max_expansion;
	uint prefix_match_size;
	int flags;
}

alias grn_fuzzy_search_optarg = ._grn_fuzzy_search_optarg;

enum GRN_MATCH_INFO_GET_MIN_RECORD_ID = 0x01;
enum GRN_MATCH_INFO_ONLY_SKIP_TOKEN = 0x02;

struct _grn_match_info
{
	int flags;
	.grn_id min;
}

alias grn_match_info = ._grn_match_info;

struct _grn_search_optarg
{
	.grn_operator mode;
	int similarity_threshold;
	int max_interval;
	int* weight_vector;
	int vector_size;
	.grn_obj* proc;
	int max_size;
	.grn_obj* scorer;
	.grn_obj* scorer_args_expr;
	uint scorer_args_expr_offset;
	.grn_fuzzy_search_optarg fuzzy;
	.grn_match_info match_info;
	int quorum_threshold;
	int additional_last_interval;
	float* weight_vector_float;
	float weight_float = 0;
	.grn_obj* query_options;
	.grn_obj* max_element_intervals;
}

alias grn_search_optarg = ._grn_search_optarg;

@GRN_API
.grn_rc grn_obj_search(.grn_ctx* ctx, .grn_obj* obj, .grn_obj* query, .grn_obj* res, .grn_operator op, .grn_search_optarg* optarg);

@GRN_API
.grn_rc grn_proc_set_is_stable(.grn_ctx* ctx, .grn_obj* proc, .grn_bool is_stable);

@GRN_API
.grn_bool grn_proc_is_stable(.grn_ctx* ctx, .grn_obj* proc);

/*-------------------------------------------------------------
 * API for hook
 */

@GRN_API
int grn_proc_call_next(.grn_ctx* ctx, .grn_obj* exec_info, .grn_obj* in_, .grn_obj* out_);

@GRN_API
void* grn_proc_get_ctx_local_data(.grn_ctx* ctx, .grn_obj* exec_info);

@GRN_API
void* grn_proc_get_hook_local_data(.grn_ctx* ctx, .grn_obj* exec_info);

enum grn_hook_entry
{
	GRN_HOOK_SET = 0,
	GRN_HOOK_GET,
	GRN_HOOK_INSERT,
	GRN_HOOK_DELETE,
	GRN_HOOK_SELECT,
}

//Declaration name in C language
enum
{
	GRN_HOOK_SET = .grn_hook_entry.GRN_HOOK_SET,
	GRN_HOOK_GET = .grn_hook_entry.GRN_HOOK_GET,
	GRN_HOOK_INSERT = .grn_hook_entry.GRN_HOOK_INSERT,
	GRN_HOOK_DELETE = .grn_hook_entry.GRN_HOOK_DELETE,
	GRN_HOOK_SELECT = .grn_hook_entry.GRN_HOOK_SELECT,
}

@GRN_API
.grn_rc grn_obj_add_hook(.grn_ctx* ctx, .grn_obj* obj, .grn_hook_entry entry, int offset, .grn_obj* proc, .grn_obj* data);

@GRN_API
int grn_obj_get_nhooks(.grn_ctx* ctx, .grn_obj* obj, .grn_hook_entry entry);

@GRN_API
.grn_obj* grn_obj_get_hook(.grn_ctx* ctx, .grn_obj* obj, .grn_hook_entry entry, int offset, .grn_obj* data);

@GRN_API
.grn_rc grn_obj_delete_hook(.grn_ctx* ctx, .grn_obj* obj, .grn_hook_entry entry, int offset);

@GRN_API
.grn_obj* grn_obj_open(.grn_ctx* ctx, ubyte type, .grn_obj_flags flags, .grn_id domain);

/* Deprecated since 5.0.1. Use grn_column_find_index_data() instead. */

@GRN_API
int grn_column_index(.grn_ctx* ctx, .grn_obj* column, .grn_operator op, .grn_obj** indexbuf, int buf_size, int* section);

/* @since 5.0.1. */
struct _grn_index_datum
{
	.grn_obj* index;
	uint section;
}

alias grn_index_datum = ._grn_index_datum;

/* @since 5.0.1. */

@GRN_API
uint grn_column_find_index_data(.grn_ctx* ctx, .grn_obj* column, .grn_operator op, .grn_index_datum* index_data, uint n_index_data);
/* @since 5.1.2. */

@GRN_API
uint grn_column_get_all_index_data(.grn_ctx* ctx, .grn_obj* column, .grn_index_datum* index_data, uint n_index_data);

/* @since 9.1.2. */
@GRN_API
.grn_rc grn_column_get_all_index_columns(.grn_ctx* ctx, .grn_obj* column, .grn_obj* index_columns);

@GRN_API
.grn_rc grn_obj_delete_by_id(.grn_ctx* ctx, .grn_obj* db, .grn_id id, bool remove_p);

@GRN_API
.grn_rc grn_obj_path_by_id(.grn_ctx* ctx, .grn_obj* db, .grn_id id, char* buffer);

/* query & snippet */

static if (!__traits(compiles, .GRN_QUERY_AND)) {
	enum GRN_QUERY_AND = '+';
}

static if (!__traits(compiles, .GRN_QUERY_AND_NOT)) {
	static if (__traits(compiles, .GRN_QUERY_BUT)) {
		/* Deprecated. Just for backward compatibility. */
		enum GRN_QUERY_AND_NOT = .GRN_QUERY_BUT;
	} else {
		enum GRN_QUERY_AND_NOT = '-';
	}
}

static if (!__traits(compiles, .GRN_QUERY_ADJ_INC)) {
	enum GRN_QUERY_ADJ_INC = '>';
}

static if (!__traits(compiles, .GRN_QUERY_ADJ_DEC)) {
	enum GRN_QUERY_ADJ_DEC = '<';
}

static if (!__traits(compiles, .GRN_QUERY_ADJ_NEG)) {
	enum GRN_QUERY_ADJ_NEG = '~';
}

static if (!__traits(compiles, .GRN_QUERY_PREFIX)) {
	enum GRN_QUERY_PREFIX = '*';
}

static if (!__traits(compiles, .GRN_QUERY_PARENL)) {
	enum GRN_QUERY_PARENL = '(';
}

static if (!__traits(compiles, .GRN_QUERY_PARENR)) {
	enum GRN_QUERY_PARENR = ')';
}

static if (!__traits(compiles, .GRN_QUERY_QUOTEL)) {
	enum GRN_QUERY_QUOTEL = '"';
}

static if (!__traits(compiles, .GRN_QUERY_QUOTER)) {
	enum GRN_QUERY_QUOTER = '"';
}

static if (!__traits(compiles, .GRN_QUERY_ESCAPE)) {
	enum GRN_QUERY_ESCAPE = '\\';
}

static if (!__traits(compiles, .GRN_QUERY_COLUMN)) {
	enum GRN_QUERY_COLUMN = ':';
}

struct _grn_snip_mapping
{
	void* dummy;
}

alias grn_snip_mapping = ._grn_snip_mapping;

enum GRN_SNIP_NORMALIZE = 0x01 << 0;
enum GRN_SNIP_COPY_TAG = 0x01 << 1;
enum GRN_SNIP_SKIP_LEADING_SPACES = 0x01 << 2;

enum .grn_snip_mapping* GRN_SNIP_MAPPING_HTML_ESCAPE = cast(.grn_snip_mapping*)(-1);

@GRN_API
.grn_obj* grn_snip_open(.grn_ctx* ctx, int flags, uint width, uint max_results, const (char)* defaultopentag, uint defaultopentag_len, const (char)* defaultclosetag, uint defaultclosetag_len, .grn_snip_mapping* mapping);

@GRN_API
.grn_rc grn_snip_add_cond(.grn_ctx* ctx, .grn_obj* snip, const (char)* keyword, uint keyword_len, const (char)* opentag, uint opentag_len, const (char)* closetag, uint closetag_len);

@GRN_API
.grn_rc grn_snip_set_normalizer(.grn_ctx* ctx, .grn_obj* snip, .grn_obj* normalizer);

@GRN_API
.grn_obj* grn_snip_get_normalizer(.grn_ctx* ctx, .grn_obj* snip);

@GRN_API
.grn_rc grn_snip_set_delimiter_regexp(.grn_ctx* ctx, .grn_obj* snip, const (char)* pattern, int pattern_length);

@GRN_API
const (char)* grn_snip_get_delimiter_regexp(.grn_ctx* ctx, .grn_obj* snip, size_t* pattern_length);

@GRN_API
.grn_rc grn_snip_exec(.grn_ctx* ctx, .grn_obj* snip, const (char)* string_, uint string_len, uint* nresults, uint* max_tagged_len);

@GRN_API
.grn_rc grn_snip_get_result(.grn_ctx* ctx, .grn_obj* snip, const uint index, char* result, uint* result_len);

/* log */

enum GRN_LOG_NONE = 0x00 << 0;
enum GRN_LOG_TIME = 0x01 << 0;
enum GRN_LOG_TITLE = 0x01 << 1;
enum GRN_LOG_MESSAGE = 0x01 << 2;
enum GRN_LOG_LOCATION = 0x01 << 3;
enum GRN_LOG_PID = 0x01 << 4;
enum GRN_LOG_PROCESS_ID = .GRN_LOG_PID;
enum GRN_LOG_THREAD_ID = 0x01 << 5;
enum GRN_LOG_ALL = .GRN_LOG_TIME | .GRN_LOG_TITLE | .GRN_LOG_MESSAGE | .GRN_LOG_LOCATION | .GRN_LOG_PROCESS_ID | .GRN_LOG_THREAD_ID;
enum GRN_LOG_DEFAULT = .GRN_LOG_TIME | .GRN_LOG_MESSAGE;

/* Deprecated since 2.1.2. Use .grn_logger instead. */
struct _grn_logger_info
{
extern (C):
	.grn_log_level max_level;
	int flags;
	void function (int, const (char)*, const (char)*, const (char)*, const (char)*, void*) func;
	void* func_arg;
}

/* Deprecated since 2.1.2. Use .grn_logger instead. */
alias grn_logger_info = ._grn_logger_info;

/* Deprecated since 2.1.2. Use grn_logger_set() instead. */

@GRN_API
.grn_rc grn_logger_info_set(.grn_ctx* ctx, const (.grn_logger_info)* info);

struct _grn_logger
{
extern (C):
	.grn_log_level max_level;
	int flags;
	void* user_data;
	void function (.grn_ctx* ctx, .grn_log_level level, const (char)* timestamp, const (char)* title, const (char)* message, const (char)* location, void* user_data) log;
	void function (.grn_ctx* ctx, void* user_data) reopen;
	void function (.grn_ctx* ctx, void* user_data) fin;
}

alias grn_logger = ._grn_logger;

@GRN_API
.grn_bool grn_log_flags_parse(const (char)* string_, int string_size, int* flags);

@GRN_API
.grn_rc grn_logger_set(.grn_ctx* ctx, const (.grn_logger)* logger);

@GRN_API
void grn_logger_set_max_level(.grn_ctx* ctx, .grn_log_level max_level);

@GRN_API
.grn_log_level grn_logger_get_max_level(.grn_ctx* ctx);

//version (GNU) {
version (none) {
	//#define GRN_ATTRIBUTE_PRINTF(fmt_pos) __attribute__ ((format(printf, fmt_pos, fmt_pos + 1)))
} else {
	struct GRN_ATTRIBUTE_PRINTF
	{
		int fmt_pos;
	}
}

version (GNU) {
	alias GRN_ATTRIBUTE_ALLOC_SIZE = gcc.attributes.alloc_size;
	alias GRN_ATTRIBUTE_ALLOC_SIZE_N = gcc.attributes.alloc_size;
} else {
	struct GRN_ATTRIBUTE_ALLOC_SIZE
	{
		int sizeArgIdx;
	}

	struct GRN_ATTRIBUTE_ALLOC_SIZE_N
	{
		int sizeArgIdx;
		int numArgIdx;
	}
}

@GRN_API
@GRN_ATTRIBUTE_PRINTF(6)
pragma(printf)
void grn_logger_put(.grn_ctx* ctx, .grn_log_level level, const (char)* file, int line, const (char)* func, const (char)* fmt, ...);

@GRN_API
void grn_logger_putv(.grn_ctx* ctx, .grn_log_level level, const (char)* file, int line, const (char)* func, const (char)* fmt, core.stdc.stdarg.va_list ap);

@GRN_API
void grn_logger_reopen(.grn_ctx* ctx);

@GRN_API
.grn_bool grn_logger_pass(.grn_ctx* ctx, .grn_log_level level);

@GRN_API
.grn_bool grn_logger_is_default_logger(.grn_ctx* ctx);

static if (!__traits(compiles, GRN_LOG_DEFAULT_LEVEL)) {
	enum GRN_LOG_DEFAULT_LEVEL = .grn_log_level.GRN_LOG_NOTICE;
}

@GRN_API
void grn_default_logger_set_max_level(.grn_log_level level);

@GRN_API
.grn_log_level grn_default_logger_get_max_level();

@GRN_API
void grn_default_logger_set_flags(int flags);

@GRN_API
int grn_default_logger_get_flags();

@GRN_API
void grn_default_logger_set_path(const (char)* path);

@GRN_API
const (char)* grn_default_logger_get_path();

@GRN_API
void grn_default_logger_set_rotate_threshold_size(.off_t threshold);

@GRN_API
.off_t grn_default_logger_get_rotate_threshold_size();

@GRN_API
.grn_rc grn_slow_log_push(.grn_ctx* ctx);

@GRN_API
double grn_slow_log_pop(.grn_ctx* ctx);

@GRN_API
bool grn_slow_log_is_slow(.grn_ctx* ctx, double elapsed_time);

pragma(inline, true)
nothrow @nogc
void GRN_SLOW_LOG_PUSH(.grn_ctx* ctx, .grn_log_level level)

	do
	{
		if (.grn_logger_pass(ctx, level)) {
			.grn_slow_log_push(ctx);
		}
	}

//ToDo: example
///
template GRN_SLOW_LOG_POP_BEGIN(string ctx, string level, string elapsed_time)
{
	enum GRN_SLOW_LOG_POP_BEGIN =
	`
		do {
			if (groonga.groonga.grn_logger_pass((` ~ ctx ~ `), (` ~ level ~ `))) {
				double ` ~ elapsed_time ~ ` = groonga.groonga.grn_slow_log_pop((` ~ ctx ~ `));

				if (groonga.groonga.grn_slow_log_is_slow((` ~ ctx ~ `), ` ~ elapsed_time ~ `)) {
	`;
}

///Ditto
template GRN_SLOW_LOG_POP_END(string ctx)
{
	enum GRN_SLOW_LOG_POP_END =
	`
				}
			}
		} while (false);
	`;
}

struct _grn_query_logger
{
extern (C):
	uint flags;
	void* user_data;
	void function(.grn_ctx* ctx, uint flag, const (char)* timestamp, const (char)* info, const (char)* message, void* user_data) log;
	void function(.grn_ctx* ctx, void* user_data) reopen;
	void function(.grn_ctx* ctx, void* user_data) fin;
}

alias grn_query_logger = ._grn_query_logger;

@GRN_API
.grn_bool grn_query_log_flags_parse(const (char)* string_, int string_size, uint* flags);

@GRN_API
.grn_rc grn_query_logger_set(.grn_ctx* ctx, const (.grn_query_logger)* logger);

@GRN_API
void grn_query_logger_set_flags(.grn_ctx* ctx, uint flags);

@GRN_API
void grn_query_logger_add_flags(.grn_ctx* ctx, uint flags);

@GRN_API
void grn_query_logger_remove_flags(.grn_ctx* ctx, uint flags);

@GRN_API
uint grn_query_logger_get_flags(.grn_ctx* ctx);

@GRN_API
@GRN_ATTRIBUTE_PRINTF(4)
pragma(printf)
void grn_query_logger_put(.grn_ctx* ctx, uint flag, const (char)* mark, const (char)* format, ...);

@GRN_API
void grn_query_logger_reopen(.grn_ctx* ctx);

@GRN_API
.grn_bool grn_query_logger_pass(.grn_ctx* ctx, uint flag);

@GRN_API
void grn_default_query_logger_set_flags(uint flags);

@GRN_API
uint grn_default_query_logger_get_flags();

@GRN_API
void grn_default_query_logger_set_path(const (char)* path);

@GRN_API
const (char)* grn_default_query_logger_get_path();

@GRN_API
void grn_default_query_logger_set_rotate_threshold_size(.off_t threshold);

@GRN_API
.off_t grn_default_query_logger_get_rotate_threshold_size();

/* grn_bulk */

enum GRN_BULK_BUFSIZE = .grn_obj.sizeof - .grn_obj_header.sizeof;
/* This assumes that .GRN_BULK_BUFSIZE is less than 32 (= 0x20). */
enum GRN_BULK_BUFSIZE_MAX = 0x1F;

pragma(inline, true)
pure nothrow @trusted @nogc @live
size_t GRN_BULK_SIZE_IN_FLAGS(size_t flags)

	do
	{
		return flags & .GRN_BULK_BUFSIZE_MAX;
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
ubyte GRN_BULK_OUTP(scope const .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		return bulk.header.impl_flags & .GRN_OBJ_OUTPLACE;
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_BULK_REWIND(scope .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		if (bulk.header.type == .GRN_VECTOR) {
			.grn_obj* _body = bulk.u.v.body_;

			if (_body != null) {
				if (.GRN_BULK_OUTP(_body)) {
					_body.u.b.curr = _body.u.b.head;
				} else {
					_body.header.flags &= cast(.grn_obj_flags)(~.GRN_BULK_BUFSIZE_MAX);
				}
			}

			bulk.u.v.n_sections = 0;
		} else {
			if (.GRN_BULK_OUTP(bulk)) {
				bulk.u.b.curr = bulk.u.b.head;
			} else {
				bulk.header.flags &= cast(.grn_obj_flags)(~.GRN_BULK_BUFSIZE_MAX);
			}
		}
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_BULK_SET_CURR(scope .grn_obj* buf, char* p)

	in
	{
		assert(buf != null);
	}

	do
	{
		if (.GRN_BULK_OUTP(buf)) {
			buf.u.b.curr = p;
		} else {
			buf.header.flags = cast(.grn_obj_flags)(p -.GRN_BULK_HEAD(buf));
		}
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_BULK_INCR_LEN(scope .grn_obj* bulk, size_t len)

	in
	{
		assert(bulk != null);
	}

	do
	{
		if (.GRN_BULK_OUTP(bulk)) {
			bulk.u.b.curr += len;
		} else {
			bulk.header.flags += cast(.grn_obj_flags)(len);
		}
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
size_t GRN_BULK_WSIZE(return scope const .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		return (.GRN_BULK_OUTP(bulk)) ? (cast(size_t)(bulk.u.b.tail - bulk.u.b.head)) : (.GRN_BULK_BUFSIZE);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
size_t GRN_BULK_REST(return scope const .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		return (.GRN_BULK_OUTP(bulk)) ? (cast(size_t)(bulk.u.b.tail - bulk.u.b.curr)) : (.GRN_BULK_BUFSIZE - .GRN_BULK_SIZE_IN_FLAGS(bulk.header.flags));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
size_t GRN_BULK_VSIZE(return scope const .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		return (.GRN_BULK_OUTP(bulk)) ? (cast(size_t)(bulk.u.b.curr - bulk.u.b.head)) : (.GRN_BULK_SIZE_IN_FLAGS(bulk.header.flags));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
char* GRN_BULK_EMPTYP(return scope const .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		return (.GRN_BULK_OUTP(bulk)) ? (cast(char*)(bulk.u.b.curr == bulk.u.b.head)) : (cast(char*)(!(.GRN_BULK_SIZE_IN_FLAGS(bulk.header.flags))));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
char* GRN_BULK_HEAD(return scope const .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		return (.GRN_BULK_OUTP(bulk)) ? (cast(char*)(bulk.u.b.head)) : (cast(char*)(&(bulk.u.b.head)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
char* GRN_BULK_CURR(return scope const .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		return (.GRN_BULK_OUTP(bulk)) ? (cast(char*)(bulk.u.b.curr)) : (cast(char*)(&(bulk.u.b.head)) + .GRN_BULK_SIZE_IN_FLAGS(bulk.header.flags));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
char* GRN_BULK_TAIL(return scope const .grn_obj* bulk)

	in
	{
		assert(bulk != null);
	}

	do
	{
		return (.GRN_BULK_OUTP(bulk)) ? (cast(char*)(bulk.u.b.tail)) : (cast(char*)(&(bulk[1])));
	}

@GRN_API
.grn_rc grn_bulk_reinit(.grn_ctx* ctx, .grn_obj* bulk, size_t size);

@GRN_API
.grn_rc grn_bulk_resize(.grn_ctx* ctx, .grn_obj* bulk, size_t newsize);

@GRN_API
.grn_rc grn_bulk_write(.grn_ctx* ctx, .grn_obj* bulk, const (char)* str, size_t len);

@GRN_API
.grn_rc grn_bulk_write_from(.grn_ctx* ctx, .grn_obj* bulk, const (char)* str, size_t from, size_t len);

@GRN_API
.grn_rc grn_bulk_reserve(.grn_ctx* ctx, .grn_obj* bulk, size_t len);

@GRN_API
.grn_rc grn_bulk_space(.grn_ctx* ctx, .grn_obj* bulk, size_t len);

@GRN_API
.grn_rc grn_bulk_truncate(.grn_ctx* ctx, .grn_obj* bulk, size_t len);

@GRN_API
char* grn_bulk_detach(.grn_ctx* ctx, .grn_obj* bulk);

@GRN_API
.grn_rc grn_bulk_fin(.grn_ctx* ctx, .grn_obj* bulk);

/* grn_text */

@GRN_API
.grn_rc grn_text_itoa(.grn_ctx* ctx, .grn_obj* bulk, int i);

@GRN_API
.grn_rc grn_text_itoa_padded(.grn_ctx* ctx, .grn_obj* bulk, int i, char ch, size_t len);

@GRN_API
.grn_rc grn_text_lltoa(.grn_ctx* ctx, .grn_obj* bulk, long i);

@GRN_API
.grn_rc grn_text_f32toa(.grn_ctx* ctx, .grn_obj* bulk, float f);

@GRN_API
.grn_rc grn_text_ftoa(.grn_ctx* ctx, .grn_obj* bulk, double d);

@GRN_API
.grn_rc grn_text_itoh(.grn_ctx* ctx, .grn_obj* bulk, uint i, size_t len);

@GRN_API
.grn_rc grn_text_itob(.grn_ctx* ctx, .grn_obj* bulk, .grn_id id);

@GRN_API
.grn_rc grn_text_lltob32h(.grn_ctx* ctx, .grn_obj* bulk, long i);

@GRN_API
.grn_rc grn_text_benc(.grn_ctx* ctx, .grn_obj* bulk, uint v);

@GRN_API
.grn_rc grn_text_esc(.grn_ctx* ctx, .grn_obj* bulk, const (char)* s, size_t len);

@GRN_API
.grn_rc grn_text_code_point(.grn_ctx* ctx, .grn_obj* buffer, uint code_point);

@GRN_API
.grn_rc grn_text_urlenc(.grn_ctx* ctx, .grn_obj* buf, const (char)* str, size_t len);

@GRN_API
const (char)* grn_text_urldec(.grn_ctx* ctx, .grn_obj* buf, const (char)* s, const (char)* e, char d);

@GRN_API
.grn_rc grn_text_escape_xml(.grn_ctx* ctx, .grn_obj* buf, const (char)* s, size_t len);

@GRN_API
.grn_rc grn_text_time2rfc1123(.grn_ctx* ctx, .grn_obj* bulk, int sec);

@GRN_API
@GRN_ATTRIBUTE_PRINTF(3)
pragma(printf)
.grn_rc grn_text_printf(.grn_ctx* ctx, .grn_obj* bulk, const (char)* format, ...);

@GRN_API
.grn_rc grn_text_printfv(.grn_ctx* ctx, .grn_obj* bulk, const (char)* format, core.stdc.stdarg.va_list args);
/* Deprecated since 10.0.3. Use grn_text_printfv() instead. */
@GRN_API
.grn_rc grn_text_vprintf(.grn_ctx* ctx, .grn_obj* bulk, const (char)* format, core.stdc.stdarg.va_list args);

alias grn_recv_handler_func = extern (C) void function(.grn_ctx* ctx, int flags, void* user_data);

@GRN_API
void grn_ctx_recv_handler_set(.grn_ctx*, .grn_recv_handler_func func, void* user_data);


/* various values exchanged via .grn_obj */

enum GRN_OBJ_DO_SHALLOW_COPY = .GRN_OBJ_REFER|.GRN_OBJ_OUTPLACE;
enum GRN_OBJ_VECTOR = 0x01 << 7;

pragma(inline, true)
pure nothrow @trusted @nogc @live
bool GRN_OBJ_MUTABLE(scope const .grn_obj* obj)

	do
	{
		return (obj != null) && (obj.header.type <= .GRN_VECTOR);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_VALUE_FIX_SIZE_INIT(scope .grn_obj* obj, ubyte flags, .grn_id domain)

	do
	{
		.GRN_OBJ_INIT(obj, (flags & .GRN_OBJ_VECTOR) ? (.GRN_UVECTOR) : (.GRN_BULK), (flags & .GRN_OBJ_DO_SHALLOW_COPY), domain);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_VALUE_VAR_SIZE_INIT(scope .grn_obj* obj, ubyte flags, .grn_id domain)

	do
	{
		.GRN_OBJ_INIT(obj, (flags & .GRN_OBJ_VECTOR) ? (.GRN_VECTOR) : (.GRN_BULK), (flags & .GRN_OBJ_DO_SHALLOW_COPY), domain);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_VOID_INIT(scope .grn_obj* obj)

	do
	{
		.GRN_OBJ_INIT(obj, .GRN_VOID, 0, .grn_builtin_type.GRN_DB_VOID);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_TEXT_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_VAR_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_TEXT);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_SHORT_TEXT_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_VAR_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_SHORT_TEXT);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_LONG_TEXT_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_VAR_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_LONG_TEXT);
	}

pragma(inline, true)
pure nothrow @nogc @live
void GRN_TEXT_SET_REF(STR)(scope .grn_obj* obj, STR* str, size_t len)

	in
	{
		assert(obj != null);
	}

	do
	{
		obj.u.b.head = cast(char*)(str);
		obj.u.b.curr = cast(char*)(str) + len;
	}

pragma(inline, true)
void GRN_TEXT_SET(STR)(.grn_ctx* ctx, .grn_obj* obj, STR* str, size_t len)

	in
	{
		assert(obj != null);
	}

	do
	{
		if (obj.header.impl_flags & .GRN_OBJ_REFER) {
			.GRN_TEXT_SET_REF(obj, str, len);
		} else {
			.grn_bulk_write_from(ctx, obj, cast(const (char)*)(str), 0, cast(uint)(len));
		}
	}

pragma(inline, true)
.grn_rc GRN_TEXT_PUT(STR)(.grn_ctx* ctx, .grn_obj* obj, STR* str, size_t len)

	do
	{
		return .grn_bulk_write(ctx, obj, cast(const (char)*)(str), cast(uint)(len));
	}

pragma(inline, true)
.grn_rc GRN_TEXT_PUTC(.grn_ctx* ctx, .grn_obj* obj, char c)

	do
	{
		char _c = c;

		return .grn_bulk_write(ctx, obj, &_c, 1);
	}

pragma(inline, true)
.grn_rc GRN_TEXT_PUTS(.grn_ctx* ctx, .grn_obj* obj, const (char)* str)

	do
	{
		return .GRN_TEXT_PUT(ctx, obj, str, core.stdc.string.strlen(str));
	}

pragma(inline, true)
void GRN_TEXT_SETS(STR)(.grn_ctx* ctx, .grn_obj* obj, STR* str)

	do
	{
		.GRN_TEXT_SET(ctx, obj, str, core.stdc.string.strlen(str));
	}

alias GRN_TEXT_VALUE = .GRN_BULK_HEAD;
alias GRN_TEXT_LEN = .GRN_BULK_VSIZE;

pragma(inline, true)
pure nothrow @nogc @live
bool GRN_TEXT_EQUAL_CSTRING(scope const .grn_obj* bulk, scope const char* string_)

	do
	{
		return (.GRN_TEXT_LEN(bulk) == core.stdc.string.strlen(string_)) && (core.stdc.string.memcmp(.GRN_TEXT_VALUE(bulk), string_, .GRN_TEXT_LEN(bulk)) == 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_BOOL_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_BOOL);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_INT8_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_INT8);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_UINT8_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_UINT8);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_INT16_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_INT16);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_UINT16_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_UINT16);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_INT32_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_INT32);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_UINT32_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_UINT32);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_INT64_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_INT64);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_UINT64_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_UINT64);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_FLOAT32_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_FLOAT32);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_FLOAT_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_FLOAT);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_TIME_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_TIME);
	}

alias GRN_RECORD_INIT = .GRN_VALUE_FIX_SIZE_INIT;

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_PTR_INIT(scope .grn_obj* obj, ubyte flags, .grn_id domain)

	do
	{
		.GRN_OBJ_INIT(obj, (flags & .GRN_OBJ_VECTOR) ? (.GRN_PVECTOR) : (.GRN_PTR), (flags & (.GRN_OBJ_DO_SHALLOW_COPY | .GRN_OBJ_OWN)), domain);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_TOKYO_GEO_POINT_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_TOKYO_GEO_POINT);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_WGS84_GEO_POINT_INIT(scope .grn_obj* obj, ubyte flags)

	do
	{
		.GRN_VALUE_FIX_SIZE_INIT(obj, flags, .grn_builtin_type.GRN_DB_WGS84_GEO_POINT);
	}

pragma(inline, true)
.grn_rc GRN_BOOL_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		bool _val = cast(bool)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, bool.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT8_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		byte _val = cast(byte)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, byte.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT8_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		ubyte _val = cast(ubyte)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, ubyte.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT16_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		short _val = cast(short)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, short.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT16_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		ushort _val = cast(ushort)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, ushort.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT32_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		int _val = cast(int)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, int.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT32_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		uint _val = cast(uint)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, uint.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT64_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		long _val = cast(long)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, long.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT64_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		ulong _val = cast(ulong)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, ulong.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_FLOAT32_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		float _val = cast(float)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, float.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_FLOAT_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		double _val = cast(double)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, double.sizeof);
	}

alias GRN_TIME_SET = .GRN_INT64_SET;

pragma(inline, true)
.grn_rc GRN_RECORD_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		.grn_id _val = cast(.grn_id)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, .grn_id.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_PTR_SET(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		.grn_obj *_val = cast(.grn_obj*)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, (.grn_obj*).sizeof);
	}

pragma(inline, true)
pure nothrow @safe @nogc @live
int GRN_GEO_DEGREE2MSEC(DEGREE)(DEGREE degree)

	do
	{
		return cast(int)((degree * 3600 * 1000) + ((degree > 0) ? (0.5) : (-0.5)));
	}

pragma(inline, true)
pure nothrow @safe @nogc @live
auto GRN_GEO_MSEC2DEGREE(MSEC)(MSEC msec)

	do
	{
		return ((cast(int)(msec)) / 3600.0) * 0.001;
	}

pragma(inline, true)
.grn_rc GRN_GEO_POINT_SET(LATITUDE, LONGITUDE)(.grn_ctx* ctx, .grn_obj* obj, LATITUDE _latitude, LONGITUDE _longitude)

	do
	{
		groonga.geo.grn_geo_point _val =
		{
			latitude: cast(int)(_latitude),
			longitude: cast(int)(_longitude),
		};

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), 0, groonga.geo.grn_geo_point.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_BOOL_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		bool _val = cast(bool)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset, bool.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT8_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		int8_t _val = cast(int8_t)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * int8_t.sizeof, int8_t.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT8_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		uint8_t _val = cast(uint8_t)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * uint8_t.sizeof, uint8_t.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT16_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		int16_t _val = cast(int16_t)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * int16_t.sizeof, int16_t.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT16_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		uint16_t _val = cast(uint16_t)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * uint16_t.sizeof, uint16_t.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT32_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		int32_t _val = cast(int32_t)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * int32_t.sizeof, int32_t.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT32_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		uint32_t _val = cast(uint32_t)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * uint32_t.sizeof, uint32_t.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT64_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		long _val = cast(long)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * long.sizeof, long.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT64_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		ulong _val = cast(ulong)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * ulong.sizeof, ulong.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_FLOAT32_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		float _val = cast(float)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * float.sizeof, float.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_FLOAT_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		double _val = cast(double)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * double.sizeof, double.sizeof);
	}

alias GRN_TIME_SET_AT = .GRN_INT64_SET_AT;

pragma(inline, true)
.grn_rc GRN_RECORD_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		.grn_id _val = cast(.grn_id)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * .grn_id.sizeof, .grn_id.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_PTR_SET_AT(VAL)(.grn_ctx* ctx, .grn_obj* obj, size_t offset, VAL val)

	do
	{
		.grn_obj *_val = cast(.grn_obj*)(val);

		return .grn_bulk_write_from(ctx, obj, cast(char*)(&_val), offset * (.grn_obj*).sizeof, (.grn_obj*).sizeof);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
bool GRN_BOOL_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(bool*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
byte GRN_INT8_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(byte*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
ubyte GRN_UINT8_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(ubyte*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
short GRN_INT16_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(short*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
ushort GRN_UINT16_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(ushort*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
int GRN_INT32_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(int*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
uint GRN_UINT32_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(uint*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
long GRN_INT64_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(long*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
ulong GRN_UINT64_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(ulong*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
float GRN_FLOAT32_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(float*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
float GRN_FLOAT_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(double*)(.GRN_BULK_HEAD(obj)));
	}

alias GRN_TIME_VALUE = .GRN_INT64_VALUE;

pragma(inline, true)
pure nothrow @trusted @nogc @live
.grn_id GRN_RECORD_VALUE(scope const .grn_obj* obj)

	do
	{
		return *(cast(.grn_id*)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
.grn_obj* GRN_PTR_VALUE(return scope const .grn_obj* obj)

	do
	{
		return *(cast(.grn_obj**)(.GRN_BULK_HEAD(obj)));
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_GEO_POINT_VALUE(scope const .grn_obj* obj, ref int _latitude, ref int _longitude)

	do
	{
		groonga.geo.grn_geo_point *_val = cast(groonga.geo.grn_geo_point*)(.GRN_BULK_HEAD(obj));
		_latitude = _val.latitude;
		_longitude = _val.longitude;
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
bool GRN_BOOL_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(bool*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
byte GRN_INT8_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(byte*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
ubyte GRN_UINT8_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(ubyte*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
short GRN_INT16_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(short*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
ushort GRN_UINT16_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(ushort*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
int GRN_INT32_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(int*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
uint GRN_UINT32_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(uint*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
long GRN_INT64_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(long*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
ulong GRN_UINT64_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(ulong*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
float GRN_FLOAT32_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(float*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
double GRN_FLOAT_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(double*)(.GRN_BULK_HEAD(obj)))[offset];
	}

alias GRN_TIME_VALUE_AT = .GRN_INT64_VALUE_AT;

pragma(inline, true)
pure nothrow @trusted @nogc @live
.grn_id GRN_RECORD_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(.grn_id*)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
.grn_obj* GRN_PTR_VALUE_AT(scope const .grn_obj* obj, size_t offset)

	do
	{
		return (cast(.grn_obj**)(.GRN_BULK_HEAD(obj)))[offset];
	}

pragma(inline, true)
.grn_rc GRN_BOOL_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		bool _val = cast(bool)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), bool.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT8_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		byte _val = cast(byte)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), byte.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT8_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		ubyte _val = cast(ubyte)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), ubyte.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT16_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		short _val = cast(short)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), short.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT16_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		ushort _val = cast(ushort)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), ushort.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT32_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		int _val = cast(int)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), int.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT32_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		uint _val = cast(uint)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), uint.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_INT64_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		long _val = cast(long)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), long.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_UINT64_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		ulong _val = cast(ulong)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), ulong.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_FLOAT32_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		float _val = cast(float)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), float.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_FLOAT_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		double _val = cast(double)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), double.sizeof);
	}

alias GRN_TIME_PUT = .GRN_INT64_PUT;

pragma(inline, true)
.grn_rc GRN_RECORD_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		.grn_id _val = cast(.grn_id)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), .grn_id.sizeof);
	}

pragma(inline, true)
.grn_rc GRN_PTR_PUT(VAL)(.grn_ctx* ctx, .grn_obj* obj, VAL val)

	do
	{
		.grn_obj *_val = cast(.grn_obj*)(val);

		return .grn_bulk_write(ctx, obj, cast(char*)(&_val), (.grn_obj*).sizeof);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_BULK_POP(type)(scope .grn_obj* obj, type value, type default_)

	do
	{
		if (.GRN_BULK_VSIZE(obj) >= type.sizeof) {
			ssize_t value_size = cast(ssize_t)(type.sizeof);
			.GRN_BULK_INCR_LEN(obj, -value_size);
			value = *(cast(type*)(.GRN_BULK_CURR(obj)));
		} else {
			value = default_;
		}
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_BOOL_POP(scope .grn_obj* obj, bool value)

	do
	{
		.GRN_BULK_POP!(bool)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_INT8_POP(scope .grn_obj* obj, byte value)

	do
	{
		.GRN_BULK_POP!(byte)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_UINT8_POP(scope .grn_obj* obj, ubyte value)

	do
	{
		.GRN_BULK_POP!(ubyte)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_INT16_POP(scope .grn_obj* obj, short value)

	do
	{
		.GRN_BULK_POP!(short)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_UINT16_POP(scope .grn_obj* obj, ushort value)

	do
	{
		.GRN_BULK_POP!(ushort)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_INT32_POP(scope .grn_obj* obj, int value)

	do
	{
		.GRN_BULK_POP!(int)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_UINT32_POP(scope .grn_obj* obj, uint value)

	do
	{
		.GRN_BULK_POP!(uint)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_INT64_POP(scope .grn_obj* obj, long value)

	do
	{
		.GRN_BULK_POP!(long)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_UINT64_POP(scope .grn_obj* obj, ulong value)

	do
	{
		.GRN_BULK_POP!(ulong)(obj, value, 0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_FLOAT32_POP(scope .grn_obj* obj, float value)

	do
	{
		.GRN_BULK_POP!(float)(obj, value, 0.0);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_FLOAT_POP(scope .grn_obj* obj, double value)

	do
	{
		.GRN_BULK_POP!(double)(obj, value, 0.0);
	}

alias GRN_TIME_POP = .GRN_INT64_POP;

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_RECORD_POP(scope .grn_obj* obj, .grn_id value)

	do
	{
		.GRN_BULK_POP!(.grn_id)(obj, value, .GRN_ID_NIL);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_PTR_POP(scope .grn_obj* obj, .grn_obj* value)

	do
	{
		.GRN_BULK_POP!(.grn_obj*)(obj, value, null);
	}

pragma(inline, true)
pure nothrow @trusted @nogc @live
size_t GRN_BULK_VECTOR_SIZE(TYPE)(scope const .grn_obj* obj)

	do
	{
		return .GRN_BULK_VSIZE(obj) / TYPE.sizeof;
	}

alias GRN_BOOL_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(bool);
alias GRN_INT8_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(byte);
alias GRN_UINT8_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(ubyte);
alias GRN_INT16_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(short);
alias GRN_UINT16_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(ushort);
alias GRN_INT32_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(short);
alias GRN_UINT32_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(ushort);
alias GRN_INT64_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(long);
alias GRN_UINT64_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(ulong);
alias GRN_FLOAT32_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(float);
alias GRN_FLOAT_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(double);
alias GRN_TIME_VECTOR_SIZE = .GRN_INT64_VECTOR_SIZE;
alias GRN_RECORD_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(.grn_id);
alias GRN_PTR_VECTOR_SIZE = .GRN_BULK_VECTOR_SIZE!(.grn_obj*);

@GRN_API
.grn_rc grn_ctx_push(.grn_ctx* ctx, .grn_obj* obj);

@GRN_API
.grn_obj* grn_ctx_pop(.grn_ctx* ctx);

@GRN_API
int grn_obj_columns(.grn_ctx* ctx, .grn_obj* table, const (char)* str, uint str_size, .grn_obj* res);

@GRN_API
.grn_rc grn_load(.grn_ctx* ctx, .grn_content_type input_type, const (char)* table, uint table_len, const (char)* columns, uint columns_len, const (char)* values, uint values_len, const (char)* ifexists, uint ifexists_len, const (char)* each, uint each_len);

enum GRN_CTX_MORE = 0x01 << 0;
enum GRN_CTX_TAIL = 0x01 << 1;
enum GRN_CTX_HEAD = 0x01 << 2;
enum GRN_CTX_QUIET = 0x01 << 3;
enum GRN_CTX_QUIT = 0x01 << 4;

@GRN_API
.grn_rc grn_ctx_connect(.grn_ctx* ctx, const (char)* host, int port, int flags);

@GRN_API
uint grn_ctx_send(.grn_ctx* ctx, const (char)* str, uint str_len, int flags);

@GRN_API
uint grn_ctx_recv(.grn_ctx* ctx, char** str, uint* str_len, int* flags);

struct _grn_ctx_info
{
	int fd;
	uint com_status;
	.grn_obj* outbuf;
	ubyte stat;
}

alias grn_ctx_info = ._grn_ctx_info;

@GRN_API
.grn_rc grn_ctx_info_get(.grn_ctx* ctx, .grn_ctx_info* info);

@GRN_API
.grn_rc grn_set_segv_handler();

@GRN_API
.grn_rc grn_set_int_handler();

@GRN_API
.grn_rc grn_set_term_handler();

struct _grn_table_delete_optarg
{
extern (C):
	int flags;
	int function(.grn_ctx* ctx, .grn_obj*, .grn_id, void*) func;
	void* func_arg;
}

alias grn_table_delete_optarg = ._grn_table_delete_optarg;

struct _grn_table_scan_hit
{
	.grn_id id;
	uint offset;
	uint length;
}

struct grn_timeval
{
	long tv_sec;
	int tv_nsec;
}
