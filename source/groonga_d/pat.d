/*
  Copyright(C) 2009-2016 Brazil

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
module groonga_d.pat;


private static import groonga_d.groonga;
private static import groonga_d.hash;

extern(C):
nothrow @nogc:

/+
#include "hash.h"
+/

extern struct _grn_pat;
extern struct _grn_pat_cursor;

alias grn_pat = _grn_pat;
alias grn_pat_cursor = _grn_pat_cursor;
alias grn_pat_scan_hit = groonga_d.groonga._grn_table_scan_hit;

//GRN_API
grn_pat* grn_pat_create(groonga_d.groonga.grn_ctx* ctx, const (char)* path, uint key_size, uint value_size, uint flags);

//GRN_API
grn_pat* grn_pat_open(groonga_d.groonga.grn_ctx* ctx, const (char)* path);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_close(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_remove(groonga_d.groonga.grn_ctx* ctx, const (char)* path);

//GRN_API
groonga_d.groonga.grn_id grn_pat_get(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, const (void)* key, uint key_size, void** value);

//GRN_API
groonga_d.groonga.grn_id grn_pat_add(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, const (void)* key, uint key_size, void** value, int* added);

//GRN_API
int grn_pat_get_key(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, groonga_d.groonga.grn_id id, void* keybuf, int bufsize);

//GRN_API
int grn_pat_get_key2(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, groonga_d.groonga.grn_id id, groonga_d.groonga.grn_obj* bulk);

//GRN_API
int grn_pat_get_value(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, groonga_d.groonga.grn_id id, void* valuebuf);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_set_value(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, groonga_d.groonga.grn_id id, const (void)* value, int flags);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_delete_by_id(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, groonga_d.groonga.grn_id id, groonga_d.groonga.grn_table_delete_optarg* optarg);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_delete(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, const (void)* key, uint key_size, groonga_d.groonga.grn_table_delete_optarg* optarg);

//GRN_API
int grn_pat_delete_with_sis(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, groonga_d.groonga.grn_id id, groonga_d.groonga.grn_table_delete_optarg* optarg);

//GRN_API
int grn_pat_scan(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, const (char)* str, uint str_len, grn_pat_scan_hit* sh, uint sh_size, const (char)** rest);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_prefix_search(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, const (void)* key, uint key_size, groonga_d.hash.grn_hash* h);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_suffix_search(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, const (void)* key, uint key_size, groonga_d.hash.grn_hash* h);

//GRN_API
groonga_d.groonga.grn_id grn_pat_lcp_search(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, const (void)* key, uint key_size);

//GRN_API
uint grn_pat_size(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat);

//GRN_API
grn_pat_cursor* grn_pat_cursor_open(groonga_d.groonga.grn_ctx* ctx, grn_pat* pat, const (void)* min, uint min_size, const (void)* max, uint max_size, int offset, int limit, int flags);

//GRN_API
groonga_d.groonga.grn_id grn_pat_cursor_next(groonga_d.groonga.grn_ctx* ctx, grn_pat_cursor* c);

//GRN_API
void grn_pat_cursor_close(groonga_d.groonga.grn_ctx* ctx, grn_pat_cursor* c);

//GRN_API
int grn_pat_cursor_get_key(groonga_d.groonga.grn_ctx* ctx, grn_pat_cursor* c, void** key);

//GRN_API
int grn_pat_cursor_get_value(groonga_d.groonga.grn_ctx* ctx, grn_pat_cursor* c, void** value);

//GRN_API
int grn_pat_cursor_get_key_value(groonga_d.groonga.grn_ctx* ctx, grn_pat_cursor* c, void** key, uint* key_size, void** value);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_cursor_set_value(groonga_d.groonga.grn_ctx* ctx, grn_pat_cursor* c, const (void)* value, int flags);

//GRN_API
groonga_d.groonga.grn_rc grn_pat_cursor_delete(groonga_d.groonga.grn_ctx* ctx, grn_pat_cursor* c, groonga_d.groonga.grn_table_delete_optarg* optarg);

alias GRN_PAT_EACH_block = extern (C) void function();

//ToDo: check
pragma(inline, true)
void GRN_PAT_EACH(groonga_d.groonga.grn_ctx* ctx, .grn_pat* pat, ref groonga_d.groonga.grn_id id, void** key, uint* key_size, void** value, .GRN_PAT_EACH_block block)

	do
	{
		.grn_pat_cursor *_sc = .grn_pat_cursor_open(ctx, pat, null, 0, null, 0, 0, -1, 0);

		if (_sc != null) {
			while ((id = .grn_pat_cursor_next(ctx, _sc)) > 0) {
				.grn_pat_cursor_get_key_value(ctx, _sc, key, key_size, value);
				block();
			}

			.grn_pat_cursor_close(ctx, _sc);
		}
	}
