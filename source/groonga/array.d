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
module groonga.array;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

extern struct _grn_array;
extern struct _grn_array_cursor;

alias grn_array = ._grn_array;
alias grn_array_cursor = ._grn_array_cursor;

@GRN_API
.grn_array* grn_array_create(groonga.groonga.grn_ctx* ctx, const (char)* path, uint value_size, uint flags);

@GRN_API
.grn_array* grn_array_open(groonga.groonga.grn_ctx* ctx, const (char)* path);

@GRN_API
groonga.groonga.grn_rc grn_array_close(groonga.groonga.grn_ctx* ctx, .grn_array* array);

@GRN_API
groonga.groonga.grn_id grn_array_add(groonga.groonga.grn_ctx* ctx, .grn_array* array, void** value);

private alias grn_array_pull_func = extern (C) nothrow @nogc void function(groonga.groonga.grn_ctx* ctx, .grn_array* array, groonga.groonga.grn_id id, void* func_arg);

@GRN_API
groonga.groonga.grn_id grn_array_push(groonga.groonga.grn_ctx* ctx, .grn_array* array, .grn_array_pull_func func, void* func_arg);

@GRN_API
groonga.groonga.grn_id grn_array_pull(groonga.groonga.grn_ctx* ctx, .grn_array* array, groonga.groonga.grn_bool blockp, .grn_array_pull_func func, void* func_arg);

@GRN_API
void grn_array_unblock(groonga.groonga.grn_ctx* ctx, .grn_array* array);

@GRN_API
int grn_array_get_value(groonga.groonga.grn_ctx* ctx, .grn_array* array, groonga.groonga.grn_id id, void* valuebuf);

@GRN_API
groonga.groonga.grn_rc grn_array_set_value(groonga.groonga.grn_ctx* ctx, .grn_array* array, groonga.groonga.grn_id id, const (void)* value, int flags);

@GRN_API
.grn_array_cursor* grn_array_cursor_open(groonga.groonga.grn_ctx* ctx, .grn_array* array, groonga.groonga.grn_id min, groonga.groonga.grn_id max, int offset, int limit, int flags);

@GRN_API
groonga.groonga.grn_id grn_array_cursor_next(groonga.groonga.grn_ctx* ctx, .grn_array_cursor* cursor);

@GRN_API
int grn_array_cursor_get_value(groonga.groonga.grn_ctx* ctx, .grn_array_cursor* cursor, void** value);

@GRN_API
groonga.groonga.grn_rc grn_array_cursor_set_value(groonga.groonga.grn_ctx* ctx, .grn_array_cursor* cursor, const (void)* value, int flags);

@GRN_API
groonga.groonga.grn_rc grn_array_cursor_delete(groonga.groonga.grn_ctx* ctx, .grn_array_cursor* cursor, groonga.groonga.grn_table_delete_optarg* optarg);

@GRN_API
void grn_array_cursor_close(groonga.groonga.grn_ctx* ctx, .grn_array_cursor* cursor);

@GRN_API
groonga.groonga.grn_rc grn_array_delete_by_id(groonga.groonga.grn_ctx* ctx, .grn_array* array, groonga.groonga.grn_id id, groonga.groonga.grn_table_delete_optarg* optarg);

@GRN_API
groonga.groonga.grn_id grn_array_next(groonga.groonga.grn_ctx* ctx, .grn_array* array, groonga.groonga.grn_id id);

@GRN_API
void* _grn_array_get_value(groonga.groonga.grn_ctx* ctx, .grn_array* array, groonga.groonga.grn_id id);

//ToDo: example
///
template GRN_ARRAY_EACH(string ctx, string array, string head, string tail, string id, string value, string block)
{
	enum GRN_ARRAY_EACH =
	`
		groonga.array.grn_array_cursor* _sc = groonga.array.grn_array_cursor_open((` ~ ctx ~ `), (` ~ array ~ `), (` ~ head ~ `), (` ~ tail ~ `), 0, -1, 0);

		if (_sc != null) {
			groonga.groonga.grn_id ` ~ id ~ ` = void;

			while ((` ~ id ~ ` = groonga.array.grn_array_cursor_next((` ~ ctx ~ `), _sc))) {
				groonga.array.grn_array_cursor_get_value((` ~ ctx ~ `), _sc, cast(void**)(` ~ value ~ `));
				` ~ block ~ `
			}

			groonga.array.grn_array_cursor_close((` ~ ctx ~ `), _sc);
		}
	`;
}

///Ditto
template GRN_ARRAY_EACH_BEGIN(string ctx, string array, string cursor, string head, string tail, string id)
{
	enum GRN_ARRAY_EACH_BEGIN =
	`
		do {
			groonga.array.grn_array_cursor* ` ~ cursor ~ ` = groonga.array.grn_array_cursor_open((` ~ ctx ~ `), (` ~ array ~ `), (` ~ head ~ `), (` ~ tail ~ `), 0, -1, 0);

			if (` ~ cursor ~ ` != null) {
				groonga.groonga.grn_id ` ~ id ~ ` = void;

				while ((` ~ id ~ ` = groonga.array.grn_array_cursor_next((` ~ ctx ~ `), ` ~ cursor ~ `))) {
	`;
}

///Ditto
template GRN_ARRAY_EACH_END(string ctx, string cursor)
{
	enum GRN_ARRAY_EACH_END =
	`
				}

				groonga.array.grn_array_cursor_close((` ~ ctx ~ `), (` ~ cursor ~ `));
			}
		} while (false);
	`;
}
