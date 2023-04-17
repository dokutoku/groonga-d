/*
  Copyright(C) 2018 Brazil

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
module groonga.option;


private static import groonga.groonga;
private static import groonga.type;
private static import groonga.vector;

extern (C):
nothrow @nogc:

alias grn_option_revision = void*;

enum .grn_option_revision GRN_OPTION_REVISION_NONE = cast(.grn_option_revision)(0);
enum .grn_option_revision GRN_OPTION_REVISION_UNCHANGED = cast(.grn_option_revision)(1);

//ToDo: example
///
template GRN_OPTION_VALUES_EACH_BEGIN(string ctx, string option_values, string i, string name, string name_size)
{
	enum GRN_OPTION_VALUES_EACH_BEGIN =
	`
		do {
			groonga.groonga.grn_ctx* ctx_ = (` ~ ctx ~ `);

			groonga.groonga.grn_obj* option_values_ = (` ~ option_values ~ `);
			uint n_ = groonga.vector.grn_vector_size(ctx_, option_values_);

			uint i_ = void;
			const (char)* ` ~ name ~ ` = void;
			groonga.groonga.grn_id name_domain_ = void;

			for (i_ = 0; i_ < n_; i_ += 2) {
				uint ` ~ i ~ ` = i_ + 1;
				uint ` ~ name_size ~ ` = groonga.vector.grn_vector_get_element(ctx_, option_values_, i_, &` ~ name ~ `, null, &name_domain_);

				if (!groonga.type.grn_type_id_is_text_family(ctx_, name_domain_)) {
					continue;
				}
	`;
}

///Ditto
enum GRN_OPTION_VALUES_EACH_END =
`
		}
	} while (groonga.groonga.GRN_FALSE);
`;
