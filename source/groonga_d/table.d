/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2009-2018  Brazil
  Copyright(C) 2018-2021  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.table;


private static import groonga_d.groonga;
private static import groonga_d.hash;
private static import groonga_d.posting;

extern(C):
nothrow @nogc:

enum GRN_TABLE_MAX_KEY_SIZE = 0x1000;

//GRN_API
groonga_d.groonga.grn_obj* grn_table_create(groonga_d.groonga.grn_ctx* ctx, const (char)* name, uint name_size, const (char)* path, uint flags, groonga_d.groonga.grn_obj* key_type, groonga_d.groonga.grn_obj* value_type);

/+
#define GRN_TABLE_OPEN_OR_CREATE(ctx, name, name_size, path, flags, key_type, value_type, table) (((table) = grn_ctx_get((ctx), (name), (name_size))) || ((table) = grn_table_create((ctx), (name), (name_size), (path), (flags), (key_type), (value_type))))
+/

/* TODO: int *added -> ubyte *added */

//GRN_API
uint grn_table_add(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (void)* key, uint key_size, int* added);

//GRN_API
uint grn_table_get(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (void)* key, uint key_size);

//GRN_API
uint grn_table_at(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint id);

//GRN_API
uint grn_table_lcp_search(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (void)* key, uint key_size);

//GRN_API
int grn_table_get_key(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint id, void* keybuf, int buf_size);

//GRN_API
groonga_d.groonga.grn_rc grn_table_delete(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (void)* key, uint key_size);

//GRN_API
groonga_d.groonga.grn_rc grn_table_delete_by_id(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint id);

//GRN_API
groonga_d.groonga.grn_rc grn_table_update_by_id(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint id, const (void)* dest_key, uint dest_key_size);

//GRN_API
groonga_d.groonga.grn_rc grn_table_update(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (void)* src_key, uint src_key_size, const (void)* dest_key, uint dest_key_size);

//GRN_API
groonga_d.groonga.grn_rc grn_table_truncate(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table);

enum GRN_CURSOR_ASCENDING = 0x00 << 0;
enum GRN_CURSOR_DESCENDING = 0x01 << 0;
enum GRN_CURSOR_GE = 0x00 << 1;
enum GRN_CURSOR_GT = 0x01 << 1;
enum GRN_CURSOR_LE = 0x00 << 2;
enum GRN_CURSOR_LT = 0x01 << 2;
enum GRN_CURSOR_BY_KEY = 0x00 << 3;
enum GRN_CURSOR_BY_ID = 0x01 << 3;
enum GRN_CURSOR_PREFIX = 0x01 << 4;
enum GRN_CURSOR_SIZE_BY_BIT = 0x01 << 5;
enum GRN_CURSOR_RK = 0x01 << 6;

//GRN_API
groonga_d.groonga.grn_table_cursor* grn_table_cursor_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (void)* min, uint min_size, const (void)* max, uint max_size, int offset, int limit, int flags);

//GRN_API
groonga_d.groonga.grn_rc grn_table_cursor_close(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc);

//GRN_API
uint grn_table_cursor_next(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc);

//GRN_API
int grn_table_cursor_get_key(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc, void** key);

//GRN_API
int grn_table_cursor_get_value(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc, void** value);

//GRN_API
uint grn_table_cursor_get_key_value(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc, void** key, uint* key_size, void** value);

//GRN_API
groonga_d.groonga.grn_rc grn_table_cursor_set_value(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc, const (void)* value, int flags);

//GRN_API
groonga_d.groonga.grn_rc grn_table_cursor_delete(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc);

//GRN_API
size_t grn_table_cursor_get_max_n_records(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* cursor);

//GRN_API
groonga_d.groonga.grn_obj* grn_table_cursor_table(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc);

//GRN_API
groonga_d.groonga.grn_obj* grn_index_cursor_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc, groonga_d.groonga.grn_obj* index, uint rid_min, uint rid_max, int flags);

//GRN_API
groonga_d.groonga.grn_obj* grn_index_cursor_get_index_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index_cursor);

//GRN_API
groonga_d.groonga.grn_rc grn_index_cursor_set_term_id(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index_cursor, uint term_id);

//GRN_API
groonga_d.groonga.grn_rc grn_index_cursor_set_section_id(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index_cursor, uint section_id);

//GRN_API
uint grn_index_cursor_get_section_id(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index_cursor);

//GRN_API
groonga_d.groonga.grn_rc grn_index_cursor_set_start_position(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index_cursor, uint position);

//GRN_API
groonga_d.groonga.grn_rc grn_index_cursor_reset_start_position(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index_cursor);

//GRN_API
uint grn_index_cursor_get_start_position(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index_cursor);

//GRN_API
groonga_d.posting.grn_posting* grn_index_cursor_next(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index_cursor, uint* term_id);

alias grn_table_cursor_foreach_func = extern (C) nothrow @nogc groonga_d.groonga.grn_rc function(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* cursor, uint id, void* user_data);

//GRN_API
groonga_d.groonga.grn_rc grn_table_cursor_foreach(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* cursor, grn_table_cursor_foreach_func func, void* user_data);

/+
#define GRN_TABLE_EACH(ctx, table, head, tail, id, key, key_size, value, block) (ctx)->errlvl = groonga_d.groonga.grn_log_level.GRN_LOG_NOTICE; (ctx)->rc = groonga_d.groonga.grn_rc.GRN_SUCCESS; if ((ctx)->seqno & 1) { (ctx)->subno++; } else { (ctx)->seqno++; } if (table) { switch ((table)->header.type) { case groonga_d.groonga.GRN_TABLE_PAT_KEY : GRN_PAT_EACH((ctx), (grn_pat *)(table), (id), (key), (key_size), (value), block); break; case groonga_d.groonga.GRN_TABLE_DAT_KEY : GRN_DAT_EACH((ctx), (grn_dat *)(table), (id), (key), (key_size), block); break; case groonga_d.groonga.GRN_TABLE_HASH_KEY : GRN_HASH_EACH((ctx), (groonga_d.hash.grn_hash *)(table), (id), (key), (key_size), (value), block); break; case groonga_d.groonga.GRN_TABLE_NO_KEY : GRN_ARRAY_EACH((ctx), (grn_array *)(table), (head), (tail), (id), (value), block); break; } } if ((ctx)->subno) { (ctx)->subno--; } else { (ctx)->seqno++; }

#define GRN_TABLE_EACH_BEGIN(ctx, table, cursor, id) do { if ((table)) { groonga_d.groonga.grn_table_cursor *cursor; cursor = grn_table_cursor_open((ctx), (table), NULL, 0, NULL, 0, 0, -1, GRN_CURSOR_ASCENDING); if (cursor) { uint id; while ((id = grn_table_cursor_next((ctx), cursor))) {

#define GRN_TABLE_EACH_BEGIN_FLAGS(ctx, table, cursor, id, flags) do { if ((table)) { groonga_d.groonga.grn_table_cursor *cursor; cursor = grn_table_cursor_open((ctx), (table), NULL, 0, NULL, 0, 0, -1, (flags)); if (cursor) { uint id; while ((id = grn_table_cursor_next((ctx), cursor))) {

#define GRN_TABLE_EACH_BEGIN_MIN(ctx, table, cursor, id, min, min_size, flags) do { if ((table)) { groonga_d.groonga.grn_table_cursor *cursor; cursor = grn_table_cursor_open((ctx), (table), (min), (min_size), NULL, 0, 0, -1, (flags)); if (cursor) { uint id; while ((id = grn_table_cursor_next((ctx), cursor))) {

#define GRN_TABLE_EACH_END(ctx, cursor) } grn_table_cursor_close((ctx), cursor); } } } while (0)
+/

	alias grn_table_sort_key = _grn_table_sort_key;
	alias grn_table_sort_flags = ubyte;

enum GRN_TABLE_SORT_ASC = 0x00 << 0;
enum GRN_TABLE_SORT_DESC = 0x01 << 0;

	struct _grn_table_sort_key
	{
		groonga_d.groonga.grn_obj* key;
		grn_table_sort_flags flags;
		int offset;
	}

	//GRN_API
	int grn_table_sort(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, int offset, int limit, groonga_d.groonga.grn_obj* result, grn_table_sort_key* keys, int n_keys);

	alias grn_table_group_result = _grn_table_group_result;
	alias grn_table_group_flags = uint;

enum GRN_TABLE_GROUP_CALC_COUNT = 0x01 << 3;
enum GRN_TABLE_GROUP_CALC_MAX = 0x01 << 4;
enum GRN_TABLE_GROUP_CALC_MIN = 0x01 << 5;
enum GRN_TABLE_GROUP_CALC_SUM = 0x01 << 6;
	/* Deprecated since 10.0.4. Use GRN_TABLE_GROUP_CALC_MEAN instead. */
enum GRN_TABLE_GROUP_CALC_AVG = GRN_TABLE_GROUP_CALC_MEAN;
enum GRN_TABLE_GROUP_CALC_MEAN = 0x01 << 7;
enum GRN_TABLE_GROUP_CALC_AGGREGATOR = 0x01 << 8;

	struct _grn_table_group_aggregator;
	alias grn_table_group_aggregator = _grn_table_group_aggregator;

	//GRN_API
	grn_table_group_aggregator* grn_table_group_aggregator_open(groonga_d.groonga.grn_ctx* ctx);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_group_aggregator_close(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_group_aggregator_set_output_column_name(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator, const (char)* name, int name_len);

	//GRN_API
	const (char)* grn_table_group_aggregator_get_output_column_name(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator, uint* len);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_group_aggregator_set_output_column_type(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator, groonga_d.groonga.grn_obj* type);

	//GRN_API
	groonga_d.groonga.grn_obj* grn_table_group_aggregator_get_output_column_type(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_group_aggregator_set_output_column_flags(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator, groonga_d.groonga.grn_column_flags flags);

	//GRN_API
	groonga_d.groonga.grn_column_flags grn_table_group_aggregator_get_output_column_flags(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_group_aggregator_set_expression(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator, const (char)* expression, int expression_len);

	//GRN_API
	const (char)* grn_table_group_aggregator_get_expression(groonga_d.groonga.grn_ctx* ctx, grn_table_group_aggregator* aggregator, uint* expression_len);

	struct _grn_table_group_result
	{
		groonga_d.groonga.grn_obj* table;
		ubyte key_begin;
		ubyte key_end;
		int limit;
		grn_table_group_flags flags;
		groonga_d.groonga.grn_operator op;
		uint max_n_subrecs;
		groonga_d.groonga.grn_obj* calc_target;
		grn_table_group_aggregator** aggregators;
		uint n_aggregators;
	}

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_group(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, grn_table_sort_key* keys, int n_keys, grn_table_group_result* results, int n_results);

	//GRN_API
	grn_table_sort_key* grn_table_group_keys_parse(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* raw_sort_keys, int raw_sort_keys_size, int* n_keys);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_setoperation(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table1, groonga_d.groonga.grn_obj* table2, groonga_d.groonga.grn_obj* res, groonga_d.groonga.grn_operator op);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_difference(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table1, groonga_d.groonga.grn_obj* table2, groonga_d.groonga.grn_obj* res1, groonga_d.groonga.grn_obj* res2);

	//GRN_API
	int grn_table_columns(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* name, uint name_size, groonga_d.groonga.grn_obj* res);

	//GRN_API
	uint grn_table_size(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_rename(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* name, uint name_size);

	//GRN_API
	groonga_d.groonga.grn_obj* grn_table_select(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* result_set, groonga_d.groonga.grn_operator op);

	//GRN_API
	grn_table_sort_key* grn_table_sort_key_from_str(groonga_d.groonga.grn_ctx* ctx, const (char)* str, uint str_size, groonga_d.groonga.grn_obj* table, uint* nkeys);

	//GRN_API
	grn_table_sort_key* grn_table_sort_keys_parse(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* raw_sort_keys, int raw_sort_keys_size, int* n_keys);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_sort_key_close(groonga_d.groonga.grn_ctx* ctx, grn_table_sort_key* keys, uint nkeys);

	//GRN_API
	ubyte grn_table_is_grouped(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table);

	//GRN_API
	uint grn_table_max_n_subrecs(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table);

	//GRN_API
	groonga_d.groonga.grn_obj* grn_table_create_for_group(groonga_d.groonga.grn_ctx* ctx, const (char)* name, uint name_size, const (char)* path, groonga_d.groonga.grn_obj* group_key, groonga_d.groonga.grn_obj* value_type, uint max_n_subrecs);

	//GRN_API
	uint grn_table_get_subrecs(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint id, uint* subrecbuf, int* scorebuf, int buf_size);

	//GRN_API
	groonga_d.groonga.grn_obj* grn_table_tokenize(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* str, uint str_len, groonga_d.groonga.grn_obj* buf, ubyte addp);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_apply_expr(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output_column, groonga_d.groonga.grn_obj* expr);

	//GRN_API
	uint grn_table_find_reference_object(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_copy(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* from, groonga_d.groonga.grn_obj* to);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_get_duplicated_keys(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj** duplicated_keys);

	//GRN_API
	bool grn_table_have_duplicated_keys(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table);

	extern struct _grn_table_selector;
	alias grn_table_selector = _grn_table_selector;

	//GRN_API
	grn_table_selector* grn_table_selector_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_operator op);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_selector_close(groonga_d.groonga.grn_ctx* ctx, grn_table_selector* table_selector);

	//GRN_API
	groonga_d.groonga.grn_id grn_table_selector_get_min_id(groonga_d.groonga.grn_ctx* ctx, grn_table_selector* table_selector);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_selector_set_min_id(groonga_d.groonga.grn_ctx* ctx, grn_table_selector* table_selector, groonga_d.groonga.grn_id min_id);

	//GRN_API
	bool grn_table_selector_get_use_sequential_scan(groonga_d.groonga.grn_ctx* ctx, grn_table_selector* table_selector);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_selector_set_use_sequential_scan(groonga_d.groonga.grn_ctx* ctx, grn_table_selector* table_selector, bool use);

	//GRN_API
	groonga_d.groonga.grn_obj* grn_table_selector_select(groonga_d.groonga.grn_ctx* ctx, grn_table_selector* table_selector, groonga_d.groonga.grn_obj* result_set);
