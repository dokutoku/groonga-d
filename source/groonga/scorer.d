/*
  Copyright(C) 2015-2016  Brazil
  Copyright(C) 2020-2022  Sutou Kouhei <kou@clear-code.com>

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
module groonga.scorer;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern(C):
nothrow @nogc:

/+
#include <groonga/plugin.h>
+/

extern struct _grn_scorer_matched_record;
alias grn_scorer_matched_record = ._grn_scorer_matched_record;

@GRN_API
groonga.groonga.grn_obj* grn_scorer_matched_record_get_table(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
groonga.groonga.grn_obj* grn_scorer_matched_record_get_lexicon(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
groonga.groonga.grn_id grn_scorer_matched_record_get_id(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
groonga.groonga.grn_obj* grn_scorer_matched_record_get_terms(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
groonga.groonga.grn_obj* grn_scorer_matched_record_get_term_weights(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
uint grn_scorer_matched_record_get_total_term_weights(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
ulong grn_scorer_matched_record_get_n_documents(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
uint grn_scorer_matched_record_get_n_occurrences(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
ulong grn_scorer_matched_record_get_n_candidates(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
uint grn_scorer_matched_record_get_n_tokens(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
int grn_scorer_matched_record_get_weight(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

@GRN_API
groonga.groonga.grn_obj* grn_scorer_matched_record_get_arg(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record, uint i);

@GRN_API
uint grn_scorer_matched_record_get_n_args(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);


//typedef double grn_scorer_score_func(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);
alias grn_scorer_score_func = extern (C) nothrow @nogc double function(groonga.groonga.grn_ctx* ctx, .grn_scorer_matched_record* record);

/*
  grn_scorer_register() registers a plugin to the database which is
  associated with `ctx'. `scorer_name_ptr' and `scorer_name_length' specify the
  plugin name. Alphabetic letters ('A'-'Z' and 'a'-'z'), digits ('0'-'9') and
  an underscore ('_') are capable characters.

  `score' is called for scoring matched records one by one.

  grn_scorer_register() returns GRN_SUCCESS on success, an error
  code on failure.
 */

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc grn_scorer_register(groonga.groonga.grn_ctx* ctx, const (char)* scorer_name_ptr, int scorer_name_length, .grn_scorer_score_func* score);
