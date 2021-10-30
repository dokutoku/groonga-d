/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2016  Brazil
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
module groonga_d.id;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

//GRN_API
groonga_d.groonga.grn_bool grn_id_is_builtin(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id);

//GRN_API
groonga_d.groonga.grn_bool grn_id_is_builtin_type(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id);

//GRN_API
bool grn_id_maybe_table(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id);
