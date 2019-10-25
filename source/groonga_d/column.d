/*
  Copyright(C) 2009-2017 Brazil
  Copyright(C) 2018 Kouhei Sutou <kou@clear-code.com>

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
module groonga_d.column;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

extern struct _grn_column_cache;
alias grn_column_cache = _grn_column_cache;

//GRN_API
uint grn_column_get_flags(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* column);

//GRN_API
grn_column_cache* grn_column_cache_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* column);

//GRN_API
void grn_column_cache_close(groonga_d.groonga.grn_ctx* ctx, grn_column_cache* cache);

//GRN_API
void* grn_column_cache_ref(groonga_d.groonga.grn_ctx* ctx, grn_column_cache* cache, uint id, size_t* value_size);

//GRN_API
groonga_d.groonga.grn_rc grn_column_copy(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* from, groonga_d.groonga.grn_obj* to);
