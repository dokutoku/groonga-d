/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2015-2016 Brazil

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
module groonga_d.scorer;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

/+
#include <groonga/plugin.h>
+/

extern struct _grn_scorer_matched_record;
alias grn_scorer_matched_record = _grn_scorer_matched_record;

//GRN_API
groonga_d.groonga.grn_obj* grn_scorer_matched_record_get_table(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
groonga_d.groonga.grn_obj* grn_scorer_matched_record_get_lexicon(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
uint grn_scorer_matched_record_get_id(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
groonga_d.groonga.grn_obj* grn_scorer_matched_record_get_terms(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
groonga_d.groonga.grn_obj* grn_scorer_matched_record_get_term_weights(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
uint grn_scorer_matched_record_get_total_term_weights(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
ulong grn_scorer_matched_record_get_n_documents(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
uint grn_scorer_matched_record_get_n_occurrences(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
ulong grn_scorer_matched_record_get_n_candidates(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
uint grn_scorer_matched_record_get_n_tokens(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
int grn_scorer_matched_record_get_weight(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

//GRN_API
groonga_d.groonga.grn_obj* grn_scorer_matched_record_get_arg(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record, uint i);

//GRN_API
uint grn_scorer_matched_record_get_n_args(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);


//typedef double grn_scorer_score_func(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);
alias grn_scorer_score_func = extern (C) nothrow @nogc double function(groonga_d.groonga.grn_ctx* ctx, grn_scorer_matched_record* record);

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
export groonga_d.groonga.grn_rc grn_scorer_register(groonga_d.groonga.grn_ctx* ctx, const (char)* scorer_name_ptr, int scorer_name_length, grn_scorer_score_func* score);
