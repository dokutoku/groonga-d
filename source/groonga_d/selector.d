/*
  Copyright(C) 2009-2018  Brazil
  Copyright(C) 2020-2021  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.selector;


private static import groonga_d.groonga;
private static import groonga_d.proc;

extern(C):
nothrow @nogc:

alias grn_selector_func = groonga_d.groonga.grn_rc function(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* index, int nargs, groonga_d.groonga.grn_obj** args, groonga_d.groonga.grn_obj* res, groonga_d.groonga.grn_operator op);

//GRN_API
groonga_d.groonga.grn_rc grn_proc_set_selector(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* proc, .grn_selector_func selector);

//GRN_API
groonga_d.groonga.grn_rc grn_proc_set_selector_operator(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* proc, groonga_d.groonga.grn_operator selector_op);

//GRN_API
groonga_d.groonga.grn_operator grn_proc_get_selector_operator(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* proc);

struct _grn_selector_data;
alias grn_selector_data = ._grn_selector_data;

//GRN_API
.grn_selector_data* grn_selector_data_get(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
groonga_d.groonga.grn_obj* grn_selector_data_get_selector(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
groonga_d.groonga.grn_obj* grn_selector_data_get_expr(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
groonga_d.groonga.grn_obj* grn_selector_data_get_table(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
groonga_d.groonga.grn_obj* grn_selector_data_get_index(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
groonga_d.groonga.grn_obj** grn_selector_data_get_args(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data, size_t* n_args);

//GRN_API
float grn_selector_data_get_weight_factor(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
groonga_d.groonga.grn_obj* grn_selector_data_get_result_set(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
groonga_d.groonga.grn_operator grn_selector_data_get_op(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
groonga_d.groonga.grn_rc grn_selector_data_parse_score_column_option_value(groonga_d.groonga.grn_ctx* ctx, const (char)* name, groonga_d.groonga.grn_obj* value, const (char)* tag, void* data);

//GRN_API
groonga_d.groonga.grn_rc grn_selector_data_parse_tags_option_value(groonga_d.groonga.grn_ctx* ctx, const (char)* name, groonga_d.groonga.grn_obj* value, const (char)* tag, void* data);

//GRN_API
groonga_d.groonga.grn_rc grn_selector_data_parse_tags_column_option_value(groonga_d.groonga.grn_ctx* ctx, const (char)* name, groonga_d.groonga.grn_obj* value, const (char)* tag, void* data);

pragma(inline, true)
groonga_d.groonga.grn_rc grn_selector_data_parse_options(DATA, A ...)(groonga_d.groonga.grn_ctx* ctx, DATA data, groonga_d.groonga.grn_obj* options, const (char)* tag, A a)

	do
	{
		static if (a.length != 0) {
			return groonga_d.proc.grn_proc_options_parse(ctx, options, tag, &("score_column\0"[0]), groonga_d.proc.grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_FUNC, &.grn_selector_data_parse_score_column_option_value, data, &("tags\0"[0]), groonga_d.proc.grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_FUNC, &.grn_selector_data_parse_tags_option_value, data, &("tags_column\0"[0]), groonga_d.proc.grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_FUNC, &.grn_selector_data_parse_tags_column_option_value, data, a[0 .. $]);
		} else {
			return groonga_d.proc.grn_proc_options_parse(ctx, options, tag, &("score_column\0"[0]), groonga_d.proc.grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_FUNC, &.grn_selector_data_parse_score_column_option_value, data, &("tags\0"[0]), groonga_d.proc.grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_FUNC, &.grn_selector_data_parse_tags_option_value, data, &("tags_column\0"[0]), groonga_d.proc.grn_proc_option_value_type.GRN_PROC_OPTION_VALUE_FUNC, &.grn_selector_data_parse_tags_column_option_value, data);
		}
	}

//GRN_API
bool grn_selector_data_have_score_column(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
bool grn_selector_data_have_tags_column(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data);

//GRN_API
groonga_d.groonga.grn_rc grn_selector_data_on_token_found(groonga_d.groonga.grn_ctx* ctx, .grn_selector_data* data, groonga_d.groonga.grn_obj* index, groonga_d.groonga.grn_id token_id, double additional_score);
