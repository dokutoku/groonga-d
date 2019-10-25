/*
  Copyright(C) 2009-2018 Brazil

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
module groonga_d.db;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

alias grn_db_create_optarg = _grn_db_create_optarg;

struct _grn_db_create_optarg
{
	char** builtin_type_names;
	int n_builtin_type_names;
}

//GRN_API
groonga_d.groonga.grn_obj* grn_db_create(groonga_d.groonga.grn_ctx* ctx, const (char)* path, grn_db_create_optarg* optarg);

/+
#define GRN_DB_OPEN_OR_CREATE(ctx, path, optarg, db) (((db) = grn_db_open((ctx), (path))) || (db = grn_db_create((ctx), (path), (optarg))))
+/

//GRN_API
groonga_d.groonga.grn_obj* grn_db_open(groonga_d.groonga.grn_ctx* ctx, const (char)* path);

//GRN_API
void grn_db_touch(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* db);

//GRN_API
groonga_d.groonga.grn_rc grn_db_recover(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* db);

//GRN_API
groonga_d.groonga.grn_rc grn_db_unmap(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* db);

//GRN_API
uint grn_db_get_last_modified(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* db);

//GRN_API
ubyte grn_db_is_dirty(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* db);

//GRN_API
groonga_d.groonga.grn_rc grn_db_set_cache(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* db, groonga_d.cache.grn_cache* cache);

//GRN_API
groonga_d.cache.grn_cache* grn_db_get_cache(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* db);

/+
#define GRN_DB_EACH_BEGIN_FLAGS(ctx, cursor, id, flags) GRN_TABLE_EACH_BEGIN_FLAGS(ctx, grn_ctx_db((ctx)), cursor, id, flags)

#define GRN_DB_EACH_BEGIN_BY_ID(ctx, cursor, id) GRN_DB_EACH_BEGIN_FLAGS(ctx, cursor, id, GRN_CURSOR_BY_ID | GRN_CURSOR_ASCENDING)

#define GRN_DB_EACH_BEGIN_BY_KEY(ctx, cursor, id) GRN_DB_EACH_BEGIN_FLAGS(ctx, cursor, id, GRN_CURSOR_BY_KEY | GRN_CURSOR_ASCENDING)

#define GRN_DB_EACH_END(ctx, cursor) GRN_TABLE_EACH_END(ctx, cursor)
+/
