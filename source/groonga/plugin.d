/*
  Copyright(C) 2010-2017  Brazil
  Copyright(C) 2022  Sutou Kouhei <kou@clear-code.com>

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License version 2.1 as published by the Free Software Foundation.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/
module groonga.plugin;


private import groonga.groonga;
private import groonga.groonga: GRN_API, GRN_ATTRIBUTE_PRINTF;

/**
 * Don't use GRN_PLUGIN_SET_ERROR() directly. This macro is used in
 * GRN_PLUGIN_ERROR().
 */
//ToDo: example
template GRN_PLUGIN_SET_ERROR(string ctx, string level, string error_code, ARGUMENTS ...)
{
	enum GRN_PLUGIN_SET_ERROR = () {
		string output = `groonga.plugin.grn_plugin_set_error((` ~ ctx ~ `), (` ~ level ~ `), (` ~ error_code ~ `), __FILE__.ptr, __LINE__, __FUNCTION__.ptr`;

		assert(ARGUMENTS.length != 0);

		foreach (ARGUMENT; ARGUMENTS) {
			assert(is(typeof(ARGUMENT) == string));
			output ~= `, `;
			output ~= ARGUMENT;
		}

		output ~= `);`;

		return output;
	}();
}

///Ditto
template GRN_PLUGIN_ERROR(string ctx, string error_code, ARGUMENTS ...)
{
	enum GRN_PLUGIN_ERROR = () {
		string output = `mixin (groonga.plugin.GRN_PLUGIN_SET_ERROR!("` ~ ctx ~ `", "groonga.groonga.grn_log_level.GRN_LOG_ERROR", "` ~ error_code ~ `"`;

		assert(ARGUMENTS.length != 0);

		foreach (ARGUMENT; ARGUMENTS) {
			assert(is(typeof(ARGUMENT) == string));
			output ~= `, `;
			output ~= `"` ~ ARGUMENT ~ `"`;
		}

		output ~= `));`;

		return output;
	}();
}

extern(C):
nothrow @nogc:

/+
#include <stddef.h>

#include <groonga.h>
+/

template GRN_PLUGIN_IMPL_NAME_RAW(string type)
{
	enum GRN_PLUGIN_IMPL_NAME_RAW = "grn_plugin_impl_" ~ type;
}

template GRN_PLUGIN_IMPL_NAME_TAGGED(string type, string tag)
{
	enum GRN_PLUGIN_IMPL_NAME_TAGGED = "groonga.plugin.GRN_PLUGIN_IMPL_NAME_RAW!(\"" ~ type ~ "_" ~ tag ~ "\")";
}

template GRN_PLUGIN_IMPL_NAME_TAGGED_EXPANDABLE(string type, string tag)
{
	enum GRN_PLUGIN_IMPL_NAME_TAGGED_EXPANDABLE = "mixin (groonga.plugin.GRN_PLUGIN_IMPL_NAME_TAGGED!(\"" ~ type ~ "\", \"" ~ tag ~ "\"))";
}

/+
#ifdef GRN_PLUGIN_FUNCTION_TAG
	#define GRN_PLUGIN_IMPL_NAME(type) groonga.plugin.GRN_PLUGIN_IMPL_NAME_TAGGED_EXPANDABLE(type, GRN_PLUGIN_FUNCTION_TAG)
#else
	#define GRN_PLUGIN_IMPL_NAME(type) groonga.plugin.GRN_PLUGIN_IMPL_NAME_RAW(type)
#endif
+/

/+
#define GRN_PLUGIN_INIT     groonga.plugin.GRN_PLUGIN_IMPL_NAME(init)
#define GRN_PLUGIN_REGISTER groonga.plugin.GRN_PLUGIN_IMPL_NAME(register)
#define GRN_PLUGIN_FIN      groonga.plugin.GRN_PLUGIN_IMPL_NAME(fin)
+/

/+
#if defined(_WIN32) || defined(_WIN64)
	#define GRN_PLUGIN_EXPORT __declspec(dllexport)
#else
	#define GRN_PLUGIN_EXPORT
#endif
+/

enum GRN_PLUGIN_EXPORT;

@GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc GRN_PLUGIN_INIT(groonga.groonga.grn_ctx* ctx);

@GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc GRN_PLUGIN_REGISTER(groonga.groonga.grn_ctx* ctx);

@GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc GRN_PLUGIN_FIN(groonga.groonga.grn_ctx* ctx);

template GRN_PLUGIN_DECLARE_FUNCTIONS(string tag)
{
	enum GRN_PLUGIN_DECLARE_FUNCTIONS =
	`
		/* extern */ groonga.groonga.grn_rc ` ~ groonga.plugin.GRN_PLUGIN_IMPL_NAME_TAGGED!("init", tag) ~ `(groonga.groonga.grn_ctx *ctx);
		/* extern */ groonga.groonga.grn_rc ` ~ groonga.plugin.GRN_PLUGIN_IMPL_NAME_TAGGED!("register", tag) ~ `(groonga.groonga.grn_ctx *ctx);
		/* extern */ groonga.groonga.grn_rc ` ~ groonga.plugin.GRN_PLUGIN_IMPL_NAME_TAGGED!("fin", tag) ~ `(groonga.groonga.grn_ctx *ctx);
	`;
}

/*
  Don't call these functions directly. Use GRN_PLUGIN_MALLOC(),
  GRN_PLUGIN_CALLOC(), GRN_PLUGIN_REALLOC() and GRN_PLUGIN_FREE() instead.
 */

@GRN_API
@GRN_ATTRIBUTE_ALLOC_SIZE(2)
void* grn_plugin_malloc(groonga.groonga.grn_ctx* ctx, size_t size, const (char)* file, int line, const (char)* func);

@GRN_API
@GRN_ATTRIBUTE_ALLOC_SIZE(2)
void* grn_plugin_calloc(groonga.groonga.grn_ctx* ctx, size_t size, const (char)* file, int line, const (char)* func);

@GRN_API
@GRN_ATTRIBUTE_ALLOC_SIZE(3)
void* grn_plugin_realloc(groonga.groonga.grn_ctx* ctx, void* ptr_, size_t size, const (char)* file, int line, const (char)* func);

@GRN_API
void grn_plugin_free(groonga.groonga.grn_ctx* ctx, void* ptr_, const (char)* file, int line, const (char)* func);

template GRN_PLUGIN_MALLOC(string ctx, string size)
{
	enum GRN_PLUGIN_MALLOC = "groonga.plugin.grn_plugin_malloc((" ~ ctx ~ "), (" ~ size ~ "), __FILE__.ptr, __LINE__, __FUNCTION__.ptr);";
}

template GRN_PLUGIN_MALLOCN(string ctx, string type, string n)
{
	enum GRN_PLUGIN_MALLOCN = "cast(" ~ type ~ "*)(groonga.plugin.grn_plugin_malloc((" ~ ctx ~ "), (" ~ type ~ ").sizeof * (" ~ n ~ "), __FILE__.ptr, __LINE__, __FUNCTION__.ptr));";
}

template GRN_PLUGIN_CALLOC(string ctx, string size)
{
	enum GRN_PLUGIN_CALLOC = "groonga.plugin.grn_plugin_calloc((" ~ ctx ~ "), (" ~ size ~ "), __FILE__.ptr, __LINE__, __FUNCTION__.ptr);";
}

template GRN_PLUGIN_REALLOC(string ctx, string ptr_, string size)
{
	enum GRN_PLUGIN_REALLOC = "groonga.plugin.grn_plugin_realloc((" ~ ctx ~ "), (" ~ ptr_ ~ "), (" ~ size ~ "), __FILE__.ptr, __LINE__, __FUNCTION__.ptr)";
}

template GRN_PLUGIN_FREE(string ctx, string ptr_)
{
	enum GRN_PLUGIN_FREE = "groonga.plugin.grn_plugin_free((" ~ ctx ~ "), (" ~ ptr_ ~ "), __FILE__.ptr, __LINE__, __FUNCTION__.ptr)";
}

alias GRN_PLUGIN_LOG = groonga.groonga.GRN_LOG;

/*
  Don't call grn_plugin_set_error() directly. This function is used in
  GRN_PLUGIN_SET_ERROR().
 */

@GRN_API
@GRN_ATTRIBUTE_PRINTF(7)
pragma(printf)
void grn_plugin_set_error(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_log_level level, groonga.groonga.grn_rc error_code, const (char)* file, int line, const (char)* func, const (char)* format, ...);

@GRN_API
void grn_plugin_clear_error(groonga.groonga.grn_ctx* ctx);

/*
  Don't call these functions directly. grn_plugin_backtrace() and
  grn_plugin_logtrace() are used in GRN_PLUGIN_SET_ERROR().
 */

@GRN_API
void grn_plugin_backtrace(groonga.groonga.grn_ctx* ctx);

@GRN_API
void grn_plugin_logtrace(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_log_level level);

alias GRN_PLUGIN_CLEAR_ERROR = .grn_plugin_clear_error;

extern struct _grn_plugin_mutex;
alias grn_plugin_mutex = ._grn_plugin_mutex;

@GRN_API
.grn_plugin_mutex* grn_plugin_mutex_open(groonga.groonga.grn_ctx* ctx);

/*
  grn_plugin_mutex_create() is deprecated. Use grn_plugin_mutex_open()
  instead.
*/

@GRN_API
.grn_plugin_mutex* grn_plugin_mutex_create(groonga.groonga.grn_ctx* ctx);

@GRN_API
void grn_plugin_mutex_close(groonga.groonga.grn_ctx* ctx, .grn_plugin_mutex* mutex);

/*
  grn_plugin_mutex_destroy() is deprecated. Use grn_plugin_mutex_close()
  instead.
*/

@GRN_API
void grn_plugin_mutex_destroy(groonga.groonga.grn_ctx* ctx, .grn_plugin_mutex* mutex);

@GRN_API
void grn_plugin_mutex_lock(groonga.groonga.grn_ctx* ctx, .grn_plugin_mutex* mutex);

@GRN_API
void grn_plugin_mutex_unlock(groonga.groonga.grn_ctx* ctx, .grn_plugin_mutex* mutex);

@GRN_API
groonga.groonga.grn_obj* grn_plugin_proc_alloc(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, groonga.groonga.grn_id domain, ubyte flags);

@GRN_API
groonga.groonga.grn_obj* grn_plugin_proc_get_vars(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data);

@GRN_API
groonga.groonga.grn_obj* grn_plugin_proc_get_var(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, const (char)* name, int name_size);

@GRN_API
groonga.groonga.grn_bool grn_plugin_proc_get_var_bool(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, const (char)* name, int name_size, groonga.groonga.grn_bool default_value);

@GRN_API
int grn_plugin_proc_get_var_int32(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, const (char)* name, int name_size, int default_value);

@GRN_API
double grn_plugin_proc_get_var_double(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, const (char)* name, int name_size, double default_value);

@GRN_API
const (char)* grn_plugin_proc_get_var_string(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, const (char)* name, int name_size, size_t* size);

@GRN_API
groonga.groonga.grn_content_type grn_plugin_proc_get_var_content_type(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, const (char)* name, int name_size, groonga.groonga.grn_content_type default_value);

@GRN_API
groonga.groonga.grn_obj* grn_plugin_proc_get_var_by_offset(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, uint offset);

@GRN_API
groonga.groonga.grn_obj* grn_plugin_proc_get_caller(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data);

/* Deprecated since 5.0.9. Use grn_plugin_windows_base_dir() instead. */

@GRN_API
const (char)* grn_plugin_win32_base_dir();

@GRN_API
const (char)* grn_plugin_windows_base_dir();

@GRN_API
int grn_plugin_charlen(groonga.groonga.grn_ctx* ctx, const (char)* str_ptr, uint str_length, groonga.groonga.grn_encoding encoding);

@GRN_API
int grn_plugin_isspace(groonga.groonga.grn_ctx* ctx, const (char)* str_ptr, uint str_length, groonga.groonga.grn_encoding encoding);

@GRN_API
groonga.groonga.grn_rc grn_plugin_expr_var_init(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_expr_var* var, const (char)* name, int name_size);

//ToDo: grn_proc_func
version (none)
@GRN_API
groonga.groonga.grn_obj* grn_plugin_command_create(groonga.groonga.grn_ctx* ctx, const (char)* name, int name_size, groonga.groonga.grn_proc_func func, uint n_vars, groonga.groonga.grn_expr_var* vars);

@GRN_API
bool grn_plugin_proc_get_value_bool(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* value, bool default_value, const (char)* tag);

@GRN_API
long grn_plugin_proc_get_value_int64(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* value, long default_value_raw, const (char)* tag);

@GRN_API
double grn_plugin_proc_get_value_double(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* value, double default_value_raw, const (char)* tag);

@GRN_API
groonga.groonga.grn_operator grn_plugin_proc_get_value_mode(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* value, groonga.groonga.grn_operator default_mode, const (char)* tag);

@GRN_API
groonga.groonga.grn_operator grn_plugin_proc_get_value_operator(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* value, groonga.groonga.grn_operator default_oeprator, const (char)* tag);
