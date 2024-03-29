/*
  Copyright(C) 2009-2018  Brazil
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
/**
 * License: LGPL-2.1
 */
module groonga.string_;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

/* grn_str: deprecated. use grn_string instead. */

struct grn_str
{
	const (char)* orig;
	char* norm;
	short* checks;
	ubyte* ctypes;
	int flags;
	uint orig_blen;
	uint norm_blen;
	uint length;
	groonga.groonga.grn_encoding encoding;
}

enum GRN_STR_REMOVEBLANK = 0x01 << 0;
enum GRN_STR_WITH_CTYPES = 0x01 << 1;
enum GRN_STR_WITH_CHECKS = 0x01 << 2;
enum GRN_STR_NORMALIZE = groonga.groonga.GRN_OBJ_KEY_NORMALIZE;

@GRN_API
.grn_str* grn_str_open(groonga.groonga.grn_ctx* ctx, const (char)* str, uint str_len, int flags);

@GRN_API
groonga.groonga.grn_rc grn_str_close(groonga.groonga.grn_ctx* ctx, .grn_str* nstr);

/* grn_string */

enum GRN_STRING_REMOVE_BLANK = 0x01 << 0;
enum GRN_STRING_WITH_TYPES = 0x01 << 1;
enum GRN_STRING_WITH_CHECKS = 0x01 << 2;
enum GRN_STRING_REMOVE_TOKENIZED_DELIMITER = 0x01 << 3;

enum groonga.groonga.grn_obj* GRN_NORMALIZER_AUTO = cast(groonga.groonga.grn_obj*)(1);

enum GRN_CHAR_BLANK = 0x80;

pragma(inline, true)
C GRN_CHAR_IS_BLANK(C)(C c)

	do
	{
		return c & .GRN_CHAR_BLANK;
	}

pragma(inline, true)
C GRN_CHAR_TYPE(C)(C c)

	do
	{
		return c & 0x7F;
	}

enum grn_char_type
{
	GRN_CHAR_NULL = 0,
	GRN_CHAR_ALPHA,
	GRN_CHAR_DIGIT,
	GRN_CHAR_SYMBOL,
	GRN_CHAR_HIRAGANA,
	GRN_CHAR_KATAKANA,
	GRN_CHAR_KANJI,
	GRN_CHAR_OTHERS,
	GRN_CHAR_EMOJI,
}

//Declaration name in C language
enum
{
	GRN_CHAR_NULL = .grn_char_type.GRN_CHAR_NULL,
	GRN_CHAR_ALPHA = .grn_char_type.GRN_CHAR_ALPHA,
	GRN_CHAR_DIGIT = .grn_char_type.GRN_CHAR_DIGIT,
	GRN_CHAR_SYMBOL = .grn_char_type.GRN_CHAR_SYMBOL,
	GRN_CHAR_HIRAGANA = .grn_char_type.GRN_CHAR_HIRAGANA,
	GRN_CHAR_KATAKANA = .grn_char_type.GRN_CHAR_KATAKANA,
	GRN_CHAR_KANJI = .grn_char_type.GRN_CHAR_KANJI,
	GRN_CHAR_OTHERS = .grn_char_type.GRN_CHAR_OTHERS,
	GRN_CHAR_EMOJI = .grn_char_type.GRN_CHAR_EMOJI,
}

@GRN_API
const (char)* grn_char_type_to_string(.grn_char_type type);

@GRN_API
groonga.groonga.grn_obj* grn_string_open(groonga.groonga.grn_ctx* ctx, const (char)* string_, uint length_in_bytes, groonga.groonga.grn_obj* lexicon_or_normalizer, int flags);

@GRN_API
groonga.groonga.grn_rc grn_string_get_original(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_, const (char)** original, uint* length_in_bytes);

@GRN_API
int grn_string_get_flags(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_);

@GRN_API
groonga.groonga.grn_rc grn_string_get_normalized(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_, const (char)** normalized, uint* length_in_bytes, uint* n_characters);

@GRN_API
groonga.groonga.grn_rc grn_string_set_normalized(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_, char* normalized, uint length_in_bytes, uint n_characters);

@GRN_API
const (short)* grn_string_get_checks(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_);

@GRN_API
groonga.groonga.grn_rc grn_string_set_checks(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_, short* checks);

@GRN_API
const (ubyte)* grn_string_get_types(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_);

@GRN_API
groonga.groonga.grn_rc grn_string_set_types(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_, ubyte* types);

@GRN_API
const (ulong)* grn_string_get_offsets(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_);

@GRN_API
groonga.groonga.grn_rc grn_string_set_offsets(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_, ulong* offsets);

@GRN_API
groonga.groonga.grn_encoding grn_string_get_encoding(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_);

@GRN_API
groonga.groonga.grn_obj* grn_string_get_table(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_);

@GRN_API
uint grn_string_get_normalizer_index(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* string_);

@GRN_API
int grn_charlen(groonga.groonga.grn_ctx* ctx, const (char)* str, const (char)* end);
