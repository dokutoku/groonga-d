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
/**
 * License: LGPL-2.1
 */
module groonga.id;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

@GRN_API
groonga.groonga.grn_bool grn_id_is_builtin(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_id id);

@GRN_API
groonga.groonga.grn_bool grn_id_is_builtin_type(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_id id);

@GRN_API
bool grn_id_maybe_table(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_id id);
