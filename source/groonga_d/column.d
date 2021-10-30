/*
  Copyright(C) 2009-2017  Brazil
  Copyright(C) 2018-2021  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.column;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

extern struct _grn_column_cache;
alias grn_column_cache = _grn_column_cache;

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

//GRN_API
groonga_d.groonga.grn_obj* grn_column_create(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* name, uint name_size, const (char)* path, uint flags, groonga_d.groonga.grn_obj* type);

//GRN_API
groonga_d.groonga.grn_obj* grn_column_create_similar(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* name, uint name_size, const (char)* path, groonga_d.groonga.grn_obj* base_column);

/+
pragma(inline, true)
nothrow @nogc
bool GRN_COLUMN_OPEN_OR_CREATE(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* name, uint name_size, const (char)* path, uint flags, groonga_d.groonga.grn_obj* type, groonga_d.groonga.grn_obj* column)

	do
	{
		//Todo: not null?
		return ((column = grn_obj_column(ctx, table, name, name_size)) != null) || ((column = grn_column_create(ctx, table, name, name_size, path, flags, type)) != null);
	}
+/

//GRN_API
groonga_d.groonga.grn_rc grn_column_index_update(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* column, groonga_d.groonga.grn_id id, uint section, groonga_d.groonga.grn_obj* oldvalue, groonga_d.groonga.grn_obj* newvalue);

//GRN_API
groonga_d.groonga.grn_obj* grn_column_table(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* column);

//GRN_API
groonga_d.groonga.grn_rc grn_column_truncate(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* column);

//GRN_API
uint grn_column_get_flags(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* column);

//GRN_API
grn_column_cache* grn_column_cache_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* column);

//GRN_API
void grn_column_cache_close(groonga_d.groonga.grn_ctx* ctx, grn_column_cache* cache);

//GRN_API
void* grn_column_cache_ref(groonga_d.groonga.grn_ctx* ctx, grn_column_cache* cache, groonga_d.groonga.grn_id id, size_t* value_size);

//GRN_API
groonga_d.groonga.grn_rc grn_column_copy(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* from, groonga_d.groonga.grn_obj* to);
