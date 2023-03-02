/*
  Copyright(C) 2018 Brazil

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
module groonga.highlighter;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

extern struct _grn_highlighter;
alias grn_highlighter = ._grn_highlighter;

@GRN_API
.grn_highlighter* grn_highlighter_open(groonga.groonga.grn_ctx* ctx);

@GRN_API
groonga.groonga.grn_rc grn_highlighter_close(groonga.groonga.grn_ctx* ctx, .grn_highlighter* highlighter);

@GRN_API
groonga.groonga.grn_rc grn_highlighter_highlight(groonga.groonga.grn_ctx* ctx, .grn_highlighter* highlighter, const (char)* text, long text_length, groonga.groonga.grn_obj* output);

@GRN_API
groonga.groonga.grn_rc grn_highlighter_set_lexicon(groonga.groonga.grn_ctx* ctx, .grn_highlighter* highlighter, groonga.groonga.grn_obj* lexicon);

@GRN_API
groonga.groonga.grn_obj* grn_highlighter_get_lexicon(groonga.groonga.grn_ctx* ctx, .grn_highlighter* highlighter);

@GRN_API
groonga.groonga.grn_rc grn_highlighter_add_keyword(groonga.groonga.grn_ctx* ctx, .grn_highlighter* highlighter, const (char)* keyword, long keyword_length);

@GRN_API
groonga.groonga.grn_rc grn_highlighter_clear_keywords(groonga.groonga.grn_ctx* ctx, .grn_highlighter* highlighter);
