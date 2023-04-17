/*
  Copyright(C) 2014-2016 Brazil

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
module groonga.request_canceler;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

@GRN_API
void grn_request_canceler_register(groonga.groonga.grn_ctx* ctx, const (char)* request_id, uint size);

@GRN_API
void grn_request_canceler_unregister(groonga.groonga.grn_ctx* ctx, const (char)* request_id, uint size);

@GRN_API
groonga.groonga.grn_bool grn_request_canceler_cancel(const (char)* request_id, uint size);

@GRN_API
groonga.groonga.grn_bool grn_request_canceler_cancel_all();
