/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2009-2018 Brazil
  Copyright(C) 2018 Kouhei Sutou <kou@clear-code.com>

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
groonga_d.groonga.grn_rc grn_table_cursor_set_value(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc, const (void)* value, int flags);

//GRN_API
groonga_d.groonga.grn_rc grn_table_cursor_delete(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc);

//GRN_API
groonga_d.groonga.grn_obj* grn_table_cursor_table(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc);

//GRN_API
groonga_d.groonga.grn_obj* grn_index_cursor_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_cursor* tc, groonga_d.groonga.grn_obj* index, uint rid_min, uint rid_max, int flags);

//GRN_API
groonga_d.groonga.grn_posting* grn_index_cursor_next(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* ic, uint* tid);

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
enum GRN_TABLE_GROUP_CALC_AVG = 0x01 << 7;

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
	}

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_group(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, grn_table_sort_key* keys, int n_keys, grn_table_group_result* results, int n_results);

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
	groonga_d.groonga.grn_obj* grn_table_select(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* expr, groonga_d.groonga.grn_obj* res, groonga_d.groonga.grn_operator op);

	//GRN_API
	grn_table_sort_key* grn_table_sort_key_from_str(groonga_d.groonga.grn_ctx* ctx, const (char)* str, uint str_size, groonga_d.groonga.grn_obj* table, uint* nkeys);

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

	alias grn_table_module_open_options_func = extern (C) nothrow @nogc void* function (groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* proc, groonga_d.groonga.grn_obj* values, void* user_data);
	/* Deprecated since 8.0.9. Use grn_table_module_option_options_func instead. */
	alias grn_tokenizer_open_options_func = grn_table_module_open_options_func;

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_set_default_tokenizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* options);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_get_default_tokenizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* options);

	//GRN_API
	void* grn_table_cache_default_tokenizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, grn_table_module_open_options_func open_options_func, groonga_d.groonga.grn_close_func close_options_func, void* user_data);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_get_default_tokenizer_string(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output);

	/* Deprecated since 8.0.9. Use grn_table_module_open_options_func instead. */
	alias grn_normalizer_open_options_func = grn_table_module_open_options_func;

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_set_normalizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* options);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_get_normalizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* options);

	/* TODO: Remove string argument. It's needless. */
	//GRN_API
	void* grn_table_cache_normalizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* string, grn_table_module_open_options_func open_options_func, groonga_d.groonga.grn_close_func close_options_func, void* user_data);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_get_normalizer_string(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_set_token_filter_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, groonga_d.groonga.grn_obj* options);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_get_token_filter_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, groonga_d.groonga.grn_obj* options);

	//GRN_API
	void* grn_table_cache_token_filter_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, grn_table_module_open_options_func open_options_func, groonga_d.groonga.grn_close_func close_options_func, void* user_data);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_get_token_filters_string(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output);

	//GRN_API
	groonga_d.groonga.grn_rc grn_table_copy(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* from, groonga_d.groonga.grn_obj* to);
