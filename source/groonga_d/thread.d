/* -*- c-basic-offset: 2 -*- */
/*
  Copyright(C) 2015-2016 Brazil
  Copyright(C) 2018 Kouhei Sutou <kou@clear-code.com>

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
module groonga_d.thread;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

//GRN_API
uint grn_thread_get_limit();

//GRN_API
void grn_thread_set_limit(uint new_limit);

//GRN_API
uint grn_thread_get_limit_with_ctx(groonga_d.groonga.grn_ctx* ctx);

//GRN_API
void grn_thread_set_limit_with_ctx(groonga_d.groonga.grn_ctx* ctx, uint new_limit);

alias grn_thread_get_limit_func = extern (C) nothrow @nogc uint function (void* data);

//GRN_API 
void grn_thread_set_get_limit_func(grn_thread_get_limit_func func, void* data);

alias grn_thread_set_limit_func = extern (C) nothrow @nogc void function (uint new_limit, void* data);

//GRN_API
void grn_thread_set_set_limit_func(grn_thread_set_limit_func func, void* data);

alias grn_thread_get_limit_with_ctx_func = extern (C) nothrow @nogc uint function (groonga_d.groonga.grn_ctx* ctx, void* data);

//GRN_API
void grn_thread_set_get_limit_with_ctx_func(grn_thread_get_limit_with_ctx_func func, void* data);

alias grn_thread_set_limit_with_ctx_func = extern (C) nothrow @nogc void function (groonga_d.groonga.grn_ctx* ctx, uint new_limit, void* data);

//GRN_API
void grn_thread_set_set_limit_with_ctx_func(grn_thread_set_limit_with_ctx_func func, void* data);
