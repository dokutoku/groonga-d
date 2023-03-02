/*
  Copyright(C) 2017  Brazil
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
module groonga.arrow;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

@GRN_API
groonga.groonga.grn_rc grn_arrow_load(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, const (char)* path);

@GRN_API
groonga.groonga.grn_rc grn_arrow_dump(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, const (char)* path);

@GRN_API
groonga.groonga.grn_rc grn_arrow_dump_columns(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* table, groonga.groonga.grn_obj* columns, const (char)* path);

extern (C++, grn) {
	extern (C++, arrow) {
		/+
		class ArrayBuilder
		{
public:
			this(groonga.groonga.grn_ctx* ctx);
			~this();

			::arrow::Status add_column(groonga.groonga.grn_obj* column, groonga.groonga.grn_table_cursor* cursor);
			::arrow::Result<std::shared_ptr<::arrow::Array>> finish();

private:
			struct Impl;
			std::unique_ptr<Impl> impl_;
		}
		+/
	}
}
