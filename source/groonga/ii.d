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
/**
 * License: LGPL-2.1
 */
module groonga.ii;


private static import groonga.groonga;
private static import groonga.hash;
private static import groonga.posting;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

/* buffered index builder */

extern struct _grn_ii;
extern struct _grn_ii_buffer;

alias grn_ii = ._grn_ii;
alias grn_ii_buffer = ._grn_ii_buffer;

@GRN_API
groonga.groonga.grn_column_flags grn_ii_get_flags(groonga.groonga.grn_ctx* ctx, .grn_ii* ii);

@GRN_API
uint grn_ii_get_n_elements(groonga.groonga.grn_ctx* ctx, .grn_ii* ii);

@GRN_API
void grn_ii_cursor_set_min_enable_set(groonga.groonga.grn_bool enable);

@GRN_API
groonga.groonga.grn_bool grn_ii_cursor_set_min_enable_get();

@GRN_API
uint grn_ii_estimate_size(groonga.groonga.grn_ctx* ctx, .grn_ii* ii, groonga.groonga.grn_id tid);

@GRN_API
uint grn_ii_estimate_size_for_query(groonga.groonga.grn_ctx* ctx, .grn_ii* ii, const (char)* query, uint query_len, groonga.groonga.grn_search_optarg* optarg);

@GRN_API
uint grn_ii_estimate_size_for_lexicon_cursor(groonga.groonga.grn_ctx* ctx, .grn_ii* ii, groonga.groonga.grn_table_cursor* lexicon_cursor);

@GRN_API
.grn_ii_buffer* grn_ii_buffer_open(groonga.groonga.grn_ctx* ctx, .grn_ii* ii, ulong update_buffer_size);

@GRN_API
groonga.groonga.grn_rc grn_ii_buffer_append(groonga.groonga.grn_ctx* ctx, .grn_ii_buffer* ii_buffer, groonga.groonga.grn_id rid, uint section, groonga.groonga.grn_obj* value);

@GRN_API
groonga.groonga.grn_rc grn_ii_buffer_commit(groonga.groonga.grn_ctx* ctx, .grn_ii_buffer* ii_buffer);

@GRN_API
groonga.groonga.grn_rc grn_ii_buffer_close(groonga.groonga.grn_ctx* ctx, .grn_ii_buffer* ii_buffer);

@GRN_API
groonga.groonga.grn_rc grn_ii_posting_add(groonga.groonga.grn_ctx* ctx, groonga.posting.grn_posting* pos, groonga.hash.grn_hash* s, groonga.groonga.grn_operator op);
/* Deprecated since 10.0.3. Use grn_rset_add_records() instead. */
@GRN_API
groonga.groonga.grn_rc grn_ii_posting_add_float(groonga.groonga.grn_ctx* ctx, groonga.posting.grn_posting* pos, groonga.hash.grn_hash* s, groonga.groonga.grn_operator op);

@GRN_API
void grn_ii_resolve_sel_and(groonga.groonga.grn_ctx* ctx, groonga.hash.grn_hash* s, groonga.groonga.grn_operator op);

/* Experimental */
extern struct _grn_ii_cursor;
alias grn_ii_cursor = ._grn_ii_cursor;

@GRN_API
.grn_ii_cursor* grn_ii_cursor_open(groonga.groonga.grn_ctx* ctx, .grn_ii* ii, groonga.groonga.grn_id tid, groonga.groonga.grn_id min, groonga.groonga.grn_id max, int nelements, int flags);

@GRN_API
.grn_ii* grn_ii_cursor_get_ii(groonga.groonga.grn_ctx* ctx, .grn_ii_cursor* cursor);

@GRN_API
groonga.groonga.grn_rc grn_ii_cursor_set_scales(groonga.groonga.grn_ctx* ctx, .grn_ii_cursor* cursor, float* scales, size_t n_scales);

@GRN_API
groonga.groonga.grn_rc grn_ii_cursor_set_scale(groonga.groonga.grn_ctx* ctx, .grn_ii_cursor* cursor, float scale);

@GRN_API
groonga.posting.grn_posting* grn_ii_cursor_next(groonga.groonga.grn_ctx* ctx, .grn_ii_cursor* c);

@GRN_API
groonga.posting.grn_posting* grn_ii_cursor_next_pos(groonga.groonga.grn_ctx* ctx, .grn_ii_cursor* c);

@GRN_API
groonga.groonga.grn_rc grn_ii_cursor_close(groonga.groonga.grn_ctx* ctx, .grn_ii_cursor* c);
