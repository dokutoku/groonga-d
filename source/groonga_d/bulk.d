/*
  Copyright(C) 2020-2021  Sutou Kouhei <kou@clear-code.com>

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
module groonga_d.bulk;


//#include <string>
private static import groonga_d.groonga;

extern (C++, grn) {
	/+
	class TextBulk
	{
public:
		this(groonga_d.groonga.grn_ctx* ctx)
		{
			this.ctx_ = ctx;
			groonga_d.groonga.GRN_TEXT_INIT(&this.bulk_, 0);
		}

		~this()
		{
			groonga_d.groonga.GRN_OBJ_FIN(this.ctx_, &this.bulk_);
		}

		groonga_d.groonga.grn_obj* operator*()
		{
			return &this.bulk_;
		}

		std::string value() {
			return std::string(groonga_d.groonga.GRN_TEXT_VALUE(&this.bulk_), groonga_d.groonga.GRN_TEXT_LEN(&this.bulk_));
		};

private:
		grn_ctx* ctx_;
		grn_obj bulk_;
	}
	+/
}
