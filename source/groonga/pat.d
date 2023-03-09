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
module groonga.pat;


private static import groonga.groonga;
private static import groonga.hash;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

/+
#include "hash.h"
+/

extern struct _grn_pat;
extern struct _grn_pat_cursor;

alias grn_pat = ._grn_pat;
alias grn_pat_cursor = ._grn_pat_cursor;
alias grn_pat_scan_hit = groonga.groonga._grn_table_scan_hit;

@GRN_API
.grn_pat* grn_pat_create(groonga.groonga.grn_ctx* ctx, const (char)* path, uint key_size, uint value_size, uint flags);

@GRN_API
.grn_pat* grn_pat_open(groonga.groonga.grn_ctx* ctx, const (char)* path);

@GRN_API
groonga.groonga.grn_rc grn_pat_close(groonga.groonga.grn_ctx* ctx, .grn_pat* pat);

@GRN_API
groonga.groonga.grn_rc grn_pat_remove(groonga.groonga.grn_ctx* ctx, const (char)* path);

@GRN_API
groonga.groonga.grn_id grn_pat_get(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, const (void)* key, uint key_size, void** value);

@GRN_API
groonga.groonga.grn_id grn_pat_add(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, const (void)* key, uint key_size, void** value, int* added);

@GRN_API
int grn_pat_get_key(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, groonga.groonga.grn_id id, void* keybuf, int bufsize);

@GRN_API
int grn_pat_get_key2(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, groonga.groonga.grn_id id, groonga.groonga.grn_obj* bulk);

@GRN_API
int grn_pat_get_value(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, groonga.groonga.grn_id id, void* valuebuf);

@GRN_API
groonga.groonga.grn_rc grn_pat_set_value(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, groonga.groonga.grn_id id, const (void)* value, int flags);

@GRN_API
groonga.groonga.grn_rc grn_pat_delete_by_id(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, groonga.groonga.grn_id id, groonga.groonga.grn_table_delete_optarg* optarg);

@GRN_API
groonga.groonga.grn_rc grn_pat_delete(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, const (void)* key, uint key_size, groonga.groonga.grn_table_delete_optarg* optarg);

@GRN_API
int grn_pat_delete_with_sis(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, groonga.groonga.grn_id id, groonga.groonga.grn_table_delete_optarg* optarg);

@GRN_API
int grn_pat_scan(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, const (char)* str, uint str_len, .grn_pat_scan_hit* sh, uint sh_size, const (char)** rest);

@GRN_API
groonga.groonga.grn_rc grn_pat_prefix_search(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, const (void)* key, uint key_size, groonga.hash.grn_hash* h);

@GRN_API
groonga.groonga.grn_rc grn_pat_suffix_search(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, const (void)* key, uint key_size, groonga.hash.grn_hash* h);

@GRN_API
groonga.groonga.grn_id grn_pat_lcp_search(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, const (void)* key, uint key_size);

@GRN_API
uint grn_pat_size(groonga.groonga.grn_ctx* ctx, .grn_pat* pat);

@GRN_API
.grn_pat_cursor* grn_pat_cursor_open(groonga.groonga.grn_ctx* ctx, .grn_pat* pat, const (void)* min, uint min_size, const (void)* max, uint max_size, int offset, int limit, int flags);

@GRN_API
groonga.groonga.grn_id grn_pat_cursor_next(groonga.groonga.grn_ctx* ctx, .grn_pat_cursor* c);

@GRN_API
void grn_pat_cursor_close(groonga.groonga.grn_ctx* ctx, .grn_pat_cursor* c);

@GRN_API
int grn_pat_cursor_get_key(groonga.groonga.grn_ctx* ctx, .grn_pat_cursor* c, void** key);

@GRN_API
int grn_pat_cursor_get_value(groonga.groonga.grn_ctx* ctx, .grn_pat_cursor* c, void** value);

@GRN_API
int grn_pat_cursor_get_key_value(groonga.groonga.grn_ctx* ctx, .grn_pat_cursor* c, void** key, uint* key_size, void** value);

@GRN_API
groonga.groonga.grn_rc grn_pat_cursor_set_value(groonga.groonga.grn_ctx* ctx, .grn_pat_cursor* c, const (void)* value, int flags);

@GRN_API
groonga.groonga.grn_rc grn_pat_cursor_delete(groonga.groonga.grn_ctx* ctx, .grn_pat_cursor* c, groonga.groonga.grn_table_delete_optarg* optarg);

//ToDo: example
///
template GRN_PAT_EACH(string ctx, string pat, string id, string key, string key_size, string value, string block)
{
	enum GRN_PAT_EACH =
	`
		do {
			groonga.pat.grn_pat_cursor *_sc = groonga.pat.grn_pat_cursor_open(` ~ ctx ~ `, ` ~ pat ~ `, null, 0, null, 0, 0, -1, 0);

			if (_sc != null) {
				groonga.groonga.grn_id ` ~ id ~ ` = void;

				while ((` ~ id ~ ` = groonga.pat.grn_pat_cursor_next(` ~ ctx ~ `, _sc)) > 0) {
					groonga.pat.grn_pat_cursor_get_key_value(` ~ ctx ~ `, _sc, cast(void**)(` ~ key ~ `), (` ~ key_size ~ `), cast(void**)(` ~ value ~ `));
					` ~ block ~ `
				}

				groonga.pat.grn_pat_cursor_close(` ~ ctx ~ `, _sc);
			}
		} while (false);
	`;
}
