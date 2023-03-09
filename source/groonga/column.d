/*
  Copyright(C) 2009-2017  Brazil
  Copyright(C) 2018-2022  Sutou Kouhei <kou@clear-code.com>

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
module groonga.column;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

extern struct _grn_column_cache;
alias grn_column_cache = ._grn_column_cache;

enum GRN_COLUMN_NAME_ID = "_id";
enum GRN_COLUMN_NAME_ID_LEN = .GRN_COLUMN_NAME_ID.length;
enum GRN_COLUMN_NAME_KEY = "_key";
enum GRN_COLUMN_NAME_KEY_LEN = .GRN_COLUMN_NAME_KEY.length;
enum GRN_COLUMN_NAME_VALUE = "_value";
enum GRN_COLUMN_NAME_VALUE_LEN = .GRN_COLUMN_NAME_VALUE.length;
enum GRN_COLUMN_NAME_SCORE = "_score";
enum GRN_COLUMN_NAME_SCORE_LEN = .GRN_COLUMN_NAME_SCORE.length;
enum GRN_COLUMN_NAME_NSUBRECS = "_nsubrecs";
enum GRN_COLUMN_NAME_NSUBRECS_LEN = .GRN_COLUMN_NAME_NSUBRECS.length;
enum GRN_COLUMN_NAME_MAX = "_max";
enum GRN_COLUMN_NAME_MAX_LEN = .GRN_COLUMN_NAME_MAX.length;
enum GRN_COLUMN_NAME_MIN = "_min";
enum GRN_COLUMN_NAME_MIN_LEN = .GRN_COLUMN_NAME_MIN.length;
enum GRN_COLUMN_NAME_SUM = "_sum";
enum GRN_COLUMN_NAME_SUM_LEN = .GRN_COLUMN_NAME_SUM.length;
/* Deprecated since 10.0.4. Use GRN_COLUMN_NAME_MEAN instead. */
enum GRN_COLUMN_NAME_AVG = "_avg";
enum GRN_COLUMN_NAME_AVG_LEN = .GRN_COLUMN_NAME_AVG.length;
enum GRN_COLUMN_NAME_MEAN = "_mean";
enum GRN_COLUMN_NAME_MEAN_LEN = .GRN_COLUMN_NAME_MEAN.length;

@GRN_API
groonga.groonga.grn_obj* grn_column_create(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, const (char)* name, uint name_size, const (char)* path, groonga.groonga.grn_column_flags flags, groonga.groonga.grn_obj* type);

@GRN_API
groonga.groonga.grn_obj* grn_column_create_similar(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, const (char)* name, uint name_size, const (char)* path, groonga.groonga.grn_obj* base_column);

pragma(inline, true)
bool GRN_COLUMN_OPEN_OR_CREATE(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, const (char)* name, uint name_size, const (char)* path, uint flags, groonga.groonga.grn_obj* type, ref groonga.groonga.grn_obj* column)

	do
	{
		return ((column = groonga.groonga.grn_obj_column(ctx, table, name, name_size)) != null) || ((column = .grn_column_create(ctx, table, name, name_size, path, flags, type)) != null);
	}

@GRN_API
groonga.groonga.grn_rc grn_column_index_update(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* column, groonga.groonga.grn_id id, uint section, groonga.groonga.grn_obj* oldvalue, groonga.groonga.grn_obj* newvalue);

@GRN_API
groonga.groonga.grn_obj* grn_column_table(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* column);

@GRN_API
groonga.groonga.grn_rc grn_column_truncate(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* column);

@GRN_API
groonga.groonga.grn_column_flags grn_column_get_flags(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* column);

@GRN_API
groonga.groonga.grn_column_flags grn_column_get_missing_mode(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* column);

@GRN_API
groonga.groonga.grn_column_flags grn_column_get_invalid_mode(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* column);

@GRN_API
.grn_column_cache* grn_column_cache_open(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* column);

@GRN_API
void grn_column_cache_close(groonga.groonga.grn_ctx* ctx, .grn_column_cache* cache);

@GRN_API
void* grn_column_cache_ref(groonga.groonga.grn_ctx* ctx, .grn_column_cache* cache, groonga.groonga.grn_id id, size_t* value_size);

@GRN_API
groonga.groonga.grn_rc grn_column_copy(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* from, groonga.groonga.grn_obj* to);
