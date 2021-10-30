/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2009-2016  Brazil
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
module groonga_d.token_cursor;


private static import groonga_d.groonga;
private static import groonga_d.token;

extern(C):
nothrow @nogc:

enum grn_token_cursor_status
{
	GRN_TOKEN_CURSOR_DOING = 0,
	GRN_TOKEN_CURSOR_DONE,
	GRN_TOKEN_CURSOR_DONE_SKIP,
	GRN_TOKEN_CURSOR_NOT_FOUND,
}

//Declaration name in C language
enum
{
	GRN_TOKEN_CURSOR_DOING = .grn_token_cursor_status.GRN_TOKEN_CURSOR_DOING,
	GRN_TOKEN_CURSOR_DONE = .grn_token_cursor_status.GRN_TOKEN_CURSOR_DONE,
	GRN_TOKEN_CURSOR_DONE_SKIP = .grn_token_cursor_status.GRN_TOKEN_CURSOR_DONE_SKIP,
	GRN_TOKEN_CURSOR_NOT_FOUND = .grn_token_cursor_status.GRN_TOKEN_CURSOR_NOT_FOUND,
}

enum GRN_TOKEN_CURSOR_ENABLE_TOKENIZED_DELIMITER = 0x01 << 0;
enum GRN_TOKEN_CURSOR_PARALLEL = 0x01 << 1;

extern struct _grn_token_cursor;
alias grn_token_cursor = _grn_token_cursor;

//GRN_API
grn_token_cursor* grn_token_cursor_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* str, size_t str_len, groonga_d.token.grn_tokenize_mode mode, uint flags);

//GRN_API
groonga_d.groonga.grn_rc grn_token_cursor_set_source_column(groonga_d.groonga.grn_ctx* ctx, grn_token_cursor* token_cursor, groonga_d.groonga.grn_obj* column);

//GRN_API
groonga_d.groonga.grn_rc grn_token_cursor_set_source_id(groonga_d.groonga.grn_ctx* ctx, grn_token_cursor* token_cursor, groonga_d.groonga.grn_id id);

//GRN_API
groonga_d.groonga.grn_rc grn_token_cursor_set_index_column(groonga_d.groonga.grn_ctx* ctx, grn_token_cursor* token_cursor, groonga_d.groonga.grn_obj* column);

//GRN_API
groonga_d.groonga.grn_rc grn_token_cursor_set_query_options(groonga_d.groonga.grn_ctx* ctx, grn_token_cursor* token_cursor, groonga_d.groonga.grn_obj* query_options);

//GRN_API
groonga_d.groonga.grn_id grn_token_cursor_next(groonga_d.groonga.grn_ctx* ctx, grn_token_cursor* token_cursor);

//GRN_API
grn_token_cursor_status grn_token_cursor_get_status(groonga_d.groonga.grn_ctx* ctx, grn_token_cursor* token_cursor);

//GRN_API
groonga_d.groonga.grn_rc grn_token_cursor_close(groonga_d.groonga.grn_ctx* ctx, grn_token_cursor* token_cursor);

//GRN_API
groonga_d.token.grn_token* grn_token_cursor_get_token(groonga_d.groonga.grn_ctx* ctx, grn_token_cursor* token_cursor);
