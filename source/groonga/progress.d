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
module groonga.progress;


private static import groonga.groonga;
private import groonga.groonga: GRN_API;

extern (C):
nothrow @nogc:


enum grn_progress_type
{
	GRN_PROGRESS_INDEX,
}

//Declaration name in C language
enum
{
	GRN_PROGRESS_INDEX = .grn_progress_type.GRN_PROGRESS_INDEX,
}

enum grn_progress_index_phase
{
	GRN_PROGRESS_INDEX_INVALID,
	GRN_PROGRESS_INDEX_INITIALIZE,
	GRN_PROGRESS_INDEX_LOAD,
	GRN_PROGRESS_INDEX_COMMIT,
	GRN_PROGRESS_INDEX_FINALIZE,
	GRN_PROGRESS_INDEX_DONE,
}

//Declaration name in C language
enum
{
	GRN_PROGRESS_INDEX_INVALID = .grn_progress_index_phase.GRN_PROGRESS_INDEX_INVALID,
	GRN_PROGRESS_INDEX_INITIALIZE = .grn_progress_index_phase.GRN_PROGRESS_INDEX_INITIALIZE,
	GRN_PROGRESS_INDEX_LOAD = .grn_progress_index_phase.GRN_PROGRESS_INDEX_LOAD,
	GRN_PROGRESS_INDEX_COMMIT = .grn_progress_index_phase.GRN_PROGRESS_INDEX_COMMIT,
	GRN_PROGRESS_INDEX_FINALIZE = .grn_progress_index_phase.GRN_PROGRESS_INDEX_FINALIZE,
	GRN_PROGRESS_INDEX_DONE = .grn_progress_index_phase.GRN_PROGRESS_INDEX_DONE,
}

struct _grn_progress;
alias grn_progress = ._grn_progress;

@GRN_API
.grn_progress_type grn_progress_get_type(groonga.groonga.grn_ctx* ctx, .grn_progress* progress);

@GRN_API
.grn_progress_index_phase grn_progress_index_get_phase(groonga.groonga.grn_ctx* ctx, .grn_progress* progress);

@GRN_API
uint grn_progress_index_get_n_target_records(groonga.groonga.grn_ctx* ctx, .grn_progress* progress);

@GRN_API
uint grn_progress_index_get_n_processed_records(groonga.groonga.grn_ctx* ctx, .grn_progress* progress);

@GRN_API
uint grn_progress_index_get_n_target_terms(groonga.groonga.grn_ctx* ctx, .grn_progress* progress);

@GRN_API
uint grn_progress_index_get_n_processed_terms(groonga.groonga.grn_ctx* ctx, .grn_progress* progress);

alias grn_progress_callback_func = void function(groonga.groonga.grn_ctx* ctx, .grn_progress* progress, void* user_data);

@GRN_API
groonga.groonga.grn_rc grn_ctx_set_progress_callback(groonga.groonga.grn_ctx* ctx, .grn_progress_callback_func func, void* user_data);

@GRN_API
.grn_progress_callback_func grn_ctx_get_progress_callback(groonga.groonga.grn_ctx* ctx);
