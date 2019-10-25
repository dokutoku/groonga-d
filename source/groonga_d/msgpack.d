/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2018 Brazil

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
module groonga_d.msgpack;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

/+
#include <groonga.h>
#include <msgpack.h>
+/

enum GRN_MSGPACK_OBJECT_EXT_TIME = 0;

/+
groonga_d.groonga.grn_rc grn_msgpack_pack_raw(groonga_d.groonga.grn_ctx* ctx, msgpack_packer* packer, const (char)* value, uint value_size, uint value_domain);

groonga_d.groonga.grn_rc grn_msgpack_pack(groonga_d.groonga.grn_ctx* ctx, msgpack_packer* packer, groonga_d.groonga.grn_obj* value);

groonga_d.groonga.grn_rc grn_msgpack_unpack_array(groonga_d.groonga.grn_ctx* ctx, msgpack_object_array* array, groonga_d.groonga.grn_obj* vector);
+/

/+
# if MSGPACK_VERSION_MAJOR >= 1
	long grn_msgpack_unpack_ext_time(groonga_d.groonga.grn_ctx* ctx, msgpack_object_ext* ext);
# endif /* MSGPACK_VERSION_MAJOR >= 1 */
+/
