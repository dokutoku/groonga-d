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
/**
 * License: LGPL-2.1
 */
module groonga.token_metadata;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

@GRN_API
size_t grn_token_metadata_get_size(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* metadata);

@GRN_API
groonga.groonga.grn_rc grn_token_metadata_at(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* metadata, size_t i, groonga.groonga.grn_obj* name, groonga.groonga.grn_obj* value);

@GRN_API
groonga.groonga.grn_rc grn_token_metadata_get(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* metadata, const (char)* name, int name_length, groonga.groonga.grn_obj* value);

@GRN_API
groonga.groonga.grn_rc grn_token_metadata_add(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* metadata, const (char)* name, int name_length, groonga.groonga.grn_obj* value);
