/*
  Copyright(C) 2009-2016  Brazil
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
module groonga_d.dat;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

extern struct _grn_dat;
extern struct _grn_dat_cursor;

alias grn_dat = _grn_dat;
alias grn_dat_cursor = _grn_dat_cursor;
alias grn_dat_scan_hit = groonga_d.groonga._grn_table_scan_hit;

//GRN_API
int grn_dat_scan(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, const (char)* str, uint str_size, grn_dat_scan_hit* scan_hits, uint max_num_scan_hits, const (char)** str_rest);

//GRN_API
groonga_d.groonga.grn_id grn_dat_lcp_search(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, const (void)* key, uint key_size);

//GRN_API
grn_dat* grn_dat_create(groonga_d.groonga.grn_ctx* ctx, const (char)* path, uint key_size, uint value_size, uint flags);

//GRN_API
grn_dat* grn_dat_open(groonga_d.groonga.grn_ctx* ctx, const (char)* path);

//GRN_API
groonga_d.groonga.grn_rc grn_dat_close(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat);

//GRN_API
groonga_d.groonga.grn_rc grn_dat_remove(groonga_d.groonga.grn_ctx* ctx, const (char)* path);

//GRN_API
groonga_d.groonga.grn_id grn_dat_get(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, const (void)* key, uint key_size, void** value);

//GRN_API
groonga_d.groonga.grn_id grn_dat_add(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, const (void)* key, uint key_size, void** value, int* added);

//GRN_API
int grn_dat_get_key(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, groonga_d.groonga.grn_id id, void* keybuf, int bufsize);

//GRN_API
int grn_dat_get_key2(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, groonga_d.groonga.grn_id id, groonga_d.groonga.grn_obj* bulk);

//GRN_API
groonga_d.groonga.grn_rc grn_dat_delete_by_id(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, groonga_d.groonga.grn_id id, groonga_d.groonga.grn_table_delete_optarg* optarg);

//GRN_API
groonga_d.groonga.grn_rc grn_dat_delete(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, const (void)* key, uint key_size, groonga_d.groonga.grn_table_delete_optarg* optarg);

//GRN_API
groonga_d.groonga.grn_rc grn_dat_update_by_id(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, groonga_d.groonga.grn_id src_key_id, const (void)* dest_key, uint dest_key_size);

//GRN_API
groonga_d.groonga.grn_rc grn_dat_update(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, const (void)* src_key, uint src_key_size, const (void)* dest_key, uint dest_key_size);

//GRN_API
uint grn_dat_size(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat);

//GRN_API
grn_dat_cursor* grn_dat_cursor_open(groonga_d.groonga.grn_ctx* ctx, grn_dat* dat, const (void)* min, uint min_size, const (void)* max, uint max_size, int offset, int limit, int flags);

//GRN_API
groonga_d.groonga.grn_id grn_dat_cursor_next(groonga_d.groonga.grn_ctx* ctx, grn_dat_cursor* c);

//GRN_API
void grn_dat_cursor_close(groonga_d.groonga.grn_ctx* ctx, grn_dat_cursor* c);

//GRN_API
int grn_dat_cursor_get_key(groonga_d.groonga.grn_ctx* ctx, grn_dat_cursor* c, const (void)** key);

//GRN_API
groonga_d.groonga.grn_rc grn_dat_cursor_delete(groonga_d.groonga.grn_ctx* ctx, grn_dat_cursor* c, groonga_d.groonga.grn_table_delete_optarg* optarg);

//GRN_API
size_t grn_dat_cursor_get_max_n_records(groonga_d.groonga.grn_ctx* ctx, grn_dat_cursor* c);

/+
#define GRN_DAT_EACH(ctx, dat, id, key, key_size, block) grn_dat_cursor *_sc = grn_dat_cursor_open(ctx, dat, null, 0, null, 0, 0, -1, 0); if (_sc) { groonga_d.groonga.grn_id id; uint *_ks = (key_size); if (_ks) { while ((id = grn_dat_cursor_next(ctx, _sc))) { int _ks_raw = grn_dat_cursor_get_key(ctx, _sc, (const void **)(key)); *(_ks) = cast(uint)(_ks_raw); block } } else { while ((id = grn_dat_cursor_next(ctx, _sc))) { grn_dat_cursor_get_key(ctx, _sc, (const void **)(key)); block } } grn_dat_cursor_close(ctx, _sc); }
+/
