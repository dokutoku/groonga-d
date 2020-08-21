/*
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
module groonga_d.result_set;


private static import groonga_d.groonga;
private static import groonga_d.hash;
private static import groonga_d.posting;

extern(C):
nothrow @nogc:

//GRN_API
groonga_d.groonga.grn_rc grn_result_set_add_record(groonga_d.groonga.grn_ctx* ctx, groonga_d.hash.grn_hash* result_set, groonga_d.posting.grn_posting* posting, groonga_d.groonga.grn_operator op);

//GRN_API
groonga_d.groonga.grn_rc grn_result_set_add_table(groonga_d.groonga.grn_ctx* ctx, groonga_d.hash.grn_hash* result_set, groonga_d.groonga.grn_obj* table, double score, groonga_d.groonga.grn_operator op);

//GRN_API
groonga_d.groonga.grn_rc grn_result_set_add_table_cursor(groonga_d.groonga.grn_ctx* ctx, groonga_d.hash.grn_hash* result_set, groonga_d.groonga.grn_table_cursor* cursor, double score, groonga_d.groonga.grn_operator op);
