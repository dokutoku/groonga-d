/*
  Copyright(C) 2009-2018 Brazil
  Copyright(C) 2018 Kouhei Sutou <kou@clear-code.com>

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
module groonga_d.output;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

alias grn_obj_format = _grn_obj_format;

enum GRN_OBJ_FORMAT_WITH_COLUMN_NAMES = 0x01 << 0;
enum GRN_OBJ_FORMAT_AS_ARRAY = 0x01 << 3;
/* Deprecated since 4.0.1. It will be removed at 5.0.0.
   Use GRN_OBJ_FORMAT_AS_ARRAY instead.*/
enum GRN_OBJ_FORMAT_ASARRAY = GRN_OBJ_FORMAT_AS_ARRAY;
enum GRN_OBJ_FORMAT_WITH_WEIGHT = 0x01 << 4;

struct _grn_obj_format
{
	groonga_d.groonga.grn_obj columns;
	const (void)* min;
	const (void)* max;
	uint min_size;
	uint max_size;
	int nhits;
	int offset;
	int limit;
	int hits_offset;
	int flags;
	groonga_d.groonga.grn_obj* expression;
}

//GRN_API
groonga_d.groonga.grn_rc grn_output_range_normalize(groonga_d.groonga.grn_ctx* ctx, int size, int* offset, int* limit);

/+
#define GRN_OBJ_FORMAT_INIT(format, format_nhits, format_offset, format_limit, format_hits_offset) GRN_PTR_INIT(&(format)->columns, groonga_d.groonga.GRN_OBJ_VECTOR, groonga_d.groonga.GRN_ID_NIL); (format)->nhits = (format_nhits); (format)->offset = (format_offset); (format)->limit = (format_limit); (format)->hits_offset = (format_hits_offset); (format)->flags = 0; (format)->expression = null;

#define GRN_OBJ_FORMAT_FIN(ctx, format) int ncolumns = groonga_d.groonga.GRN_BULK_VSIZE(&(format)->columns) / sizeof(groonga_d.groonga.grn_obj *); groonga_d.groonga.grn_obj **columns = (groonga_d.groonga.grn_obj **)groonga_d.groonga.GRN_BULK_HEAD(&(format)->columns); while (ncolumns--) { groonga_d.groonga.grn_obj *column = *columns; columns++; if (grn_obj_is_accessor((ctx), column)) { grn_obj_close((ctx), column); } } GRN_OBJ_FIN((ctx), &(format)->columns); if ((format)->expression) { GRN_OBJ_FIN((ctx), (format)->expression); }
+/

//GRN_API
void grn_output_obj(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, groonga_d.groonga.grn_obj* obj, grn_obj_format* format);

//GRN_API
void grn_output_envelope(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_rc rc, groonga_d.groonga.grn_obj* head, groonga_d.groonga.grn_obj* body, groonga_d.groonga.grn_obj* foot, const (char)* file, int line);

//GRN_API
void grn_output_array_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, const (char)* name, int n_elements);

//GRN_API
void grn_output_array_close(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type);

//GRN_API
void grn_output_map_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, const (char)* name, int n_elements);

//GRN_API
void grn_output_map_close(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type);

//GRN_API
void grn_output_null(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type);

//GRN_API
void grn_output_int32(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, int value);

//GRN_API
void grn_output_uint32(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, uint value);

//GRN_API
void grn_output_int64(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, long value);

//GRN_API
void grn_output_uint64(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, ulong value);

//GRN_API
void grn_output_float(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, double value);

//GRN_API
void grn_output_cstr(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, const (char)* value);

//GRN_API
void grn_output_str(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, const (char)* value, size_t value_len);

//GRN_API
void grn_output_bool(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* outbuf, groonga_d.groonga.grn_content_type output_type, ubyte value);

//GRN_API
void grn_ctx_output_flush(groonga_d.groonga.grn_ctx* ctx, int flags);

//GRN_API
void grn_ctx_output_array_open(groonga_d.groonga.grn_ctx* ctx, const (char)* name, int nelements);

//GRN_API
void grn_ctx_output_array_close(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
void grn_ctx_output_map_open(groonga_d.groonga.grn_ctx* ctx, const (char)* name, int nelements);

//GRN_API
void grn_ctx_output_map_close(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
void grn_ctx_output_null(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
void grn_ctx_output_int32(groonga_d.groonga.grn_ctx* ctx, int value);

//GRN_API
void grn_ctx_output_uint32(groonga_d.groonga.grn_ctx* ctx, uint value);

//GRN_API
void grn_ctx_output_int64(groonga_d.groonga.grn_ctx* ctx, long value);

//GRN_API
void grn_ctx_output_uint64(groonga_d.groonga.grn_ctx* ctx, ulong value);

//GRN_API
void grn_ctx_output_float(groonga_d.groonga.grn_ctx* ctx, double value);

//GRN_API
void grn_ctx_output_cstr(groonga_d.groonga.grn_ctx* ctx, const (char)* value);

//GRN_API
void grn_ctx_output_str(groonga_d.groonga.grn_ctx* ctx, const (char)* value, uint value_len);

//GRN_API
void grn_ctx_output_bool(groonga_d.groonga.grn_ctx* ctx, ubyte value);

//GRN_API
void grn_ctx_output_obj(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* value, grn_obj_format* format);

//GRN_API
void grn_ctx_output_result_set_open(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* result_set, grn_obj_format* format, uint n_additional_elements);

//GRN_API
void grn_ctx_output_result_set_close(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* result_set, grn_obj_format* format);

//GRN_API
void grn_ctx_output_result_set(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* result_set, grn_obj_format* format);

//GRN_API
void grn_ctx_output_table_columns(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, grn_obj_format* format);

//GRN_API
void grn_ctx_output_table_records(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* table, grn_obj_format* format);

//GRN_API
groonga_d.groonga.grn_content_type grn_ctx_get_output_type(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
groonga_d.groonga.grn_rc grn_ctx_set_output_type(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_content_type type);

//GRN_API
const (char)* grn_ctx_get_mime_type(groonga_d.groonga.grn_ctx* ctx);

/* obsolete */

//GRN_API
groonga_d.groonga.grn_rc grn_text_otoj(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* bulk, groonga_d.groonga.grn_obj* obj, grn_obj_format* format);