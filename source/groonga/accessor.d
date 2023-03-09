/*
  Copyright(C) 2012-2018  Brazil
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
module groonga.accessor;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

@GRN_API
groonga.groonga.grn_rc grn_accessor_resolve(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* accessor, int depth, groonga.groonga.grn_obj* base_res, groonga.groonga.grn_obj* res, groonga.groonga.grn_operator op);

@GRN_API
groonga.groonga.grn_id grn_accessor_resolve_id(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* accessor, groonga.groonga.grn_id id);

@GRN_API
uint grn_accessor_estimate_size_for_query(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* accessor, groonga.groonga.grn_obj* query, groonga.groonga.grn_search_optarg* optarg);

alias grn_accessor_execute_func = extern (C) groonga.groonga.grn_rc function(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* index, groonga.groonga.grn_operator op, groonga.groonga.grn_obj* res, groonga.groonga.grn_operator logical_op, void* user_data);

@GRN_API
groonga.groonga.grn_rc grn_accessor_execute(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* accessor, .grn_accessor_execute_func execute, void* execute_data, groonga.groonga.grn_operator execute_op, groonga.groonga.grn_obj* res, groonga.groonga.grn_operator logical_op);

@GRN_API
groonga.groonga.grn_rc grn_accessor_name(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* accessor, groonga.groonga.grn_obj* name);
