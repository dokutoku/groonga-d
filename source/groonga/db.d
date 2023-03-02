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
module groonga.db;


private static import groonga.cache;
private static import groonga.groonga;
private static import groonga.table;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

alias grn_db_create_optarg = ._grn_db_create_optarg;

struct _grn_db_create_optarg
{
	char** builtin_type_names;
	int n_builtin_type_names;
}

@GRN_API
groonga.groonga.grn_obj* grn_db_create(groonga.groonga.grn_ctx* ctx, const (char)* path, .grn_db_create_optarg* optarg);

pragma(inline, true)
bool GRN_DB_OPEN_OR_CREATE(groonga.groonga.grn_ctx* ctx, const (char)* path, .grn_db_create_optarg* optarg, ref groonga.groonga.grn_obj* db)

	do
	{
		return ((db = .grn_db_open(ctx, path)) != null) || ((db = .grn_db_create(ctx, path, optarg)) != null);
	}

@GRN_API
groonga.groonga.grn_obj* grn_db_open(groonga.groonga.grn_ctx* ctx, const (char)* path);

@GRN_API
void grn_db_touch(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* db);

@GRN_API
groonga.groonga.grn_rc grn_db_recover(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* db);

@GRN_API
groonga.groonga.grn_rc grn_db_unmap(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* db);

@GRN_API
uint grn_db_get_last_modified(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* db);

@GRN_API
groonga.groonga.grn_bool grn_db_is_dirty(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* db);

@GRN_API
groonga.groonga.grn_rc grn_db_set_cache(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* db, groonga.cache.grn_cache* cache);

@GRN_API
groonga.cache.grn_cache* grn_db_get_cache(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* db);

//ToDo: example
///
template GRN_DB_EACH_BEGIN_FLAGS(string ctx, string cursor, string id, string flags)
{
	enum GRN_DB_EACH_BEGIN_FLAGS = groonga.table.GRN_TABLE_EACH_BEGIN_FLAGS!(ctx, `groonga.groonga.grn_ctx_db((` ~ ctx ~ `))`, cursor, id, flags);
}

///Ditto
template GRN_DB_EACH_BEGIN_BY_ID(string ctx, string cursor, string id)
{
	enum GRN_DB_EACH_BEGIN_BY_ID = groonga.db.GRN_DB_EACH_BEGIN_FLAGS!(ctx, cursor, id, "groonga.table.GRN_CURSOR_BY_ID | groonga.table.GRN_CURSOR_ASCENDING");
}

///Ditto
template GRN_DB_EACH_BEGIN_BY_KEY(string ctx, string cursor, string id)
{
	enum GRN_DB_EACH_BEGIN_BY_KEY = groonga.db.GRN_DB_EACH_BEGIN_FLAGS!(ctx, cursor, id, "groonga.table.GRN_CURSOR_BY_KEY | groonga.table.GRN_CURSOR_ASCENDING");
}

///Ditto
alias GRN_DB_EACH_END = groonga.table.GRN_TABLE_EACH_END;
