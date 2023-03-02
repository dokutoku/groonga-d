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
module groonga.command;


private static import groonga.groonga;

extern(C):
nothrow @nogc:

//#include <groonga/plugin.h>

extern struct _grn_command_input;
alias grn_command_input = ._grn_command_input;

//GRN_PLUGIN_EXPORT
export .grn_command_input* grn_command_input_open(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* command);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc grn_command_input_close(groonga.groonga.grn_ctx* ctx, .grn_command_input* input);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj* grn_command_input_add(groonga.groonga.grn_ctx* ctx, .grn_command_input* input, const (char)* name, int name_size, groonga.groonga.grn_bool* added);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj* grn_command_input_get(groonga.groonga.grn_ctx* ctx, .grn_command_input* input, const (char)* name, int name_size);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj* grn_command_input_at(groonga.groonga.grn_ctx* ctx, .grn_command_input* input, uint offset);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_obj* grn_command_input_get_arguments(groonga.groonga.grn_ctx* ctx, .grn_command_input* input);

/+
typedef void grn_command_run_func(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* command, .grn_command_input* input, void* user_data);
+/
alias grn_command_run_func = extern (C) void function(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* command, .grn_command_input* input, void* user_data);

/*
  grn_command_register() registers a command to the database which is
  associated with `ctx'. `command_name' and `command_name_size'
  specify the command name. Alphabetic letters ('A'-'Z' and 'a'-'z'),
  digits ('0'-'9') and an underscore ('_') are capable characters.

  `run' is called for running the command.

  grn_command_register() returns GRN_SUCCESS on success, an error
  code on failure.
 */

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc grn_command_register(groonga.groonga.grn_ctx* ctx, const (char)* command_name, int command_name_size, .grn_command_run_func* run, groonga.groonga.grn_expr_var* vars, uint n_vars, void* user_data);

//GRN_PLUGIN_EXPORT
export groonga.groonga.grn_rc grn_command_run(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* command, .grn_command_input* input);
