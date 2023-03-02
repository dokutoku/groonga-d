/*
  Copyright(C) 2019 Brazil
  Copyright(C) 2019 Sutou Kouhei <kou@clear-code.com>

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
module groonga.index_column;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

@GRN_API
groonga.groonga.grn_rc grn_index_column_diff(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* index_column, groonga.groonga.grn_obj** diff);

@GRN_API
bool grn_index_column_is_usable(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* index_column, groonga.groonga.grn_operator op);
