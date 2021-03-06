/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2009-2018  Brazil
  Copyright(C) 2020  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.proc;


private static import core.stdc.stdarg;
private static import groonga_d.groonga;

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

//GRN_API
groonga_d.groonga.grn_obj* grn_proc_create(groonga_d.groonga.grn_ctx* ctx, const (char)* name, int name_size, grn_proc_type type, groonga_d.groonga.grn_proc_func* init, groonga_d.groonga.grn_proc_func* next, groonga_d.groonga.grn_proc_func* fin, uint nvars, groonga_d.groonga.grn_expr_var* vars);

//GRN_API
groonga_d.groonga.grn_obj* grn_proc_get_info(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_user_data* user_data, groonga_d.groonga.grn_expr_var** vars, uint* nvars, groonga_d.groonga.grn_obj** caller);

//GRN_API
grn_proc_type grn_proc_get_type(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* proc);

alias grn_proc_option_value_parse_func = groonga_d.groonga.grn_rc function(groonga_d.groonga.grn_ctx* ctx, const (char)* name, groonga_d.groonga.grn_obj* value, const (char)* tag, void* user_data);

enum grn_proc_option_value_type
{
	GRN_PROC_OPTION_VALUE_RAW,
	GRN_PROC_OPTION_VALUE_MODE,
	GRN_PROC_OPTION_VALUE_OPERATOR,
	GRN_PROC_OPTION_VALUE_EXPR_FLAGS,
	GRN_PROC_OPTION_VALUE_INT64,
	GRN_PROC_OPTION_VALUE_BOOL,
	GRN_PROC_OPTION_VALUE_FUNC,
	GRN_PROC_OPTION_VALUE_TOKENIZE_MODE,
	GRN_PROC_OPTION_VALUE_TOKEN_CURSOR_FLAGS,
}

/+
//GRN_API
groonga_d.groonga.grn_rc grn_proc_options_parse(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* options, const (char)* tag, const (char)* name, ...);
+/

//GRN_API
groonga_d.groonga.grn_rc grn_proc_options_parsev(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* options, const (char)* tag, const (char)* name, core.stdc.stdarg.va_list args);
