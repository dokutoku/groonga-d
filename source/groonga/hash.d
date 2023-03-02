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
module groonga.hash;


private static import groonga.groonga;
private static import groonga.table;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

enum GRN_HASH_TINY = 0x01 << 6;

extern struct _grn_hash;
extern struct _grn_hash_cursor;

alias grn_hash = ._grn_hash;
alias grn_hash_cursor = ._grn_hash_cursor;

@GRN_API
.grn_hash* grn_hash_create(groonga.groonga.grn_ctx* ctx, const (char)* path, uint key_size, uint value_size, uint flags);

@GRN_API
.grn_hash* grn_hash_open(groonga.groonga.grn_ctx* ctx, const (char)* path);

@GRN_API
groonga.groonga.grn_rc grn_hash_close(groonga.groonga.grn_ctx* ctx, .grn_hash* hash);

@GRN_API
groonga.groonga.grn_id grn_hash_add(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, const (void)* key, uint key_size, void** value, int* added);

@GRN_API
groonga.groonga.grn_id grn_hash_get(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, const (void)* key, uint key_size, void** value);

@GRN_API
int grn_hash_get_key(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, groonga.groonga.grn_id id, void* keybuf, int bufsize);

@GRN_API
int grn_hash_get_key2(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, groonga.groonga.grn_id id, groonga.groonga.grn_obj* bulk);

@GRN_API
int grn_hash_get_value(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, groonga.groonga.grn_id id, void* valuebuf);

@GRN_API
groonga.groonga.grn_rc grn_hash_set_value(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, groonga.groonga.grn_id id, const (void)* value, int flags);

@GRN_API
groonga.groonga.grn_rc grn_hash_delete_by_id(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, groonga.groonga.grn_id id, groonga.groonga.grn_table_delete_optarg* optarg);

@GRN_API
groonga.groonga.grn_rc grn_hash_delete(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, const (void)* key, uint key_size, groonga.groonga.grn_table_delete_optarg* optarg);

@GRN_API
uint grn_hash_size(groonga.groonga.grn_ctx* ctx, .grn_hash* hash);

@GRN_API
.grn_hash_cursor* grn_hash_cursor_open(groonga.groonga.grn_ctx* ctx, .grn_hash* hash, const (void)* min, uint min_size, const (void)* max, uint max_size, int offset, int limit, int flags);

@GRN_API
groonga.groonga.grn_id grn_hash_cursor_next(groonga.groonga.grn_ctx* ctx, .grn_hash_cursor* c);

@GRN_API
void grn_hash_cursor_close(groonga.groonga.grn_ctx* ctx, .grn_hash_cursor* c);

@GRN_API
int grn_hash_cursor_get_key(groonga.groonga.grn_ctx* ctx, .grn_hash_cursor* c, void** key);

@GRN_API
int grn_hash_cursor_get_value(groonga.groonga.grn_ctx* ctx, .grn_hash_cursor* c, void** value);

@GRN_API
groonga.groonga.grn_rc grn_hash_cursor_set_value(groonga.groonga.grn_ctx* ctx, .grn_hash_cursor* c, const (void)* value, int flags);

@GRN_API
int grn_hash_cursor_get_key_value(groonga.groonga.grn_ctx* ctx, .grn_hash_cursor* c, void** key, uint* key_size, void** value);

@GRN_API
groonga.groonga.grn_rc grn_hash_cursor_delete(groonga.groonga.grn_ctx* ctx, .grn_hash_cursor* c, groonga.groonga.grn_table_delete_optarg* optarg);

//ToDo: example
///
template GRN_HASH_EACH(string ctx, string hash, string id, string key, string key_size, string value, string block)
{
	enum GRN_HASH_EACH =
	`
		do
		{
			groonga.hash.grn_hash_cursor* _sc = groonga.hash.grn_hash_cursor_open((` ~ ctx ~ `), (` ~ hash ~ `), null, 0, null, 0, 0, -1, 0);

			if (_sc != null) {
				groonga.groonga.grn_id ` ~ id ~ ` = void;

				while ((` ~ id ~ ` = groonga.hash.grn_hash_cursor_next((` ~ ctx ~ `), _sc))) {
					groonga.hash.grn_hash_cursor_get_key_value((` ~ ctx ~ `), _sc, cast(void**)(` ~ key ~ `), (` ~ key_size ~ `), cast(void**)(` ~ value ~ `));
					` ~ block ~ `
				}

				groonga.hash.grn_hash_cursor_close((` ~ ctx ~ `), _sc);
			}
		} while (false);
	`;
}

///Ditto
template GRN_HASH_EACH_BEGIN(string ctx, string hash, string cursor, string id)
{
	enum GRN_HASH_EACH_BEGIN =
	`
		do {
			groonga.hash.grn_hash_cursor* ` ~ cursor ~ ` = groonga.hash.grn_hash_cursor_open((` ~ ctx ~ `), (` ~ hash ~ `), null, 0, null, 0, 0, -1, groonga.table.GRN_CURSOR_BY_ID);

			if (` ~ cursor ~ ` != null) {
				groonga.groonga.grn_id ` ~ id ~ ` = void;

				while ((` ~ id ~ ` = groonga.hash.grn_hash_cursor_next((` ~ ctx ~ `), ` ~ cursor ~ `)) != groonga.groonga.GRN_ID_NIL) {
	`;
}

///Ditto
template GRN_HASH_EACH_END(string ctx, string cursor)
{
	enum GRN_HASH_EACH_END =
	`
				}

				groonga.hash.grn_hash_cursor_close((` ~ ctx ~ `), (` ~ cursor ~ `));
			}
		} while(false);
	`;
}
