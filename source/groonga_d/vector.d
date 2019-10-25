/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2009-2018 Brazil

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
module groonga_d.vector;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

/+
#include <groonga.h>
+/

//GRN_API
uint grn_vector_size(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector);

//GRN_API
groonga_d.groonga.grn_rc grn_vector_add_element(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, const (char)* str, uint str_len, uint weight, uint domain);

//GRN_API
uint grn_vector_get_element(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, const (char)** str, uint* weight, uint* domain);

//GRN_API
ubyte grn_vector_get_element_bool(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, ubyte default_value);

//GRN_API
byte grn_vector_get_element_int8(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, byte default_value);

//GRN_API
ubyte grn_vector_get_element_uint8(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, ubyte default_value);

//GRN_API
short grn_vector_get_element_int16(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, short default_value);

//GRN_API
ushort grn_vector_get_element_uint16(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, ushort default_value);

//GRN_API
int grn_vector_get_element_int32(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, int default_value);

//GRN_API
uint grn_vector_get_element_uint32(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, uint default_value);

//GRN_API
long grn_vector_get_element_int64(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, long default_value);

//GRN_API
ulong grn_vector_get_element_uint64(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, uint offset, ulong default_value);

//GRN_API
uint grn_vector_pop_element(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* vector, const (char)** str, uint* weight, uint* domain);
