/*
  Copyright(C) 2021  Sutou Kouhei <kou@clear-code.com>

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
module groonga.wal;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

enum grn_wal_role
{
	/*
	 * Don't do any WAL related tasks. This is the default for backward
	 * compatibility.
	 */
	GRN_WAL_ROLE_NONE,

	/*
	 * Record WAL and recover from WAL. The only one thread can be primary.
	 */
	GRN_WAL_ROLE_PRIMARY,

	/*
	 * Only record WAL. Multiple threads/processes can be secondary.
	 */
	GRN_WAL_ROLE_SECONDARY,
}

//Declaration name in C language
enum
{
	GRN_WAL_ROLE_NONE = .grn_wal_role.GRN_WAL_ROLE_NONE,
	GRN_WAL_ROLE_PRIMARY = .grn_wal_role.GRN_WAL_ROLE_PRIMARY,
	GRN_WAL_ROLE_SECONDARY = .grn_wal_role.GRN_WAL_ROLE_SECONDARY,
}

@GRN_API
groonga.groonga.grn_rc grn_ctx_set_wal_role(groonga.groonga.grn_ctx* ctx, .grn_wal_role role);

@GRN_API
.grn_wal_role grn_ctx_get_wal_role(groonga.groonga.grn_ctx* ctx);
