/*
  Copyright(C) 2015-2018  Brazil
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
module groonga_d.obj;


private static import groonga_d.groonga;
private static import groonga_d.option;
private import groonga_d.groonga: GRN_API;
public import groonga_d.option;

extern(C):
nothrow @nogc:

/**
 * Just for backward compatibility. Use grn_obj_is_true() instead.
 */
pragma(inline, true)
void GRN_OBJ_IS_TRUE(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj, ref bool result)

	do
	{
		result = .grn_obj_is_true(ctx, obj);
	}

@GRN_API
bool grn_obj_is_true(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_temporary(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_builtin(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_bulk(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_text_family_bulk(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_number_family_bulk(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_vector(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_text_family_vector(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_weight_vector(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_uvector(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_weight_uvector(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_db(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_table(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_table_with_key(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_table_with_value(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_lexicon(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_lexicon_without_data_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_tiny_hash_table(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_patricia_trie(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_result_set(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_number_family_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_scalar_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_text_family_scalar_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_number_family_scalar_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_vector_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_text_family_vector_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_weight_vector_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_reference_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_data_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_index_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_id_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_key_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_value_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_score_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_referable_score_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_nsubrecs_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_max_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_min_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_sum_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_avg_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_mean_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_column_value_accessor(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_type(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_text_family_type(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_tokenizer_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_function_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_selector_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_selector_only_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_normalizer_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_token_filter_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_scorer_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_window_function_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_aggregator_proc(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_expr(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_visible(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_rc grn_obj_set_visibility(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj, bool is_visible);

@GRN_API
bool grn_obj_have_source(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
bool grn_obj_is_token_column(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_rc grn_obj_reindex(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
void grn_obj_touch(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj, groonga_d.groonga.grn_timeval* tv);

@GRN_API
uint grn_obj_get_last_modified(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_dirty(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
const (char)* grn_obj_set_flag_to_string(int flags);

@GRN_API
const (char)* grn_obj_type_to_string(ubyte type);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_name_is_column(groonga_d.groonga.grn_ctx* ctx, const (char)* name, int name_len);

@GRN_API
groonga_d.groonga.grn_bool grn_obj_is_corrupt(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
size_t grn_obj_get_disk_usage(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_rc grn_obj_set_option_values(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj, const (char)* name, int name_length, groonga_d.groonga.grn_obj* values);

@GRN_API
groonga_d.option.grn_option_revision grn_obj_get_option_values(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj, const (char)* name, int name_length, groonga_d.option.grn_option_revision revision, groonga_d.groonga.grn_obj* values);

@GRN_API
groonga_d.groonga.grn_rc grn_obj_clear_option_values(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

@GRN_API
groonga_d.groonga.grn_rc grn_obj_to_script_syntax(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj, groonga_d.groonga.grn_obj* buffer);

@GRN_API
groonga_d.groonga.grn_rc grn_obj_warm(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);
