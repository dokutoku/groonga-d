/*
  Copyright(C) 2019-2020  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.window_function_executor;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

extern struct _grn_window_function_executor;
alias grn_window_function_executor = _grn_window_function_executor;

//GRN_API
grn_window_function_executor* grn_window_function_executor_open(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_close(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_set_tag(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor, const (char)* tag, size_t tag_size);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_add_table(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor, groonga_d.groonga.grn_obj* table);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_add_context_table(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor, groonga_d.groonga.grn_obj* table);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_set_source(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor, const (char)* source, size_t source_size);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_set_sort_keys(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor, const (char)* sort_keys, size_t sort_keys_size);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_set_group_keys(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor, const (char)* group_keys, size_t group_keys_size);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_set_output_column_name(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor, const (char)* name, size_t name_size);

//GRN_API
groonga_d.groonga.grn_rc grn_window_function_executor_execute(groonga_d.groonga.grn_ctx* ctx, grn_window_function_executor* executor);
