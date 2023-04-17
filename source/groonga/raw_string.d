/*
  Copyright (C) 2016-2018  Brazil
  Copyright (C) 2019-2022  Sutou Kouhei <kou@clear-code.com>

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
module groonga.raw_string;


private static import core.stdc.string;
private static import groonga.groonga;
private static import groonga.portability;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

pragma(inline, true)
void GRN_RAW_STRING_INIT(ref .grn_raw_string string_)

	do
	{
		string_.value = null;
		string_.length = 0;
	}

pragma(inline, true)
void GRN_RAW_STRING_SET(ref .grn_raw_string string_, scope groonga.groonga.grn_obj* bulk)

	do
	{
		if ((bulk != null) && (groonga.groonga.GRN_TEXT_LEN(bulk) > 0)) {
			string_.value = groonga.groonga.GRN_TEXT_VALUE(bulk);
			string_.length = groonga.groonga.GRN_TEXT_LEN(bulk);
		} else {
			string_.value = null;
			string_.length = 0;
		}
	}

pragma(inline, true)
void GRN_RAW_STRING_SET_CSTRING(ref .grn_raw_string string_, const (char)* cstring)

	do
	{
		string_.value = cstring;
		string_.length = (cstring == null) ? (0) : (core.stdc.string.strlen(cstring));
	}

pragma(inline, true)
void GRN_RAW_STRING_FILL(ref .grn_raw_string string_, scope groonga.groonga.grn_obj* bulk)

	do
	{
		if ((bulk != null) && (groonga.groonga.GRN_TEXT_LEN(bulk) > 0)) {
			string_.value = groonga.groonga.GRN_TEXT_VALUE(bulk);
			string_.length = groonga.groonga.GRN_TEXT_LEN(bulk);
		}
	}

pragma(inline, true)
bool GRN_RAW_STRING_EQUAL(ref .grn_raw_string string_, ref .grn_raw_string other_string)

	do
	{
		return (string_.length == other_string.length) && (core.stdc.string.memcmp(string_.value, other_string.value, string_.length) == 0);
	}

pragma(inline, true)
bool GRN_RAW_STRING_EQUAL_CSTRING(ref .grn_raw_string string_, scope const char* cstring)

	do
	{
		return (cstring == null) ? (string_.length == 0) : ((string_.length == core.stdc.string.strlen(cstring)) && (core.stdc.string.memcmp(string_.value, cstring, string_.length) == 0));
	}

pragma(inline, true)
bool GRN_RAW_STRING_EQUAL_CSTRING_CI(ref .grn_raw_string string_, scope const char* cstring)

	do
	{
		return (cstring == null) ? (string_.length == 0) : ((string_.length == core.stdc.string.strlen(cstring)) && (groonga.portability.grn_strncasecmp(string_.value, cstring, string_.length) == 0));
	}

pragma(inline, true)
bool GRN_RAW_STRING_START_WITH_CSTRING(ref .grn_raw_string string_, scope const char* cstring)

	do
	{
		return (cstring == null) ? (true) : ((string_.length >= core.stdc.string.strlen(cstring)) && (core.stdc.string.memcmp(string_.value, cstring, core.stdc.string.strlen(cstring)) == 0));
	}

pragma(inline, true)
bool GRN_RAW_STRING_END_WITH_CSTRING(ref .grn_raw_string string_, scope const char* cstring)

	do
	{
		return (cstring == null) ? (true) : ((string_.length >= core.stdc.string.strlen(cstring)) && (core.stdc.string.memcmp(string_.value + string_.length - core.stdc.string.strlen(cstring), cstring, core.stdc.string.strlen(cstring)) == 0));
	}

struct grn_raw_string
{
	const (char)* value;
	size_t length;
}

@GRN_API
void grn_raw_string_lstrip(groonga.groonga.grn_ctx* ctx, .grn_raw_string* string_);

@GRN_API
bool grn_raw_string_have_sub_string(groonga.groonga.grn_ctx* ctx, .grn_raw_string* string_, .grn_raw_string* sub_string);

@GRN_API
bool grn_raw_string_have_sub_string_cstring(groonga.groonga.grn_ctx* ctx, .grn_raw_string* string_, const (char)* sub_cstring);

@GRN_API
.grn_raw_string grn_raw_string_substring(groonga.groonga.grn_ctx* ctx, const (.grn_raw_string)* string_, size_t start, long length);
