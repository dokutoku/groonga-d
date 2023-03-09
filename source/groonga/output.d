/*
  Copyright(C) 2009-2018  Brazil
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
module groonga.output;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:

alias grn_obj_format = ._grn_obj_format;

enum GRN_OBJ_FORMAT_WITH_COLUMN_NAMES = 0x01 << 0;
enum GRN_OBJ_FORMAT_AS_ARRAY = 0x01 << 3;
/* Deprecated since 4.0.1. It will be removed at 5.0.0.
   Use GRN_OBJ_FORMAT_AS_ARRAY instead.*/
enum GRN_OBJ_FORMAT_ASARRAY = .GRN_OBJ_FORMAT_AS_ARRAY;
enum GRN_OBJ_FORMAT_WITH_WEIGHT = 0x01 << 4;
/* Format weight as float32.
   Since 10.0.3 */
enum GRN_OBJ_FORMAT_WEIGHT_FLOAT32 = 0x01 << 5;
/* Call grn_ctx_output_flush() internally for each 1024 records in a table.
   The "1024" value may be changed.
   Since 10.0.3 */
enum GRN_OBJ_FORMAT_AUTO_FLUSH = 0x01 << 6;

struct _grn_obj_format
{
	groonga.groonga.grn_obj columns;
	const (void)* min;
	const (void)* max;
	uint min_size;
	uint max_size;
	int nhits;
	int offset;
	int limit;
	int hits_offset;
	uint flags;
	groonga.groonga.grn_obj* expression;
}

@GRN_API
groonga.groonga.grn_rc grn_output_range_normalize(groonga.groonga.grn_ctx* ctx, int size, int* offset, int* limit);

pragma(inline, true)
pure nothrow @trusted @nogc @live
void GRN_OBJ_FORMAT_INIT(scope .grn_obj_format* format, int format_nhits, int format_offset, int format_limit, int format_hits_offset)

	in
	{
		assert(format != null);
	}

	do
	{
		groonga.groonga.GRN_PTR_INIT(&(format.columns), groonga.groonga.GRN_OBJ_VECTOR, groonga.groonga.GRN_ID_NIL);
		format.nhits = format_nhits;
		format.offset = format_offset;
		format.limit = format_limit;
		format.hits_offset = format_hits_offset;
		format.flags = 0;
		format.expression = null;
	}

/* Deprecated since 10.0.0. Use grn_obj_format_fin() instead. */
alias GRN_OBJ_FORMAT_FIN = .grn_obj_format_fin;

@GRN_API
groonga.groonga.grn_rc grn_obj_format_fin(groonga.groonga.grn_ctx* ctx, .grn_obj_format* format);

@GRN_API
void grn_output_obj(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, groonga.groonga.grn_obj* obj, .grn_obj_format* format);

@GRN_API
void grn_output_envelope(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_rc rc, groonga.groonga.grn_obj* head, groonga.groonga.grn_obj* body_, groonga.groonga.grn_obj* foot, const (char)* file, int line);

@GRN_API
void grn_output_envelope_open(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* output);

@GRN_API
void grn_output_envelope_close(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* output, groonga.groonga.grn_rc rc, const (char)* file, int line);

@GRN_API
void grn_output_array_open(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, const (char)* name, int n_elements);

@GRN_API
void grn_output_array_close(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type);

@GRN_API
void grn_output_map_open(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, const (char)* name, int n_elements);

@GRN_API
void grn_output_map_close(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type);

@GRN_API
void grn_output_null(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type);

@GRN_API
void grn_output_int32(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, int value);

@GRN_API
void grn_output_uint32(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, uint value);

@GRN_API
void grn_output_int64(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, long value);

@GRN_API
void grn_output_uint64(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, ulong value);

@GRN_API
void grn_output_float32(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, float value);

@GRN_API
void grn_output_float(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, double value);

@GRN_API
void grn_output_cstr(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, const (char)* value);

@GRN_API
void grn_output_str(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, const (char)* value, size_t value_len);

@GRN_API
void grn_output_bool(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* outbuf, groonga.groonga.grn_content_type output_type, groonga.groonga.grn_bool value);

@GRN_API
void grn_ctx_output_flush(groonga.groonga.grn_ctx* ctx, int flags);

@GRN_API
void grn_ctx_output_array_open(groonga.groonga.grn_ctx* ctx, const (char)* name, int nelements);

@GRN_API
void grn_ctx_output_array_close(groonga.groonga.grn_ctx* ctx);

@GRN_API
void grn_ctx_output_map_open(groonga.groonga.grn_ctx* ctx, const (char)* name, int nelements);

@GRN_API
void grn_ctx_output_map_close(groonga.groonga.grn_ctx* ctx);

@GRN_API
void grn_ctx_output_null(groonga.groonga.grn_ctx* ctx);

@GRN_API
void grn_ctx_output_int32(groonga.groonga.grn_ctx* ctx, int value);

@GRN_API
void grn_ctx_output_uint32(groonga.groonga.grn_ctx* ctx, uint value);

@GRN_API
void grn_ctx_output_int64(groonga.groonga.grn_ctx* ctx, long value);

@GRN_API
void grn_ctx_output_uint64(groonga.groonga.grn_ctx* ctx, ulong value);

@GRN_API
void grn_ctx_output_float32(groonga.groonga.grn_ctx* ctx, float value);

@GRN_API
void grn_ctx_output_float(groonga.groonga.grn_ctx* ctx, double value);

@GRN_API
void grn_ctx_output_cstr(groonga.groonga.grn_ctx* ctx, const (char)* value);

@GRN_API
void grn_ctx_output_str(groonga.groonga.grn_ctx* ctx, const (char)* value, size_t value_len);

@GRN_API
void grn_ctx_output_bool(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_bool value);

@GRN_API
void grn_ctx_output_obj(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* value, .grn_obj_format* format);

@GRN_API
void grn_ctx_output_result_set_open(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* result_set, .grn_obj_format* format, uint n_additional_elements);

@GRN_API
void grn_ctx_output_result_set_close(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* result_set, .grn_obj_format* format);

@GRN_API
void grn_ctx_output_result_set(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* result_set, .grn_obj_format* format);

@GRN_API
void grn_ctx_output_table_columns(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, .grn_obj_format* format);

@GRN_API
void grn_ctx_output_table_records_open(groonga.groonga.grn_ctx* ctx, int n_records);

@GRN_API
void grn_ctx_output_table_records_content(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, .grn_obj_format* format);

@GRN_API
void grn_ctx_output_table_records_close(groonga.groonga.grn_ctx* ctx);

@GRN_API
void grn_ctx_output_table_records(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, .grn_obj_format* format);

@GRN_API
groonga.groonga.grn_content_type grn_ctx_get_output_type(groonga.groonga.grn_ctx* ctx);

@GRN_API
groonga.groonga.grn_rc grn_ctx_set_output_type(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_content_type type);

@GRN_API
const (char)* grn_ctx_get_mime_type(groonga.groonga.grn_ctx* ctx);

/* obsolete */

@GRN_API
groonga.groonga.grn_rc grn_text_otoj(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* bulk, groonga.groonga.grn_obj* obj, .grn_obj_format* format);
