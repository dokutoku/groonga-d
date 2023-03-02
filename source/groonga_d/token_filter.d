/*
  Copyright(C) 2014-2016 Brazil
  Copyright(C) 2018 Kouhei Sutou <kou@clear-code.com>

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
module groonga.token_filter;


private static import groonga.groonga;
private static import groonga.token;
private static import groonga.tokenizer;
private static import groonga.tokenizer_query_deprecated;

extern(C):
nothrow @nogc:

/+
#include <groonga/tokenizer.h>
+/

/* Deprecated since 8.0.9. Use grn_token_filter_init_query_func instead. */
//typedef void* grn_token_filter_init_func(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, groonga.token.grn_tokenize_mode mode);
alias grn_token_filter_init_func = extern (C) nothrow @nogc void* function(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, groonga.token.grn_tokenize_mode mode);

//typedef void* grn_token_filter_init_query_func(groonga.groonga.grn_ctx* ctx, groonga.tokenizer.grn_tokenizer_query* query);
alias grn_token_filter_init_query_func = extern (C) nothrow @nogc void* function(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//typedef void grn_token_filter_filter_func(groonga.groonga.grn_ctx* ctx, groonga.token.grn_token* current_token, groonga.token.grn_token* next_token, void* user_data);
alias grn_token_filter_filter_func = extern (C) nothrow @nogc void function(groonga.groonga.grn_ctx* ctx, groonga.token.grn_token* current_token, groonga.token.grn_token* next_token, void* user_data);

//typedef void grn_token_filter_fin_func(groonga.groonga.grn_ctx* ctx, void* user_data);
alias grn_token_filter_fin_func = extern (C) nothrow @nogc void function(groonga.groonga.grn_ctx* ctx, void* user_data);

/*
  grn_token_filter_register() registers a plugin to the database which is
  associated with `ctx'. `plugin_name_ptr' and `plugin_name_length' specify the
  plugin name. Alphabetic letters ('A'-'Z' and 'a'-'z'), digits ('0'-'9') and
  an underscore ('_') are capable characters.

  `init', `filter' and `fin' specify the plugin functions.

  `init' is called for initializing a token_filter for a document or
  query.

  `filter' is called for filtering tokens one by one.

  `fin' is called for finalizing a token_filter.

  grn_token_filter_register() returns GRN_SUCCESS on success, an error
  code on failure.

  Deprecated since 8.0.9. Use grn_token_filter_create() and
  grn_token_filter_set_XXX_func() instead.
 */

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc grn_token_filter_register(groonga.groonga.grn_ctx* ctx, const (char)* plugin_name_ptr, int plugin_name_length, .grn_token_filter_init_func* init, .grn_token_filter_filter_func* filter, .grn_token_filter_fin_func* fin);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj*
grn_token_filter_create(groonga.groonga.grn_ctx* ctx, const (char)* name, int name_length);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc
grn_token_filter_set_init_func(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* token_filter, .grn_token_filter_init_query_func* init);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc
grn_token_filter_set_filter_func(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* token_filter, .grn_token_filter_filter_func* filter);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc
grn_token_filter_set_fin_func(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* token_filter, .grn_token_filter_fin_func* fin);
