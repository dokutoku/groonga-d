/*
  Copyright (C) 2022  Sutou Kouhei <kou@clear-code.com>

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
module groonga.command_arguments;


private static import groonga.groonga;
private static import groonga.plugin;
private static import groonga.raw_string;
private static import groonga.table;
private static import std.string;

version (none):
nothrow @nogc:

extern (C++, grn) {
	struct CommandArgument
	{
		this(groonga.raw_string.grn_raw_string name, groonga.groonga.grn_obj* value)

			do
			{
				this.name = name;
				this.value = value;
			}

		groonga.raw_string.grn_raw_string name;
		groonga.groonga.grn_obj* value;
	}

	class CommandArguments
	{
		class Cursor
		{
		public:
			this(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_table_cursor* cursor)

				do
				{
					this.ctx_ = ctx;
					this.cursor_ = cursor;
					this.id_ = (cursor != null) ? (groonga.table.grn_table_cursor_next(this.ctx_, this.cursor_)) : (groonga.groonga.GRN_ID_NIL);
				}

			~this()

				do
				{
					if (this.cursor_ != null) {
						groonga.table.grn_table_cursor_close(this.ctx_, this.cursor_);
					}
				}

			/+
			Cursor &operator++()

				do
				{
					this.id_ = groonga.table.grn_table_cursor_next(this.ctx_, this.cursor_);

					return *this;
				}

			.CommandArgument operator*() const

				do
				{
					void* key = void;
					uint key_size = void;
					void* value = void;
					groonga.table.grn_table_cursor_get_key_value(this.ctx_, this.cursor_, &key, &key_size, &value);

					return .CommandArgument(groonga.raw_string.grn_raw_string(cast(const (char)*)(key), key_size), cast(groonga.groonga.grn_obj*)(value));
				}
			+/

			bool opUnary(string s)(ref Cursor other)
				if (s == "==")

				do
				{
					return this.id_ == other.id_;
				}

			bool opUnary(string s)(ref Cursor other)
				if (s == "!=")

				do
				{
					return this.id_ != other.id_;
				}

		private:
			groonga.groonga.grn_ctx* ctx_;
			groonga.groonga.grn_table_cursor* cursor_;
			groonga.groonga.grn_id id_;
		}

	public:
		this(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_user_data* user_data)

			do
			{
				this.ctx_ = ctx;
				this.user_data_ = user_data;
			}

		~this()

			do
			{
			}

		Cursor begin()

			do
			{
				groonga.groonga.grn_obj* vars = groonga.plugin.grn_plugin_proc_get_vars(this.ctx_, this.user_data_);
				groonga.groonga.grn_table_cursor* cursor = groonga.table.grn_table_cursor_open(this.ctx_, vars, null, 0, null, 0, 0, -1, groonga.table.GRN_CURSOR_ASCENDING);

				return new Cursor(this.ctx_, cursor);
			}

		Cursor end()

			do
			{
				return new Cursor(this.ctx_, null);
			}

		groonga.groonga.grn_obj* get(const (char)* prefix, const (char)* name, const (char)* fallback_name)

			do
			{
				string name_buffer = null;
				const (char)* full_name = void;

				if (prefix != null) {
					name_buffer = (std.string.fromStringz(prefix)).idup;
					name_buffer ~= (std.string.fromStringz(name)).idup;
					full_name = std.string.toStringz(name_buffer);
				} else {
					full_name = name;
				}

				groonga.groonga.grn_obj* arg = groonga.plugin.grn_plugin_proc_get_var(this.ctx_, this.user_data_, full_name, -1);

				if ((arg != null) && (groonga.groonga.GRN_TEXT_LEN(arg) > 0)) {
					return arg;
				}

				if (fallback_name != null) {
					const (char)* full_fallback_name = void;

					if (prefix != null) {
						name_buffer = (std.string.fromStringz(prefix)).idup;
						name_buffer ~= (std.string.fromStringz(fallback_name)).idup;
						full_fallback_name = std.string.toStringz(name_buffer);
					} else {
						full_fallback_name = fallback_name;
					}

					arg = groonga.plugin.grn_plugin_proc_get_var(this.ctx_, this.user_data_, full_fallback_name, -1);

					if ((arg != null) && (groonga.groonga.GRN_TEXT_LEN(arg) > 0)) {
						return arg;
					}
				}

				return arg;
			}

		groonga.groonga.grn_obj* get(const (char)* name)

			do
			{
				return this.get(null, name, null);
			}

		groonga.groonga.grn_obj* get(const (char)* prefix, const (char)* name)

			do
			{
				return this.get(prefix, name, null);
			}

		groonga.groonga.grn_obj* get(const (char)* prefix, const (char)* fallback_prefix, const (char)* name, const (char)* fallback_name)

			do
			{
				groonga.groonga.grn_obj* arg = this.get(prefix, name, fallback_name);

				if ((arg != null) && (groonga.groonga.GRN_TEXT_LEN(arg) > 0)) {
					return arg;
				}

				if (fallback_prefix == null) {
					return arg;
				}

				return this.get(fallback_prefix, name, fallback_name);
			}

		groonga.raw_string.grn_raw_string get_string(const (char)* name, groonga.raw_string.grn_raw_string default_value = default_string_value())

			do
			{
				return this.arg_to_string(this.get(name), default_value);
			}

		groonga.raw_string.grn_raw_string get_string(const (char)* prefix, const (char)* name, groonga.raw_string.grn_raw_string default_value = default_string_value())

			do
			{
				return this.arg_to_string(this.get(prefix, name), default_value);
			}

		groonga.raw_string.grn_raw_string get_string(const (char)* prefix, const (char)* name, const (char)* fallback_name, groonga.raw_string.grn_raw_string default_value = default_string_value())

			do
			{
				return this.arg_to_string(this.get(prefix, name, fallback_name), default_value);
			}

		groonga.raw_string.grn_raw_string get_string(const (char)* prefix, const (char)* fallback_prefix, const (char)* name, const (char)* fallback_name, groonga.raw_string.grn_raw_string default_value = default_string_value())

			do
			{
				return this.arg_to_string(this.get(prefix, fallback_prefix, name, fallback_name), default_value);
			}

		version (none)
		int get_int32(const (char)* name, int default_value)

			do
			{
				return this.arg_to_int32(this.get(name), default_value);
			}

		version (none)
		int get_int32(const (char)* prefix, const (char)* name, int default_value)

			do
			{
				return this.arg_to_int32(this.get(prefix, name), default_value);
			}

		version (none)
		int get_int32(const (char)* prefix, const (char)* name, const (char)* fallback_name, int default_value)

			do
			{
				return this.arg_to_int32(this.get(prefix, name, fallback_name), default_value);
			}

		version (none)
		int get_int32(const (char)* prefix, const (char)* fallback_prefix, const (char)* name, const (char)* fallback_name, int default_value)

			do
			{
				return this.arg_to_int32(this.get(prefix, fallback_prefix, name, fallback_name), default_value);
			}

	private:
		groonga.groonga.grn_ctx* ctx_;
		groonga.groonga.grn_user_data* user_data_;

		static groonga.raw_string.grn_raw_string default_string_value()

			do
			{
				return groonga.raw_string.grn_raw_string(null, 0);
			}

		groonga.raw_string.grn_raw_string arg_to_string(groonga.groonga.grn_obj* arg, return scope groonga.raw_string.grn_raw_string default_value)

			do
			{
				if ((arg != null) && (groonga.groonga.GRN_TEXT_LEN(arg) > 0)) {
					return groonga.raw_string.grn_raw_string(groonga.groonga.GRN_TEXT_VALUE(arg), groonga.groonga.GRN_TEXT_LEN(arg));
				} else {
					return default_value;
				}
			}

		int arg_to_int32(groonga.groonga.grn_obj* arg, int default_value);
	}
}
