/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2012-2018 Brazil

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
module groonga_d.tokenizer_query_deprecated;


private static import groonga_d.groonga;
private static import groonga_d.token;

extern(C):
nothrow @nogc:
deprecated:

/+
#include <groonga/plugin.h>
+/
/*
  grn_tokenizer_query is a structure for storing a query. See the following
  functions.

  Deprecated since 8.0.2. Use accessors to get data.
 */
alias grn_tokenizer_query = _grn_tokenizer_query_deprecated;

struct _grn_tokenizer_query_deprecated
{
	groonga_d.groonga.grn_obj* normalized_query;
	char* query_buf;

	const (char)* ptr_;

	deprecated
	alias ptr = ptr_;

	uint length;
	groonga_d.groonga.grn_encoding encoding;
	uint flags;
	ubyte have_tokenized_delimiter;
	/* Deprecated since 4.0.8. Use tokenize_mode instead. */
	groonga_d.token.grn_token_mode token_mode;
	groonga_d.token.grn_tokenize_mode tokenize_mode;
}
