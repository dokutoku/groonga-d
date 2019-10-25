/*
  Copyright(C) 2009-2017 Brazil
  Copyright(C) 2019 Kouhei Sutou <kou@clear-code.com>

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
module groonga_d.ii;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

/* buffered index builder */

extern struct _grn_ii;
extern struct _grn_ii_buffer;

alias grn_ii = _grn_ii;
alias grn_ii_buffer = _grn_ii_buffer;

//GRN_API
uint grn_ii_get_flags(groonga_d.groonga.grn_ctx* ctx, grn_ii* ii);

//GRN_API
uint grn_ii_get_n_elements(groonga_d.groonga.grn_ctx* ctx, grn_ii* ii);

//GRN_API
void grn_ii_cursor_set_min_enable_set(ubyte enable);

//GRN_API
ubyte grn_ii_cursor_set_min_enable_get();

//GRN_API
uint grn_ii_estimate_size(groonga_d.groonga.grn_ctx* ctx, grn_ii* ii, uint tid);

//GRN_API
uint grn_ii_estimate_size_for_query(groonga_d.groonga.grn_ctx* ctx, grn_ii* ii, const (char)* query, uint query_len, groonga_d.groonga.grn_search_optarg* optarg);

//GRN_API
uint grn_ii_estimate_size_for_lexicon_cursor(groonga_d.groonga.grn_ctx* ctx, grn_ii* ii, groonga_d.groonga.grn_table_cursor* lexicon_cursor);

//GRN_API
grn_ii_buffer* grn_ii_buffer_open(groonga_d.groonga.grn_ctx* ctx, grn_ii* ii, ulong update_buffer_size);

//GRN_API
groonga_d.groonga.grn_rc grn_ii_buffer_append(groonga_d.groonga.grn_ctx* ctx, grn_ii_buffer* ii_buffer, uint rid, uint section, groonga_d.groonga.grn_obj* value);

//GRN_API
groonga_d.groonga.grn_rc grn_ii_buffer_commit(groonga_d.groonga.grn_ctx* ctx, grn_ii_buffer* ii_buffer);

//GRN_API
groonga_d.groonga.grn_rc grn_ii_buffer_close(groonga_d.groonga.grn_ctx* ctx, grn_ii_buffer* ii_buffer);

//GRN_API
groonga_d.groonga.grn_rc grn_ii_posting_add(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_posting* pos, groonga_d.hash.grn_hash* s, groonga_d.groonga.grn_operator op);

//GRN_API
void grn_ii_resolve_sel_and(groonga_d.groonga.grn_ctx* ctx, groonga_d.hash.grn_hash* s, groonga_d.groonga.grn_operator op);

/* Experimental */
extern struct _grn_ii_cursor;
alias grn_ii_cursor = _grn_ii_cursor;

//GRN_API
grn_ii_cursor* grn_ii_cursor_open(groonga_d.groonga.grn_ctx* ctx, grn_ii* ii, uint tid, uint min, uint max, int nelements, int flags);

//GRN_API
groonga_d.groonga.grn_posting* grn_ii_cursor_next(groonga_d.groonga.grn_ctx* ctx, grn_ii_cursor* c);

//GRN_API
groonga_d.groonga.grn_posting* grn_ii_cursor_next_pos(groonga_d.groonga.grn_ctx* ctx, grn_ii_cursor* c);

//GRN_API
groonga_d.groonga.grn_rc grn_ii_cursor_close(groonga_d.groonga.grn_ctx* ctx, grn_ii_cursor* c);
