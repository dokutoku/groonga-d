/*
  Copyright(C) 2009-2017  Brazil
  Copyright(C) 2020  Sutou Kouhei <kou@clear-code.com>

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
module groonga.operator;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

private alias grn_operator_exec_func = extern (C) nothrow @nogc groonga.groonga.grn_bool function(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* x, groonga.groonga.grn_obj* y);

@GRN_API
const (char)* grn_operator_to_string(groonga.groonga.grn_operator op);

@GRN_API
const (char)* grn_operator_to_script_syntax(groonga.groonga.grn_operator op);

@GRN_API
.grn_operator_exec_func grn_operator_to_exec_func(groonga.groonga.grn_operator op);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_equal(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* x, groonga.groonga.grn_obj* y);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_not_equal(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* x, groonga.groonga.grn_obj* y);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_less(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* x, groonga.groonga.grn_obj* y);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_greater(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* x, groonga.groonga.grn_obj* y);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_less_equal(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* x, groonga.groonga.grn_obj* y);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_greater_equal(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* x, groonga.groonga.grn_obj* y);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_match(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* target, groonga.groonga.grn_obj* sub_text);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_prefix(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* target, groonga.groonga.grn_obj* prefix);

@GRN_API
groonga.groonga.grn_bool grn_operator_exec_regexp(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* target, groonga.groonga.grn_obj* pattern);
