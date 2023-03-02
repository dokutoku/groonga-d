/*
  Copyright(C) 2016 Brazil

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
module groonga_d.dump;


private static import groonga_d.groonga;
private import groonga_d.groonga: GRN_API;

extern(C):
nothrow @nogc:

@GRN_API
groonga_d.groonga.grn_rc grn_dump_table_create_flags(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_table_flags flags, groonga_d.groonga.grn_obj* buffer);

@GRN_API
groonga_d.groonga.grn_rc grn_dump_column_create_flags(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_column_flags flags, groonga_d.groonga.grn_obj* buffer);
