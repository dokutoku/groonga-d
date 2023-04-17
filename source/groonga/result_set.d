/*
  Copyright(C) 2020-2022  Sutou Kouhei <kou@clear-code.com>

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
/**
 * License: LGPL-2.1
 */
module groonga.result_set;


private static import groonga.groonga;
private static import groonga.hash;
private static import groonga.ii;
private static import groonga.posting;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

@GRN_API
groonga.groonga.grn_id grn_result_set_get_min_id(groonga.groonga.grn_ctx* ctx, groonga.hash.grn_hash* result_set);

@GRN_API
groonga.groonga.grn_rc grn_result_set_add_record(groonga.groonga.grn_ctx* ctx, groonga.hash.grn_hash* result_set, groonga.posting.grn_posting* posting, groonga.groonga.grn_operator op);

@GRN_API
groonga.groonga.grn_rc grn_result_set_add_table(groonga.groonga.grn_ctx* ctx, groonga.hash.grn_hash* result_set, groonga.groonga.grn_obj* table, double score, groonga.groonga.grn_operator op);

@GRN_API
groonga.groonga.grn_rc grn_result_set_add_table_cursor(groonga.groonga.grn_ctx* ctx, groonga.hash.grn_hash* result_set, groonga.groonga.grn_table_cursor* cursor, double score, groonga.groonga.grn_operator op);

@GRN_API
groonga.groonga.grn_rc grn_result_set_add_index_cursor(groonga.groonga.grn_ctx* ctx, groonga.hash.grn_hash* result_set, groonga.groonga.grn_obj* cursor, double additional_score, double weight, groonga.groonga.grn_operator op);

@GRN_API
groonga.groonga.grn_rc grn_result_set_add_ii_cursor(groonga.groonga.grn_ctx* ctx, groonga.hash.grn_hash* result_set, groonga.ii.grn_ii_cursor* cursor, double additional_score, double weight, groonga.groonga.grn_operator op);

@GRN_API
groonga.groonga.grn_rc grn_result_set_copy(groonga.groonga.grn_ctx* ctx, groonga.hash.grn_hash* result_set, groonga.hash.grn_hash* output_result_set);
