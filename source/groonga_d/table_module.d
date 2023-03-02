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
module groonga_d.table_module;


private static import groonga_d.groonga;
private import groonga_d.groonga: GRN_API;

extern(C):
nothrow @nogc:

alias grn_table_module_open_options_func = void* function(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* proc, groonga_d.groonga.grn_obj* values, void* user_data);
/* Deprecated since 8.0.9. Use grn_table_module_option_options_func instead. */
alias grn_tokenizer_open_options_func = .grn_table_module_open_options_func;

@GRN_API
groonga_d.groonga.grn_rc grn_table_set_default_tokenizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* options);

@GRN_API
groonga_d.groonga.grn_rc grn_table_get_default_tokenizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* options);

@GRN_API
void* grn_table_cache_default_tokenizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, .grn_table_module_open_options_func open_options_func, groonga_d.groonga.grn_close_func close_options_func, void* user_data);

@GRN_API
groonga_d.groonga.grn_rc grn_table_get_default_tokenizer_string(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output);

/* Deprecated since 8.0.9. Use grn_table_module_open_options_func instead. */
alias grn_normalizer_open_options_func = .grn_table_module_open_options_func;

@GRN_API
groonga_d.groonga.grn_rc grn_table_set_normalizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* options);

@GRN_API
groonga_d.groonga.grn_rc grn_table_get_normalizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* options);

/* TODO: Remove string argument. It's needless. */
@GRN_API
void* grn_table_cache_normalizer_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* string_, .grn_table_module_open_options_func open_options_func, groonga_d.groonga.grn_close_func close_options_func, void* user_data);

@GRN_API
groonga_d.groonga.grn_rc grn_table_get_normalizer_string(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output);

@GRN_API
groonga_d.groonga.grn_rc grn_table_set_normalizers_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, groonga_d.groonga.grn_obj* options);

@GRN_API
groonga_d.groonga.grn_rc grn_table_get_normalizers_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, groonga_d.groonga.grn_obj* options);

@GRN_API
void* grn_table_cache_normalizers_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, .grn_table_module_open_options_func open_options_func, groonga_d.groonga.grn_close_func close_options_func, void* user_data);

@GRN_API
groonga_d.groonga.grn_rc grn_table_get_normalizers_string(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output);

/* Deprecated since 11.0.4. Use grn_table_set_token_filters_options() instead. */
@GRN_API
deprecated
groonga_d.groonga.grn_rc grn_table_set_token_filter_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, groonga_d.groonga.grn_obj* options);

@GRN_API
groonga_d.groonga.grn_rc grn_table_set_token_filters_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, groonga_d.groonga.grn_obj* options);

/* Deprecated since 11.0.4. Use grn_table_get_token_filters_options() instead. */
@GRN_API
deprecated
groonga_d.groonga.grn_rc grn_table_get_token_filter_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, groonga_d.groonga.grn_obj* options);

@GRN_API
groonga_d.groonga.grn_rc grn_table_get_token_filters_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, groonga_d.groonga.grn_obj* options);

/* Deprecated since 11.0.4. Use grn_table_cache_token_filters_options() instead. */
@GRN_API
deprecated
void* grn_table_cache_token_filter_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, .grn_table_module_open_options_func open_options_func, groonga_d.groonga.grn_close_func close_options_func, void* user_data);

@GRN_API
void* grn_table_cache_token_filters_options(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, uint i, .grn_table_module_open_options_func open_options_func, groonga_d.groonga.grn_close_func close_options_func, void* user_data);

@GRN_API
groonga_d.groonga.grn_rc grn_table_get_token_filters_string(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output);
