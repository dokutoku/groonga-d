/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2010-2017 Brazil

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
module groonga_d.plugin;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

/+
#include <stddef.h>

#include <groonga.h>

# define GRN_PLUGIN_IMPL_NAME_RAW(type) grn_plugin_impl_ ## type
# define GRN_PLUGIN_IMPL_NAME_TAGGED(type, tag) GRN_PLUGIN_IMPL_NAME_RAW(type ## _ ## tag)
# define GRN_PLUGIN_IMPL_NAME_TAGGED_EXPANDABLE(type, tag) GRN_PLUGIN_IMPL_NAME_TAGGED(type, tag)

#ifdef GRN_PLUGIN_FUNCTION_TAG
	# define GRN_PLUGIN_IMPL_NAME(type) GRN_PLUGIN_IMPL_NAME_TAGGED_EXPANDABLE(type, GRN_PLUGIN_FUNCTION_TAG)
#else
	# define GRN_PLUGIN_IMPL_NAME(type) GRN_PLUGIN_IMPL_NAME_RAW(type)
#endif

#define GRN_PLUGIN_INIT     GRN_PLUGIN_IMPL_NAME(init)
#define GRN_PLUGIN_REGISTER GRN_PLUGIN_IMPL_NAME(register)
#define GRN_PLUGIN_FIN      GRN_PLUGIN_IMPL_NAME(fin)

#if defined(_WIN32) || defined(_WIN64)
	#  define GRN_PLUGIN_EXPORT __declspec(dllexport)
#else
	#  define GRN_PLUGIN_EXPORT
#endif
+/

//GRN_PLUGIN_EXPORT
export groonga_d.groonga.grn_rc GRN_PLUGIN_INIT(groonga_d.groonga.grn_ctx* ctx);

//GRN_PLUGIN_EXPORT
export groonga_d.groonga.grn_rc GRN_PLUGIN_REGISTER(groonga_d.groonga.grn_ctx* ctx);

//GRN_PLUGIN_EXPORT
export groonga_d.groonga.grn_rc GRN_PLUGIN_FIN(groonga_d.groonga.grn_ctx* ctx);

/+
#define GRN_PLUGIN_DECLARE_FUNCTIONS(tag) extern groonga_d.groonga.grn_rc GRN_PLUGIN_IMPL_NAME_TAGGED(init, tag)(groonga_d.groonga.grn_ctx *ctx); extern groonga_d.groonga.grn_rc GRN_PLUGIN_IMPL_NAME_TAGGED(register, tag)(groonga_d.groonga.grn_ctx *ctx); extern groonga_d.groonga.grn_rc GRN_PLUGIN_IMPL_NAME_TAGGED(fin, tag)(groonga_d.groonga.grn_ctx *ctx)
+/

/*
  Don't call these functions directly. Use GRN_PLUGIN_MALLOC(),
  GRN_PLUGIN_CALLOC(), GRN_PLUGIN_REALLOC() and GRN_PLUGIN_FREE() instead.
 */

/+
//GRN_API
void* grn_plugin_malloc(groonga_d.groonga.grn_ctx* ctx, size_t size, const (char)* file, int line, const (char)* func) GRN_ATTRIBUTE_ALLOC_SIZE(2);

//GRN_API
void* grn_plugin_calloc(groonga_d.groonga.grn_ctx* ctx, size_t size, const (char)* file, int line, const (char)* func) GRN_ATTRIBUTE_ALLOC_SIZE(2);

//GRN_API
void* grn_plugin_realloc(groonga_d.groonga.grn_ctx* ctx, void* ptr_, size_t size, const (char)* file, int line, const (char)* func) GRN_ATTRIBUTE_ALLOC_SIZE(3);

//GRN_API
void grn_plugin_free(groonga_d.groonga.grn_ctx* ctx, void* ptr_, const (char)* file, int line, const (char)* func);
+/

/+
#define GRN_PLUGIN_MALLOC(ctx, size) grn_plugin_malloc((ctx), (size), __FILE__, __LINE__, __FUNCTION__)
#define GRN_PLUGIN_MALLOCN(ctx, type, n) ((type *)(grn_plugin_malloc((ctx), type.sizeof * (n), __FILE__, __LINE__, __FUNCTION__)))
#define GRN_PLUGIN_CALLOC(ctx, size) grn_plugin_calloc((ctx), (size), __FILE__, __LINE__, __FUNCTION__)
#define GRN_PLUGIN_REALLOC(ctx, ptr_, size) grn_plugin_realloc((ctx), (ptr_), (size), __FILE__, __LINE__, __FUNCTION__)
#define GRN_PLUGIN_FREE(ctx, ptr_) grn_plugin_free((ctx), (ptr_), __FILE__, __LINE__, __FUNCTION__)

#define GRN_PLUGIN_LOG(ctx, level, ...) groonga_d.groonga.GRN_LOG((ctx), (level), __VA_ARGS__)
+/

/*
  Don't call grn_plugin_set_error() directly. This function is used in
  GRN_PLUGIN_SET_ERROR().
 */

/+
//GRN_API
void grn_plugin_set_error(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_log_level level, groonga_d.groonga.grn_rc error_code, const (char)* file, int line, const (char)* func, const (char)* format, ...) GRN_ATTRIBUTE_PRINTF(7);
+/

//GRN_API
void grn_plugin_clear_error(groonga_d.groonga.grn_ctx* ctx);

/*
  Don't call these functions directly. grn_plugin_backtrace() and
  grn_plugin_logtrace() are used in GRN_PLUGIN_SET_ERROR().
 */

//GRN_API
void grn_plugin_backtrace(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
void grn_plugin_logtrace(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_log_level level);

/*
  Don't use GRN_PLUGIN_SET_ERROR() directly. This macro is used in
  GRN_PLUGIN_ERROR().
 */
/+
#define GRN_PLUGIN_SET_ERROR(ctx, level, error_code, ...) grn_plugin_set_error(ctx, level, error_code, __FILE__, __LINE__, __FUNCTION__, __VA_ARGS__);

#define GRN_PLUGIN_ERROR(ctx, error_code, ...) GRN_PLUGIN_SET_ERROR(ctx, groonga_d.groonga.grn_log_level.GRN_LOG_ERROR, error_code, __VA_ARGS__)

#define GRN_PLUGIN_CLEAR_ERROR(ctx) grn_plugin_clear_error((ctx));
+/

extern struct _grn_plugin_mutex;
alias grn_plugin_mutex = _grn_plugin_mutex;

//GRN_API
grn_plugin_mutex* grn_plugin_mutex_open(groonga_d.groonga.grn_ctx* ctx);

/*
  grn_plugin_mutex_create() is deprecated. Use grn_plugin_mutex_open()
  instead.
*/

//GRN_API
grn_plugin_mutex* grn_plugin_mutex_create(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
void grn_plugin_mutex_close(groonga_d.groonga.grn_ctx* ctx, grn_plugin_mutex* mutex);

/*
  grn_plugin_mutex_destroy() is deprecated. Use grn_plugin_mutex_close()
  instead.
*/

//GRN_API
void grn_plugin_mutex_destroy(groonga_d.groonga.grn_ctx* ctx, grn_plugin_mutex* mutex);

//GRN_API
void grn_plugin_mutex_lock(groonga_d.groonga.grn_ctx* ctx, grn_plugin_mutex* mutex);

//GRN_API
void grn_plugin_mutex_unlock(groonga_d.groonga.grn_ctx* ctx, grn_plugin_mutex* mutex);

//GRN_API
groonga_d.groonga.grn_obj* grn_plugin_proc_alloc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data, uint domain, ubyte flags);

//GRN_API
groonga_d.groonga.grn_obj* grn_plugin_proc_get_vars(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data);

//GRN_API
groonga_d.groonga.grn_obj* grn_plugin_proc_get_var(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data, const (char)* name, int name_size);

//GRN_API
ubyte grn_plugin_proc_get_var_bool(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data, const (char)* name, int name_size, ubyte default_value);

//GRN_API
int grn_plugin_proc_get_var_int32(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data, const (char)* name, int name_size, int default_value);

//GRN_API
const (char)* grn_plugin_proc_get_var_string(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data, const (char)* name, int name_size, size_t* size);

//GRN_API
groonga_d.groonga.grn_content_type grn_plugin_proc_get_var_content_type(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data, const (char)* name, int name_size, groonga_d.groonga.grn_content_type default_value);

//GRN_API
groonga_d.groonga.grn_obj* grn_plugin_proc_get_var_by_offset(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data, uint offset);

//GRN_API
groonga_d.groonga.grn_obj* grn_plugin_proc_get_caller(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data);

/* Deprecated since 5.0.9. Use grn_plugin_windows_base_dir() instead. */

//GRN_API
const (char)* grn_plugin_win32_base_dir();

//GRN_API
const (char)* grn_plugin_windows_base_dir();

//GRN_API
int grn_plugin_charlen(groonga_d.groonga.grn_ctx* ctx, const (char)* str_ptr, uint str_length, groonga_d.groonga.grn_encoding encoding);

//GRN_API
int grn_plugin_isspace(groonga_d.groonga.grn_ctx* ctx, const (char)* str_ptr, uint str_length, groonga_d.groonga.grn_encoding encoding);

//GRN_API
groonga_d.groonga.grn_rc grn_plugin_expr_var_init(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_expr_var* var, const (char)* name, int name_size);

//GRN_API
groonga_d.groonga.grn_obj* grn_plugin_command_create(groonga_d.groonga.grn_ctx* ctx, const (char)* name, int name_size, groonga_d.groonga.grn_proc_func func, uint n_vars, groonga_d.groonga.grn_expr_var* vars);

//GRN_API
bool grn_plugin_proc_get_value_bool(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* value, bool default_value, const (char)* tag);

//GRN_API
long grn_plugin_proc_get_value_int64(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* value, long default_value_raw, const (char)* tag);

//GRN_API
groonga_d.groonga.grn_operator grn_plugin_proc_get_value_mode(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* value, groonga_d.groonga.grn_operator default_mode, const (char)* tag);

//GRN_API
groonga_d.groonga.grn_operator grn_plugin_proc_get_value_operator(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* value, groonga_d.groonga.grn_operator default_oeprator, const (char)* tag);

