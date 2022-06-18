/*
  Copyright(C) 2009-2017  Brazil
  Copyright(C) 2019-2021  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.expr;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

alias grn_expr_flags = uint;

enum GRN_EXPR_SYNTAX_QUERY = 0x00;
enum GRN_EXPR_SYNTAX_SCRIPT = 0x01;
enum GRN_EXPR_SYNTAX_OUTPUT_COLUMNS = 0x20;
enum GRN_EXPR_SYNTAX_ADJUSTER = 0x40;
enum GRN_EXPR_SYNTAX_SORT_KEYS = 0x100;
/* Deprecated since Groonga 11.0.2. Use GRN_EXPR_SYNTAX_SORT_KEYS instead. */
enum GRN_EXPR_SYNTAX_GROUP_KEYS = .GRN_EXPR_SYNTAX_SORT_KEYS;
enum GRN_EXPR_SYNTAX_OPTIONS = 0x200;
enum GRN_EXPR_ALLOW_PRAGMA = 0x02;
enum GRN_EXPR_ALLOW_COLUMN = 0x04;
enum GRN_EXPR_ALLOW_UPDATE = 0x08;
enum GRN_EXPR_ALLOW_LEADING_NOT = 0x10;
enum GRN_EXPR_QUERY_NO_SYNTAX_ERROR = 0x80;
enum GRN_EXPR_DISABLE_PREFIX_SEARCH = 0x0400;
enum GRN_EXPR_DISABLE_AND_NOT = 0x0800;

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_create(groonga_d.groonga.grn_ctx* ctx, const (char)* name, uint name_size);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_close(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_add_var(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, const (char)* name, uint name_size);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_get_var(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, const (char)* name, uint name_size);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_get_var_by_offset(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, uint offset);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_clear_vars(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr);

//GRN_API
void grn_expr_take_obj(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* obj);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_append_obj(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* obj, groonga_d.groonga.grn_operator op, int nargs);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_append_const(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* obj, groonga_d.groonga.grn_operator op, int nargs);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_append_const_str(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, const (char)* str, uint str_size, groonga_d.groonga.grn_operator op, int nargs);

/* Deprecated since Groonga 11.0.1. Use grn_expr_append_const_int32() instead. */
//GRN_API
deprecated
groonga_d.groonga.grn_obj* grn_expr_append_const_int(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, int value, groonga_d.groonga.grn_operator op, int nargs);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_append_const_int32(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, int value, groonga_d.groonga.grn_operator op, int nargs);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_append_const_float32(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, float value, groonga_d.groonga.grn_operator op, int nargs);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_append_const_float(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, double value, groonga_d.groonga.grn_operator op, int nargs);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_append_const_bool(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_bool value, groonga_d.groonga.grn_operator op, int nargs);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_append_op(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_operator op, int nargs);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_get_keywords(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* keywords);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_syntax_escape(groonga_d.groonga.grn_ctx* ctx, const (char)* query, int query_size, const (char)* target_characters, char escape_character, groonga_d.groonga.grn_obj* escaped_query);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_syntax_escape_query(groonga_d.groonga.grn_ctx* ctx, const (char)* query, int query_size, groonga_d.groonga.grn_obj* escaped_query);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_syntax_expand_query(groonga_d.groonga.grn_ctx* ctx, const (char)* query, int query_size, grn_expr_flags flags, groonga_d.groonga.grn_obj* expander, groonga_d.groonga.grn_obj* expanded_query);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_syntax_expand_query_by_table(groonga_d.groonga.grn_ctx* ctx, const (char)* query, int query_size, grn_expr_flags flags, groonga_d.groonga.grn_obj* term_column, groonga_d.groonga.grn_obj* expanded_term_column, groonga_d.groonga.grn_obj* expanded_query);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_compile(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_rewrite(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_dump_plan(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* buffer);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_exec(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, int nargs);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_alloc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_id domain, ubyte flags);

pragma(inline, true)
void GRN_EXPR_CREATE_FOR_QUERY(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, ref groonga_d.groonga.grn_obj* expr, ref groonga_d.groonga.grn_obj* var)

	do
	{
		if ((((expr = .grn_expr_create(ctx, null, 0)) != null)) && ((var = .grn_expr_add_var(ctx, expr, null, 0)) != null)) {
			groonga_d.groonga.GRN_RECORD_INIT(var, 0, groonga_d.groonga.grn_obj_id(ctx, table));
		} else {
			var = null;
		}
	}

//GRN_API
groonga_d.groonga.grn_rc grn_expr_parse(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, const (char)* str, uint str_size, groonga_d.groonga.grn_obj* default_column, groonga_d.groonga.grn_operator default_mode, groonga_d.groonga.grn_operator default_op, grn_expr_flags flags);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_snip(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, int flags, uint width, uint max_results, uint n_tags, const (char)** opentags, uint* opentag_lens, const (char)** closetags, uint* closetag_lens, groonga_d.groonga.grn_snip_mapping* mapping);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_snip_add_conditions(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* snip, uint n_tags, const (char)** opentags, uint* opentag_lens, const (char)** closetags, uint* closetag_lens);

//GRN_API
uint grn_expr_estimate_size(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr);


//GRN_API
groonga_d.groonga.grn_rc grn_expr_set_query_log_tag_prefix(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, const (char)* prefix, int prefix_len);

//GRN_API
const (char)* grn_expr_get_query_log_tag_prefix(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_set_parent(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* parent);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_get_parent(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr);

//GRN_API
groonga_d.groonga.grn_rc grn_expr_set_condition(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* condition);

//GRN_API
groonga_d.groonga.grn_obj* grn_expr_get_condition(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* expr);

