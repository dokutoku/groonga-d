/*
  Copyright(C) 2016 Brazil
  Copyright(C) 2019 Kouhei Sutou <kou@clear-code.com>

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License version 2.1 as published by the Free Software Foundation.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/
module groonga_d.window_function;


private static import groonga_d.groonga;
private static import groonga_d.table;

extern(C):
nothrow @nogc:

enum grn_window_direction
{
	GRN_WINDOW_DIRECTION_ASCENDING,
	GRN_WINDOW_DIRECTION_DESCENDING,
}

//Declaration name in C language
enum
{
	GRN_WINDOW_DIRECTION_ASCENDING = .grn_window_direction.GRN_WINDOW_DIRECTION_ASCENDING,
	GRN_WINDOW_DIRECTION_DESCENDING = .grn_window_direction.GRN_WINDOW_DIRECTION_DESCENDING,
}

extern struct _grn_window;
alias grn_window = _grn_window;

//GRN_API
groonga_d.groonga.grn_id grn_window_next(groonga_d.groonga.grn_ctx* ctx, grn_window* window);

//GRN_API
groonga_d.groonga.grn_rc grn_window_rewind(groonga_d.groonga.grn_ctx* ctx, grn_window* window);

//GRN_API
groonga_d.groonga.grn_rc grn_window_set_direction(groonga_d.groonga.grn_ctx* ctx, grn_window* window, grn_window_direction direction);

//GRN_API
groonga_d.groonga.grn_obj* grn_window_get_table(groonga_d.groonga.grn_ctx* ctx, grn_window* window);

//GRN_API
bool grn_window_is_context_table(groonga_d.groonga.grn_ctx* ctx, grn_window* window);

//GRN_API
groonga_d.groonga.grn_obj* grn_window_get_output_column(groonga_d.groonga.grn_ctx* ctx, grn_window* window);

//GRN_API
size_t grn_window_get_n_arguments(groonga_d.groonga.grn_ctx* ctx, grn_window* window);

//GRN_API
groonga_d.groonga.grn_obj* grn_window_get_argument(groonga_d.groonga.grn_ctx* ctx, grn_window* window, size_t i);

//GRN_API
bool grn_window_is_sorted(groonga_d.groonga.grn_ctx* ctx, grn_window* window);


//GRN_API
ubyte grn_window_is_sorted(groonga_d.groonga.grn_ctx* ctx, grn_window* window);

//GRN_API
size_t grn_window_get_size(groonga_d.groonga.grn_ctx* ctx, grn_window* window);

struct _grn_window_definition
{
	groonga_d.table.grn_table_sort_key* sort_keys;
	size_t n_sort_keys;
	groonga_d.table.grn_table_sort_key* group_keys;
	size_t n_group_keys;
}

alias grn_window_definition = ._grn_window_definition;

//typedef groonga_d.groonga.grn_rc grn_window_function_func(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* first_output_column, grn_window* window, groonga_d.groonga.grn_obj** first_args, int first_n_args);
alias grn_window_function_func = extern (C) nothrow @nogc groonga_d.groonga.grn_rc function(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* first_output_column, grn_window* window, groonga_d.groonga.grn_obj** first_args, int first_n_args);

//GRN_API
groonga_d.groonga.grn_obj* grn_window_function_create(groonga_d.groonga.grn_ctx* ctx, const (char)* name, int name_size, grn_window_function_func* func);

/* Deprecated since 9.0.2.
   Use grn_window_function_executor() instead. */
//GRN_API
deprecated
groonga_d.groonga.grn_rc grn_table_apply_window_function(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, groonga_d.groonga.grn_obj* output_column, grn_window_definition* definition, groonga_d.groonga.grn_obj* window_function_call);
