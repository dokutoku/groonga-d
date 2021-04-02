/*
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
module groonga_d.smart_obj;


private static import groonga_d.groonga;

extern (C++, grn) {
/+
	class SharedObj
	{
	public:
		this(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj)
		{
			this.ctx_ = ctx;
			this.obj_ = obj;
		}

		this(groonga_d.groonga.grn_ctx* ctx, const (char)* name, int name_size)
		{
			this.ctx_ = ctx;
			this.obj_ = groonga_d.groonga.grn_ctx_get(this.ctx_, name, name_size);
		}

		this(groonga_d.groonga.grn_ctx* ctx, grn_id id)
		{
			this.ctx_ = ctx;
			this.obj_ = groonga_d.groonga.grn_ctx_at(this.ctx_, id);
		}

		this(SharedObj &&shared_obj)
		{
			this.ctx_ = shared_obj.ctx_;
			this.obj_(shared_obj.obj_);
			groonga_d.groonga.grn_obj_refer(this.ctx_, this.obj_);
		}

		~this()
		{
			if (this.obj_) {
				groonga_d.groonga.grn_obj_unref(this.ctx_, this.obj_);
			}
		}

		groonga_d.groonga.grn_obj* get()
		{
			return this.obj_;
		}

		groonga_d.groonga.grn_obj* release()
		{
			groonga_d.groonga.grn_obj* obj = this.obj_;
			this.obj_ = null;

			return obj;
		}

		void reset(groonga_d.groonga.grn_obj* obj)
		{
			this.obj_ = obj;
		}

	private:
		groonga_d.groonga.grn_ctx* ctx_;
		groonga_d.groonga.grn_obj* obj_;
	}

	class UniqueObj
	{
	public:
		this(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj)
		{
			this.ctx_ = ctx;
			this.obj_ = obj;
		}

		this(UniqueObj &&unique_obj)
		{
			this.ctx_ = unique_obj.ctx_;
			this.obj_ = unique_obj.obj_;
			unique_obj.obj_ = null;
		}

		~this()
		{
			if (this.obj_) {
				groonga_d.groonga.grn_obj_close(this.ctx_, this.obj_);
			}
		}

		groonga_d.groonga.grn_obj* get()
		{
			return this.obj_;
		}

		groonga_d.groonga.grn_obj* release()
		{
			groonga_d.groonga.grn_obj* obj = this.obj_;
			this.obj_ = null;

			return obj;
		}

		void reset(groonga_d.groonga.grn_obj* obj)
		{
			this.obj_ = obj;
		}

	private:
		groonga_d.groonga.grn_ctx* ctx_;
		groonga_d.groonga.grn_obj* obj_;
	}
+/
}
