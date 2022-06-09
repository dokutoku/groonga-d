/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2015-2016  Brazil
  Copyright(C) 2022  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.geo;


private static import groonga_d.groonga;
private static import groonga_d.posting;

extern(C):
nothrow @nogc:

struct grn_geo_point
{
	int latitude;
	int longitude;
}

//GRN_API
groonga_d.groonga.grn_rc grn_geo_select_in_rectangle(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index, groonga_d.groonga.grn_obj* top_left_point, groonga_d.groonga.grn_obj* bottom_right_point, groonga_d.groonga.grn_obj* res, groonga_d.groonga.grn_operator op);

//GRN_API
uint grn_geo_estimate_size_in_rectangle(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index, groonga_d.groonga.grn_obj* top_left_point, groonga_d.groonga.grn_obj* bottom_right_point);

/* Deprecated since 4.0.8. Use grn_geo_estimate_size_in_rectangle() instead. */
//GRN_API
int grn_geo_estimate_in_rectangle(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index, groonga_d.groonga.grn_obj* top_left_point, groonga_d.groonga.grn_obj* bottom_right_point);

//GRN_API
groonga_d.groonga.grn_obj* grn_geo_cursor_open_in_rectangle(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* index, groonga_d.groonga.grn_obj* top_left_point, groonga_d.groonga.grn_obj* bottom_right_point, int offset, int limit);

//GRN_API
groonga_d.posting.grn_posting* grn_geo_cursor_next(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* cursor);

//GRN_API
int grn_geo_table_sort(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, int offset, int limit, groonga_d.groonga.grn_obj* result, groonga_d.groonga.grn_obj* column, groonga_d.groonga.grn_obj* geo_point);
