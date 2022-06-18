/*
  Copyright(C) 2014-2018  Brazil
  Copyright(C) 2018-2021  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.token;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

/*
 * grn_tokenize_mode describes propose for tokenization.
 *
 * `GRN_TOKENIZE_GET`: Tokenize for search.
 *
 * `GRN_TOKENIZE_ADD`: Tokenize for adding token to index.
 *
 * `GRN_TOKENIZE_DELETE`: Tokenize for deleting token from index.
 *
 * @since 4.0.8
 */
enum grn_tokenize_mode
{
	GRN_TOKENIZE_GET = 0,
	GRN_TOKENIZE_ADD,
	GRN_TOKENIZE_DELETE,
	GRN_TOKENIZE_ONLY,
}

//Declaration name in C language
enum
{
	GRN_TOKENIZE_GET = .grn_tokenize_mode.GRN_TOKENIZE_GET,
	GRN_TOKENIZE_ADD = .grn_tokenize_mode.GRN_TOKENIZE_ADD,
	GRN_TOKENIZE_DELETE = .grn_tokenize_mode.GRN_TOKENIZE_DELETE,
	GRN_TOKENIZE_ONLY = .grn_tokenize_mode.GRN_TOKENIZE_ONLY,
}

/*
  grn_token_mode describes propose for tokenization.

  `GRN_TOKEN_GET`: Tokenization for search.

  `GRN_TOKEN_ADD`: Tokenization for adding token to index.

  `GRN_TOKEN_DEL`: Tokenization for deleting token from index.

  @since 4.0.7
  @deprecated since 4.0.8. Use grn_tokenize_mode instead.
 */
alias grn_token_mode = .grn_tokenize_mode;

enum GRN_TOKEN_GET = .grn_token_mode.GRN_TOKENIZE_GET;
enum GRN_TOKEN_ADD = .grn_token_mode.GRN_TOKENIZE_ADD;
enum GRN_TOKEN_DEL = .grn_token_mode.GRN_TOKENIZE_DELETE;

/*
 * grn_token_status is a flag set for tokenizer status codes.
 * If a document or query contains no tokens, push an empty string with
 * GRN_TOKEN_LAST as a token.
 *
 * @since 4.0.8
 */
alias grn_token_status = uint;

/*
 * GRN_TOKEN_CONTINUE means that the next token is not the last one.
 *
 * @since 4.0.8
 */
enum GRN_TOKEN_CONTINUE = 0;
/*
 * GRN_TOKEN_LAST means that the next token is the last one.
 *
 * @since 4.0.8
 */
enum GRN_TOKEN_LAST = 0x01L << 0;
/*
 * GRN_TOKEN_OVERLAP means that ...
 *
 * @since 4.0.8
 */
enum GRN_TOKEN_OVERLAP = 0x01L << 1;
/*
 * GRN_TOKEN_UNMATURED means that ...
 *
 * @since 4.0.8
 */
enum GRN_TOKEN_UNMATURED = 0x01L << 2;
/*
 * GRN_TOKEN_REACH_END means that ...
 *
 * @since 4.0.8
 */
enum GRN_TOKEN_REACH_END = 0x01L << 3;
/*
 * GRN_TOKEN_SKIP means that the token is skipped
 *
 * @since 4.0.8
 */
enum GRN_TOKEN_SKIP = 0x01L << 4;
/*
 * GRN_TOKEN_SKIP_WITH_POSITION means that the token and postion is skipped
 *
 * @since 4.0.8
 */
enum GRN_TOKEN_SKIP_WITH_POSITION = 0x01L << 5;
/*
 * GRN_TOKEN_FORCE_PREFIX means that the token is used common prefix search
 *
 * @since 4.0.8
 */
enum GRN_TOKEN_FORCE_PREFIX = 0x01L << 6;

/*
 * GRN_TOKEN_KEEP_ORIGINAL means that the original token of the token is
 * also used. This is for token filter.
 *
 * @since 11.0.3
 */
enum GRN_TOKEN_KEEP_ORIGINAL = 0x01L << 7;

extern struct _grn_token;
alias grn_token = ._grn_token;

//GRN_API
groonga_d.groonga.grn_obj* grn_token_get_data(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
const (char)* grn_token_get_data_raw(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, size_t* length);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_data(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, const (char)* str_ptr, int str_length);

//GRN_API
.grn_token_status grn_token_get_status(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_status(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, .grn_token_status status);

//GRN_API
groonga_d.groonga.grn_rc grn_token_add_status(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, .grn_token_status status);

//GRN_API
groonga_d.groonga.grn_rc grn_token_remove_status(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, .grn_token_status status);

//GRN_API
ulong grn_token_get_source_offset(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_source_offset(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, ulong offset);

//GRN_API
uint grn_token_get_source_length(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_source_length(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, uint length);

//GRN_API
uint grn_token_get_source_first_character_length(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_source_first_character_length(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, uint length);

//GRN_API
groonga_d.groonga.grn_bool grn_token_have_overlap(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_overlap(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, groonga_d.groonga.grn_bool have_overlap);

//GRN_API
groonga_d.groonga.grn_obj* grn_token_get_metadata(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_bool grn_token_get_force_prefix_search(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_force_prefix_search(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, groonga_d.groonga.grn_bool force);

//GRN_API
uint grn_token_get_position(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_position(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, uint position);

//GRN_API
float grn_token_get_weight(groonga_d.groonga.grn_ctx* ctx, .grn_token* token);

//GRN_API
groonga_d.groonga.grn_rc grn_token_set_weight(groonga_d.groonga.grn_ctx* ctx, .grn_token* token, float weight);
