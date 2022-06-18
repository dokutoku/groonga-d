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
module groonga_d.config;


private static import groonga_d.groonga;
private static import groonga_d.table;

extern(C):
nothrow @nogc:

enum GRN_CONFIG_MAX_KEY_SIZE = groonga_d.table.GRN_TABLE_MAX_KEY_SIZE;

/* 1 is for '\0' */
enum GRN_CONFIG_MAX_VALUE_SIZE = .GRN_CONFIG_VALUE_SPACE_SIZE - uint.sizeof - 1;

enum GRN_CONFIG_VALUE_SPACE_SIZE = 4 * 1024;

//GRN_API
groonga_d.groonga.grn_rc grn_config_set(groonga_d.groonga.grn_ctx* ctx, const (char)* key, int key_size, const (char)* value, int value_size);

//GRN_API
groonga_d.groonga.grn_rc grn_config_get(groonga_d.groonga.grn_ctx* ctx, const (char)* key, int key_size, const (char)** value, uint* value_size);

//GRN_API
groonga_d.groonga.grn_rc grn_config_delete(groonga_d.groonga.grn_ctx* ctx, const (char)* key, int key_size);

//GRN_API
groonga_d.groonga.grn_obj* grn_config_cursor_open(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
groonga_d.groonga.grn_bool grn_config_cursor_next(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* cursor);

//GRN_API
uint grn_config_cursor_get_key(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* cursor, const (char)** key);

//GRN_API
uint grn_config_cursor_get_value(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* cursor, const (char)** value);

/* Deprecated since 5.1.2. Use GRN_CONFIG_* instead. */

enum GRN_CONF_MAX_KEY_SIZE = .GRN_CONFIG_MAX_KEY_SIZE;
enum GRN_CONF_MAX_VALUE_SIZE = .GRN_CONFIG_MAX_VALUE_SIZE;
enum GRN_CONF_VALUE_SPACE_SIZE = .GRN_CONFIG_VALUE_SPACE_SIZE;

//GRN_API
groonga_d.groonga.grn_rc grn_conf_set(groonga_d.groonga.grn_ctx* ctx, const (char)* key, int key_size, const (char)* value, int value_size);

//GRN_API
groonga_d.groonga.grn_rc grn_conf_get(groonga_d.groonga.grn_ctx* ctx, const (char)* key, int key_size, const (char)** value, uint* value_size);
