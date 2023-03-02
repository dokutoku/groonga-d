/*
  Copyright(C) 2015-2018  Brazil
  Copyright(C) 2018-2022  Sutou Kouhei <kou@clear-code.com>

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
module groonga.cast_;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;
public import groonga.option;

extern(C):
nothrow @nogc:

struct grn_caster
{
	groonga.groonga.grn_obj* src;
	groonga.groonga.grn_obj* dest;
	uint flags;
	groonga.groonga.grn_obj* target;
}

@GRN_API
groonga.groonga.grn_rc grn_caster_cast(groonga.groonga.grn_ctx* ctx, .grn_caster* caster);

@GRN_API
groonga.groonga.grn_rc grn_obj_cast(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* src, groonga.groonga.grn_obj* dest, groonga.groonga.grn_bool add_record_if_not_exist);
