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
module groonga_d.hash;


private static import groonga_d.groonga;
private static import groonga_d.table;
private import groonga_d.groonga: GRN_API;

extern(C):
nothrow @nogc:

enum GRN_HASH_TINY = 0x01 << 6;

extern struct _grn_hash;
extern struct _grn_hash_cursor;

alias grn_hash = ._grn_hash;
alias grn_hash_cursor = ._grn_hash_cursor;

@GRN_API
.grn_hash* grn_hash_create(groonga_d.groonga.grn_ctx* ctx, const (char)* path, uint key_size, uint value_size, uint flags);

@GRN_API
.grn_hash* grn_hash_open(groonga_d.groonga.grn_ctx* ctx, const (char)* path);

@GRN_API
groonga_d.groonga.grn_rc grn_hash_close(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash);

@GRN_API
groonga_d.groonga.grn_id grn_hash_add(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, const (void)* key, uint key_size, void** value, int* added);

@GRN_API
groonga_d.groonga.grn_id grn_hash_get(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, const (void)* key, uint key_size, void** value);

@GRN_API
int grn_hash_get_key(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, groonga_d.groonga.grn_id id, void* keybuf, int bufsize);

@GRN_API
int grn_hash_get_key2(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, groonga_d.groonga.grn_id id, groonga_d.groonga.grn_obj* bulk);

@GRN_API
int grn_hash_get_value(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, groonga_d.groonga.grn_id id, void* valuebuf);

@GRN_API
groonga_d.groonga.grn_rc grn_hash_set_value(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, groonga_d.groonga.grn_id id, const (void)* value, int flags);

@GRN_API
groonga_d.groonga.grn_rc grn_hash_delete_by_id(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, groonga_d.groonga.grn_id id, groonga_d.groonga.grn_table_delete_optarg* optarg);

@GRN_API
groonga_d.groonga.grn_rc grn_hash_delete(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, const (void)* key, uint key_size, groonga_d.groonga.grn_table_delete_optarg* optarg);

@GRN_API
uint grn_hash_size(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash);

@GRN_API
.grn_hash_cursor* grn_hash_cursor_open(groonga_d.groonga.grn_ctx* ctx, .grn_hash* hash, const (void)* min, uint min_size, const (void)* max, uint max_size, int offset, int limit, int flags);

@GRN_API
groonga_d.groonga.grn_id grn_hash_cursor_next(groonga_d.groonga.grn_ctx* ctx, .grn_hash_cursor* c);

@GRN_API
void grn_hash_cursor_close(groonga_d.groonga.grn_ctx* ctx, .grn_hash_cursor* c);

@GRN_API
int grn_hash_cursor_get_key(groonga_d.groonga.grn_ctx* ctx, .grn_hash_cursor* c, void** key);

@GRN_API
int grn_hash_cursor_get_value(groonga_d.groonga.grn_ctx* ctx, .grn_hash_cursor* c, void** value);

@GRN_API
groonga_d.groonga.grn_rc grn_hash_cursor_set_value(groonga_d.groonga.grn_ctx* ctx, .grn_hash_cursor* c, const (void)* value, int flags);

@GRN_API
int grn_hash_cursor_get_key_value(groonga_d.groonga.grn_ctx* ctx, .grn_hash_cursor* c, void** key, uint* key_size, void** value);

@GRN_API
groonga_d.groonga.grn_rc grn_hash_cursor_delete(groonga_d.groonga.grn_ctx* ctx, .grn_hash_cursor* c, groonga_d.groonga.grn_table_delete_optarg* optarg);

/+
#define GRN_HASH_EACH(ctx, hash, id, key, key_size, value, block) groonga_d.hash.grn_hash_cursor *_sc = groonga_d.hash.grn_hash_cursor_open(ctx, hash, null, 0, null, 0, 0, -1, 0); if (_sc) { groonga_d.groonga.grn_id id; while ((id = groonga_d.hash.grn_hash_cursor_next(ctx, _sc))) { groonga_d.hash.grn_hash_cursor_get_key_value(ctx, _sc, cast(void**)(key), (key_size), cast(void**)(value)); block } groonga_d.hash.grn_hash_cursor_close(ctx, _sc); }

#define GRN_HASH_EACH_BEGIN(ctx, hash, cursor, id) do { groonga_d.hash.grn_hash_cursor *cursor; cursor = groonga_d.hash.grn_hash_cursor_open((ctx), (hash), null, 0, null, 0, 0, -1, groonga_d.table.GRN_CURSOR_BY_ID); if (cursor) { groonga_d.groonga.grn_id id; while ((id = groonga_d.hash.grn_hash_cursor_next((ctx), cursor)) != groonga_d.groonga.GRN_ID_NIL) {

#define GRN_HASH_EACH_END(ctx, cursor) } groonga_d.hash.grn_hash_cursor_close((ctx), cursor); } } while(0)
+/
