/*
  Copyright(C) 2009-2018  Brazil
  Copyright(C) 2020  Sutou Kouhei <kou@clear-code.com>

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
module groonga.posting;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

struct grn_posting
{
	groonga.groonga.grn_id rid;
	uint sid;
	uint pos;
	uint tf;
	uint weight;
	uint rest;
}

@GRN_API
.grn_posting* grn_posting_open(groonga.groonga.grn_ctx* ctx);

@GRN_API
void grn_posting_close(groonga.groonga.grn_ctx* ctx, .grn_posting* posting);

@GRN_API
groonga.groonga.grn_id grn_posting_get_record_id(groonga.groonga.grn_ctx* ctx, .grn_posting* posting);

@GRN_API
uint grn_posting_get_section_id(groonga.groonga.grn_ctx* ctx, .grn_posting* posting);

@GRN_API
uint grn_posting_get_position(groonga.groonga.grn_ctx* ctx, .grn_posting* posting);

@GRN_API
uint grn_posting_get_tf(groonga.groonga.grn_ctx* ctx, .grn_posting* posting);

@GRN_API
uint grn_posting_get_weight(groonga.groonga.grn_ctx* ctx, .grn_posting* posting);

@GRN_API
float grn_posting_get_weight_float(groonga.groonga.grn_ctx* ctx, .grn_posting* posting);

@GRN_API
uint grn_posting_get_rest(groonga.groonga.grn_ctx* ctx, .grn_posting* posting);

@GRN_API
void grn_posting_set_weight(groonga.groonga.grn_ctx* ctx, .grn_posting* posting, uint weight);

@GRN_API
void grn_posting_set_weight_float(groonga.groonga.grn_ctx* ctx, .grn_posting* posting, float weight);
