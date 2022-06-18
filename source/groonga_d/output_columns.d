/*
  Copyright(C) 2018 Kouhei Sutou <kou@clear-code.com>

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
module groonga_d.output_columns;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

//GRN_API
groonga_d.groonga.grn_obj* grn_output_columns_parse(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, const (char)* raw_output_columns, size_t raw_output_columns_size);

//GRN_API
groonga_d.groonga.grn_rc grn_output_columns_apply(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* output_columns, groonga_d.groonga.grn_obj* columns);
