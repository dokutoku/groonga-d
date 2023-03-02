/*
  Copyright(C) 2009-2018  Brazil
  Copyright(C) 2020-2022  Sutou Kouhei <kou@clear-code.com>

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
module groonga.proc;


private static import core.stdc.stdarg;
private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

enum grn_proc_type
{
	GRN_PROC_INVALID = 0,
	GRN_PROC_TOKENIZER,
	GRN_PROC_COMMAND,
	GRN_PROC_FUNCTION,
	GRN_PROC_HOOK,
	GRN_PROC_NORMALIZER,
	GRN_PROC_TOKEN_FILTER,
	GRN_PROC_SCORER,
	GRN_PROC_WINDOW_FUNCTION,
	GRN_PROC_AGGREGATOR,
}

//Declaration name in C language
enum
{
	GRN_PROC_INVALID = .grn_proc_type.GRN_PROC_INVALID,
	GRN_PROC_TOKENIZER = .grn_proc_type.GRN_PROC_TOKENIZER,
	GRN_PROC_COMMAND = .grn_proc_type.GRN_PROC_COMMAND,
	GRN_PROC_FUNCTION = .grn_proc_type.GRN_PROC_FUNCTION,
	GRN_PROC_HOOK = .grn_proc_type.GRN_PROC_HOOK,
	GRN_PROC_NORMALIZER = .grn_proc_type.GRN_PROC_NORMALIZER,
	GRN_PROC_TOKEN_FILTER = .grn_proc_type.GRN_PROC_TOKEN_FILTER,
	GRN_PROC_SCORER = .grn_proc_type.GRN_PROC_SCORER,
	GRN_PROC_WINDOW_FUNCTION = .grn_proc_type.GRN_PROC_WINDOW_FUNCTION,
	GRN_PROC_AGGREGATOR = .grn_proc_type.GRN_PROC_AGGREGATOR,
}

@GRN_API
groonga.groonga.grn_obj* grn_proc_create(groonga.groonga.grn_ctx* ctx, const (char)* name, int name_size, .grn_proc_type type, groonga.groonga.grn_proc_func init, groonga.groonga.grn_proc_func next, groonga.groonga.grn_proc_func fin, uint nvars, groonga.groonga.grn_expr_var* vars);

@GRN_API
groonga.groonga.grn_obj* grn_proc_get_info(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data, groonga.groonga.grn_expr_var** vars, uint* nvars, groonga.groonga.grn_obj** caller);

@GRN_API
.grn_proc_type grn_proc_get_type(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* proc);

alias grn_proc_option_value_parse_func = groonga.groonga.grn_rc function(groonga.groonga.grn_ctx* ctx, const (char)* name, groonga.groonga.grn_obj* value, const (char)* tag, void* user_data);

enum grn_proc_option_value_type
{
	GRN_PROC_OPTION_VALUE_RAW,
	GRN_PROC_OPTION_VALUE_MODE,
	GRN_PROC_OPTION_VALUE_OPERATOR,
	GRN_PROC_OPTION_VALUE_EXPR_FLAGS,
	GRN_PROC_OPTION_VALUE_INT32,
	GRN_PROC_OPTION_VALUE_UINT32,
	GRN_PROC_OPTION_VALUE_INT64,
	GRN_PROC_OPTION_VALUE_BOOL,
	GRN_PROC_OPTION_VALUE_FUNC,
	GRN_PROC_OPTION_VALUE_TOKENIZE_MODE,
	GRN_PROC_OPTION_VALUE_TOKEN_CURSOR_FLAGS,
	GRN_PROC_OPTION_VALUE_DOUBLE,
}

//Declaration name in C language
enum
{
	GRN_PROC_OPTION_VALUE_RAW = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_RAW,
	GRN_PROC_OPTION_VALUE_MODE = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_MODE,
	GRN_PROC_OPTION_VALUE_OPERATOR = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_OPERATOR,
	GRN_PROC_OPTION_VALUE_EXPR_FLAGS = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_EXPR_FLAGS,
	GRN_PROC_OPTION_VALUE_INT32 = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_INT32,
	GRN_PROC_OPTION_VALUE_UINT32 = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_UINT32,
	GRN_PROC_OPTION_VALUE_INT64 = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_INT64,
	GRN_PROC_OPTION_VALUE_BOOL = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_BOOL,
	GRN_PROC_OPTION_VALUE_FUNC = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_FUNC,
	GRN_PROC_OPTION_VALUE_TOKENIZE_MODE = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_TOKENIZE_MODE,
	GRN_PROC_OPTION_VALUE_TOKEN_CURSOR_FLAGS = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_TOKEN_CURSOR_FLAGS,
	GRN_PROC_OPTION_VALUE_DOUBLE = .grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_DOUBLE,
}

@GRN_API
groonga.groonga.grn_rc grn_proc_prefixed_options_parse(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* options, const (char)* prefix, const (char)* tag, const (char)* name, ...);

@GRN_API
groonga.groonga.grn_rc grn_proc_prefixed_options_parsev(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* options, const (char)* prefix, const (char)* tag, const (char)* name, core.stdc.stdarg.va_list args);

@GRN_API
groonga.groonga.grn_rc grn_proc_options_parse(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* options, const (char)* tag, const (char)* name, ...);

@GRN_API
groonga.groonga.grn_rc grn_proc_options_parsev(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* options, const (char)* tag, const (char)* name, core.stdc.stdarg.va_list args);

@GRN_API
groonga.groonga.grn_rc grn_proc_func_generate_cache_key(groonga.groonga.grn_ctx* ctx, const (char)* function_name, groonga.groonga.grn_obj** args, int n_args, groonga.groonga.grn_obj* cache_key);
