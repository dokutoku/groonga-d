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
module groonga_d.array;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

extern struct _grn_array;
extern struct _grn_array_cursor;

alias grn_array = _grn_array;
alias grn_array_cursor = _grn_array_cursor;

//GRN_API
grn_array* grn_array_create(groonga_d.groonga.grn_ctx* ctx, const (char)* path, uint value_size, uint flags);

//GRN_API
grn_array* grn_array_open(groonga_d.groonga.grn_ctx* ctx, const (char)* path);

//GRN_API
groonga_d.groonga.grn_rc grn_array_close(groonga_d.groonga.grn_ctx* ctx, grn_array* array);

//GRN_API
uint grn_array_add(groonga_d.groonga.grn_ctx* ctx, grn_array* array, void** value);

//GRN_API
uint grn_array_push(groonga_d.groonga.grn_ctx* ctx, grn_array* array, void function(groonga_d.groonga.grn_ctx* ctx, grn_array* array, uint id, void* func_arg) func, void* func_arg);

//GRN_API
uint grn_array_pull(groonga_d.groonga.grn_ctx* ctx, grn_array* array, ubyte blockp, void function(groonga_d.groonga.grn_ctx* ctx, grn_array* array, uint id, void* func_arg) func, void* func_arg);

//GRN_API
void grn_array_unblock(groonga_d.groonga.grn_ctx* ctx, grn_array* array);

//GRN_API
int grn_array_get_value(groonga_d.groonga.grn_ctx* ctx, grn_array* array, uint id, void* valuebuf);

//GRN_API
groonga_d.groonga.grn_rc grn_array_set_value(groonga_d.groonga.grn_ctx* ctx, grn_array* array, uint id, const (void)* value, int flags);

//GRN_API
grn_array_cursor* grn_array_cursor_open(groonga_d.groonga.grn_ctx* ctx, grn_array* array, uint min, uint max, int offset, int limit, int flags);

//GRN_API
uint grn_array_cursor_next(groonga_d.groonga.grn_ctx* ctx, grn_array_cursor* cursor);

//GRN_API
int grn_array_cursor_get_value(groonga_d.groonga.grn_ctx* ctx, grn_array_cursor* cursor, void** value);

//GRN_API
groonga_d.groonga.grn_rc grn_array_cursor_set_value(groonga_d.groonga.grn_ctx* ctx, grn_array_cursor* cursor, const (void)* value, int flags);

//GRN_API
groonga_d.groonga.grn_rc grn_array_cursor_delete(groonga_d.groonga.grn_ctx* ctx, grn_array_cursor* cursor, groonga_d.groonga.grn_table_delete_optarg* optarg);

//GRN_API
void grn_array_cursor_close(groonga_d.groonga.grn_ctx* ctx, grn_array_cursor* cursor);

//GRN_API
groonga_d.groonga.grn_rc grn_array_delete_by_id(groonga_d.groonga.grn_ctx* ctx, grn_array* array, uint id, groonga_d.groonga.grn_table_delete_optarg* optarg);

//GRN_API
uint grn_array_next(groonga_d.groonga.grn_ctx* ctx, grn_array* array, uint id);

//GRN_API
void* _grn_array_get_value(groonga_d.groonga.grn_ctx* ctx, grn_array* array, uint id);

/+
#define GRN_ARRAY_EACH(ctx, array, head, tail, id, value, block) grn_array_cursor *_sc = grn_array_cursor_open(ctx, array, head, tail, 0, -1, 0); if (_sc) { uint id; while ((id = grn_array_cursor_next(ctx, _sc))) { grn_array_cursor_get_value(ctx, _sc, (void **)(value)); block } grn_array_cursor_close(ctx, _sc); }

#define GRN_ARRAY_EACH_BEGIN(ctx, array, cursor, head, tail, id) do { grn_array_cursor *cursor; cursor = grn_array_cursor_open((ctx), (array), (head), (tail), 0, -1, 0); if (cursor) { uint id; while ((id = grn_array_cursor_next(ctx, cursor))) {

#define GRN_ARRAY_EACH_END(ctx, cursor) } grn_array_cursor_close(ctx, cursor); } } while (0)
+/
