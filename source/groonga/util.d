/*
  Copyright(C) 2010-2017 Brazil

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
module groonga.util;


private static import groonga.geo;
private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

@GRN_API
groonga.groonga.grn_obj* grn_inspect(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* buffer, groonga.groonga.grn_obj* obj);

@GRN_API
groonga.groonga.grn_obj* grn_inspect_indented(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* buffer, groonga.groonga.grn_obj* obj, const (char)* indent);

@GRN_API
groonga.groonga.grn_obj* grn_inspect_limited(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* buffer, groonga.groonga.grn_obj* obj);

@GRN_API
groonga.groonga.grn_obj* grn_inspect_name(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* buffer, groonga.groonga.grn_obj* obj);

@GRN_API
groonga.groonga.grn_obj* grn_inspect_encoding(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* buffer, groonga.groonga.grn_encoding encoding);

@GRN_API
groonga.groonga.grn_obj* grn_inspect_type(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* buffer, ubyte type);

@GRN_API
groonga.groonga.grn_obj* grn_inspect_query_log_flags(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* buffer, uint flags);

@GRN_API
groonga.groonga.grn_obj* grn_inspect_key(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* buffer, groonga.groonga.grn_obj* table, const (void)* key, uint key_size);

@GRN_API
void grn_p(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* obj);

@GRN_API
void grn_p_geo_point(groonga.groonga.grn_ctx* ctx, groonga.geo.grn_geo_point* point);

@GRN_API
void grn_p_ii_values(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* obj);
