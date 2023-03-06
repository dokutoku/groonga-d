/*
  Copyright(C) 2012-2018  Brazil
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
module groonga.tokenizer;


private static import groonga.groonga;
private static import groonga.token;
private static import groonga.tokenizer_query_deprecated;

extern(C):
nothrow @nogc:

/+
#include <groonga/plugin.h>
#include <groonga/tokenizer_query_deprecated.h>
+/

enum GRN_TOKENIZER_TOKENIZED_DELIMITER_UTF8 = "\xEF\xBF\xBE";
enum GRN_TOKENIZER_TOKENIZED_DELIMITER_UTF8_LEN = 3;

enum GRN_TOKENIZER_BEGIN_MARK_UTF8 = "\xEF\xBF\xAF";
enum GRN_TOKENIZER_BEGIN_MARK_UTF8_LEN = 3;
enum GRN_TOKENIZER_END_MARK_UTF8 = "\xEF\xBF\xB0";
enum GRN_TOKENIZER_END_MARK_UTF8_LEN = 3;

/*
  grn_tokenizer_charlen() returns the length (#bytes) of the first character
  in the string specified by `str_ptr' and `str_length'. If the starting bytes
  are invalid as a character, grn_tokenizer_charlen() returns 0. See
  groonga.groonga.grn_encoding in "groonga.h" for more details of `encoding'

  Deprecated. Use grn_plugin_charlen() instead.
 */
int grn_tokenizer_charlen(groonga.groonga.grn_ctx* ctx, const (char)* str_ptr, uint str_length, groonga.groonga.grn_encoding encoding);

/*
  grn_tokenizer_isspace() returns the length (#bytes) of the first character
  in the string specified by `str_ptr' and `str_length' if it is a space
  character. Otherwise, grn_tokenizer_isspace() returns 0.

  Deprecated. Use grn_plugin_isspace() instead.
 */
int grn_tokenizer_isspace(groonga.groonga.grn_ctx* ctx, const (char)* str_ptr, uint str_length, groonga.groonga.grn_encoding encoding);

/*
  grn_tokenizer_is_tokenized_delimiter() returns whether is the first
  character in the string specified by `str_ptr' and `str_length' the
  special tokenized delimiter character or not.
 */
groonga.groonga.grn_bool grn_tokenizer_is_tokenized_delimiter(groonga.groonga.grn_ctx* ctx, const (char)* str_ptr, uint str_length, groonga.groonga.grn_encoding encoding);

/*
  grn_tokenizer_have_tokenized_delimiter() returns whether is there
  the special delimiter character in the string specified by `str_ptr'
  and `str_length' the special tokenized delimiter character or not.
 */

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_bool grn_tokenizer_have_tokenized_delimiter(groonga.groonga.grn_ctx* ctx, const (char)* str_ptr, uint str_length, groonga.groonga.grn_encoding encoding);

/*
  grn_tokenizer_query_open() parses `args' and returns a new object of
  grn_tokenizer_query. The new object stores information of the query.
  grn_tokenizer_query_open() normalizes the query if the target table
  requires normalization. grn_tokenizer_query_open() returns NULL if
  something goes wrong. Note that grn_tokenizer_query_open() must be called
  just once in the function that initializes a tokenizer.

  See `GRN_STRING_*' flags for `normalize_flags'.
 */

//GRN_PLUGIN_EXPORT
export groonga.tokenizer_query_deprecated.grn_tokenizer_query* grn_tokenizer_query_open(groonga.groonga.grn_ctx* ctx, int num_args, groonga.groonga.grn_obj** args, uint normalize_flags);

/*
  grn_tokenizer_query_create() is deprecated. Use grn_tokenizer_query_open()
  instead.
*/

groonga.tokenizer_query_deprecated.grn_tokenizer_query* grn_tokenizer_query_create(groonga.groonga.grn_ctx* ctx, int num_args, groonga.groonga.grn_obj** args);

/*
  grn_tokenizer_query_close() finalizes an object of grn_tokenizer_query
  and then frees memory allocated for that object.
 */

//GRN_PLUGIN_EXPORT
export void grn_tokenizer_query_close(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

/*
  grn_tokenizer_query_destroy() is deprecated. Use grn_tokenizer_query_close()
  instead.
 */
void grn_tokenizer_query_destroy(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc
grn_tokenizer_query_set_normalize_flags(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query, uint flags);

//GRN_PLUGIN_EXPORT
export uint
grn_tokenizer_query_get_normalize_flags(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj*
grn_tokenizer_query_get_normalized_string(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export const (char)*
grn_tokenizer_query_get_raw_string(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query, size_t* length);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_encoding
grn_tokenizer_query_get_encoding(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export uint
grn_tokenizer_query_get_flags(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_bool
grn_tokenizer_query_have_tokenized_delimiter(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.token.grn_tokenize_mode
grn_tokenizer_query_get_mode(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj*
grn_tokenizer_query_get_lexicon(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export uint
grn_tokenizer_query_get_token_filter_index(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj* grn_tokenizer_query_get_source_column(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_id grn_tokenizer_query_get_source_id(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj* grn_tokenizer_query_get_index_column(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj* grn_tokenizer_query_get_options(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

/*
  grn_tokenizer_token is needed to return tokens. A grn_tokenizer_token object
  stores a token to be returned and it must be maintained until a request for
  next token or finalization comes.
 */
alias grn_tokenizer_token = ._grn_tokenizer_token;

struct _grn_tokenizer_token
{
	groonga.groonga.grn_obj str;
	groonga.groonga.grn_obj status;
}

/*
  grn_tokenizer_token_init() initializes `token'. Note that an initialized
  object must be finalized by grn_tokenizer_token_fin().
 */

//GRN_PLUGIN_EXPORT
export void grn_tokenizer_token_init(groonga.groonga.grn_ctx* ctx, .grn_tokenizer_token* token);

/*
  grn_tokenizer_token_fin() finalizes `token' that has been initialized by
  grn_tokenizer_token_init().
 */

//GRN_PLUGIN_EXPORT
export void grn_tokenizer_token_fin(groonga.groonga.grn_ctx* ctx, .grn_tokenizer_token* token);

/*
 * grn_tokenizer_status is a flag set for tokenizer status codes.
 * If a document or query contains no tokens, push an empty string with
 * GRN_TOKENIZER_TOKEN_LAST as a token.
 *
 * @deprecated since 4.0.8. Use grn_token_status instead.
 */
alias grn_tokenizer_status = groonga.token.grn_token_status;

/*
 * GRN_TOKENIZER_TOKEN_CONTINUE means that the next token is not the last one.
 *
 * @deprecated since 4.0.8. Use GRN_TOKEN_CONTINUE instead.
 */
enum GRN_TOKENIZER_TOKEN_CONTINUE = groonga.token.GRN_TOKEN_CONTINUE;
/*
 * GRN_TOKENIZER_TOKEN_LAST means that the next token is the last one.
 *
 * @deprecated since 4.0.8. Use GRN_TOKEN_LAST instead.
 */
enum GRN_TOKENIZER_TOKEN_LAST = groonga.token.GRN_TOKEN_LAST;
/*
 * GRN_TOKENIZER_TOKEN_OVERLAP means that ...
 *
 * @deprecated since 4.0.8. Use GRN_TOKEN_OVERLAP instead.
 */
enum GRN_TOKENIZER_TOKEN_OVERLAP = groonga.token.GRN_TOKEN_OVERLAP;
/*
 * GRN_TOKENIZER_TOKEN_UNMATURED means that ...
 *
 * @deprecated since 4.0.8. Use GRN_TOKEN_UNMATURED instead.
 */
enum GRN_TOKENIZER_TOKEN_UNMATURED = groonga.token.GRN_TOKEN_UNMATURED;
/*
 * GRN_TOKENIZER_TOKEN_REACH_END means that ...
 *
 * @deprecated since 4.0.8. Use GRN_TOKEN_REACH_END instead.
 */
enum GRN_TOKENIZER_TOKEN_REACH_END = groonga.token.GRN_TOKEN_REACH_END;
/*
 * GRN_TOKENIZER_TOKEN_SKIP means that the token is skipped
 *
 * @deprecated since 4.0.8. Use GRN_TOKEN_SKIP instead.
 */
enum GRN_TOKENIZER_TOKEN_SKIP = groonga.token.GRN_TOKEN_SKIP;
/*
 * GRN_TOKENIZER_TOKEN_SKIP_WITH_POSITION means that the token and postion is skipped
 *
 * @deprecated since 4.0.8. Use GRN_TOKEN_SKIP_WITH_POSITION instead.
 */
enum GRN_TOKENIZER_TOKEN_SKIP_WITH_POSITION = groonga.token.GRN_TOKEN_SKIP_WITH_POSITION;
/*
 * GRN_TOKENIZER_TOKEN_FORCE_PREIX that the token is used common prefix search
 *
 * @deprecated since 4.0.8. Use GRN_TOKEN_FORCE_PREIX instead.
 */
enum GRN_TOKENIZER_TOKEN_FORCE_PREFIX = groonga.token.GRN_TOKEN_FORCE_PREFIX;

/*
 * GRN_TOKENIZER_CONTINUE and GRN_TOKENIZER_LAST are deprecated. They
 * are just for backward compatibility. Use
 * GRN_TOKENIZER_TOKEN_CONTINUE and GRN_TOKENIZER_TOKEN_LAST
 * instead.
 */
enum GRN_TOKENIZER_CONTINUE = .GRN_TOKENIZER_TOKEN_CONTINUE;
enum GRN_TOKENIZER_LAST = .GRN_TOKENIZER_TOKEN_LAST;

/*
  grn_tokenizer_token_push() pushes the next token into `token'. Note that
  grn_tokenizer_token_push() does not make a copy of the given string. This
  means that you have to maintain a memory space allocated to the string.
  Also note that the grn_tokenizer_token object must be maintained until the
  request for the next token or finalization comes. See grn_token_status in
  this header for more details of `status'.
 */

//GRN_PLUGIN_EXPORT
export void grn_tokenizer_token_push(groonga.groonga.grn_ctx* ctx, .grn_tokenizer_token* token, const (char)* str_ptr, uint str_length, groonga.token.grn_token_status status);

/*
  grn_tokenizer_tokenized_delimiter_next() extracts the next token
  from the string specified by `str_ptr' and `str_length' and pushes
  the next token into `token'. It returns the string after the next
  token. The returned string may be `NULL' when all tokens are
  extracted.

  @deprecated since 8.0.9. It's for old tokenizer next API. Use
  grn_tokenizer_next_by_tokenized_delimiter() for new tokenizer next
  API (grn_tokenizer_next_func).
 */

//GRN_PLUGIN_EXPORT
export const (char)* grn_tokenizer_tokenized_delimiter_next(groonga.groonga.grn_ctx* ctx, .grn_tokenizer_token* token, const (char)* str_ptr, uint str_length, groonga.groonga.grn_encoding encoding);

/*
  Extract the next token by delimiting by
  GRN_TOKENIZER_TOKENIZED_DELIMITER_UTF8.

  This is for grn_tokenizer_next_func.

  @since 8.0.9.
 */

//GRN_PLUGIN_EXPORT
export const (char)*
grn_tokenizer_next_by_tokenized_delimiter(groonga.groonga.grn_ctx* ctx, groonga.token.grn_token* token, const (char)* str_ptr, uint str_length, groonga.groonga.grn_encoding encoding);

/*
  grn_tokenizer_register() registers a plugin to the database which is
  associated with `ctx'. `plugin_name_ptr' and `plugin_name_length' specify the
  plugin name. Alphabetic letters ('A'-'Z' and 'a'-'z'), digits ('0'-'9') and
  an underscore ('_') are capable characters. `init', `next' and `fin' specify
  the plugin functions. `init' is called for initializing a tokenizer for a
  document or query. `next' is called for extracting tokens one by one. `fin'
  is called for finalizing a tokenizer. grn_tokenizer_register() returns
  GRN_SUCCESS on success, an error code on failure. See "groonga.h" for more
  details of grn_proc_func and grn_user_data, that is used as an argument of
  grn_proc_func.

  @deprecated since 8.0.2. Use grn_tokenizer_create() and
  grn_tokenizer_set_*_func().
 */

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc
grn_tokenizer_register(groonga.groonga.grn_ctx* ctx, const (char)* plugin_name_ptr, uint plugin_name_length, groonga.groonga.grn_proc_func init, groonga.groonga.grn_proc_func next, groonga.groonga.grn_proc_func fin);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj*
grn_tokenizer_create(groonga.groonga.grn_ctx* ctx, const (char)* name, int name_length);

private alias grn_tokenizer_init_func = /* Not a function pointer type */ extern (C) nothrow @nogc void* function(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query);

private alias grn_tokenizer_next_func = /* Not a function pointer type */ extern (C) nothrow @nogc void function(groonga.groonga.grn_ctx* ctx, groonga.tokenizer_query_deprecated.grn_tokenizer_query* query, groonga.token.grn_token* token, void* user_data);

private alias grn_tokenizer_fin_func = /* Not a function pointer type */ extern (C) nothrow @nogc void function(groonga.groonga.grn_ctx* ctx, void* user_data);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc
grn_tokenizer_set_init_func(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* tokenizer, .grn_tokenizer_init_func init);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc
grn_tokenizer_set_next_func(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* tokenizer, .grn_tokenizer_next_func next);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc
grn_tokenizer_set_fin_func(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* tokenizer, .grn_tokenizer_fin_func fin);
