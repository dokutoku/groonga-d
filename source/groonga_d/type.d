/*
  Copyright(C) 2009-2016  Brazil
  Copyright(C) 2020-2022  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.type;


private static import groonga_d.groonga;
private import groonga_d.groonga: GRN_API;

extern(C):
nothrow @nogc:

/**
 * Just for backward compatibility.
 * Use grn_type_id_is_text_family() instead.
 */
pragma(inline, true)
groonga_d.groonga.grn_bool GRN_TYPE_IS_TEXT_FAMILY(groonga_d.groonga.grn_id type)

	do
	{
		return .grn_type_id_is_text_family(null, type);
	}

@GRN_API
groonga_d.groonga.grn_bool grn_type_id_is_builtin(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id);

@GRN_API
groonga_d.groonga.grn_bool grn_type_id_is_number_family(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id);

@GRN_API
bool grn_type_id_is_float_family(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id);

@GRN_API
groonga_d.groonga.grn_bool grn_type_id_is_text_family(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id);

@GRN_API
bool grn_type_id_is_compatible(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id1, groonga_d.groonga.grn_id id2);

@GRN_API
size_t grn_type_id_size(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_id id);

@GRN_API
groonga_d.groonga.grn_obj* grn_type_create(groonga_d.groonga.grn_ctx* ctx, const (char)* name, uint name_size, groonga_d.groonga.grn_obj_flags flags, uint size);

@GRN_API
uint grn_type_size(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* type);
