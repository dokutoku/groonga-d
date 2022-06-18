/*
  Copyright(C) 2015-2017 Brazil

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
module groonga_d.portability;


private static import core.stdc.stdarg;
private static import core.stdc.stdio;
private static import core.stdc.stdlib;
private static import core.stdc.string;
private static import core.stdc.time;
private static import core.sys.posix.fcntl;
private static import core.sys.posix.stdio;
private static import core.sys.posix.strings;
private static import core.sys.posix.sys.stat;
private static import core.sys.posix.time;
private static import core.sys.posix.unistd;
private static import core.sys.windows.winbase;
private static import core.sys.windows.windef;
private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

version (Windows) {
	alias __time64_t = long;
	alias errno_t = int;
	alias rsize_t = size_t;
	enum _O_BINARY = 0x8000;
	enum _SH_DENYNO = 0x40;
	enum _S_IREAD = 0x0100;
	enum _S_IWRITE = 0x0080;
	.errno_t memcpy_s(void*, .rsize_t, const (void)*, .rsize_t);
	.errno_t memmove_s(void*, .rsize_t, const (void)*, .rsize_t);
	core.stdc.stdio.FILE* _fsopen(scope const char*, scope const char*, int);
	char* _strdup(scope const char*);
	int _unlink(scope const char*);
	.errno_t strncat_s(scope char*, .rsize_t, scope const char*, .rsize_t);
	.errno_t strcpy_s(scope char*, .rsize_t, scope const char*);
	.errno_t strncpy_s(scope char*, .rsize_t, scope const char*, .rsize_t);
	.errno_t strcat_s(scope char*, .rsize_t, scope const char*);
	size_t _stricmp(scope const char*, scope const char*);
	size_t _strnicmp(scope const char*, scope const char*, size_t);
	int _snprintf_s(scope char*, size_t, size_t, scope const char*, ...);
	int _write(int, const (void)*, uint);
	int _read(int, void*, uint);
	.errno_t _sopen_s(int*, scope const char*, int, int, int);
	int _close(int);
	int _fileno(core.stdc.stdio.FILE*);
	int _isatty(int);
	int _getpid();
	.__time64_t _time64(.__time64_t);
	.__time64_t _mktime64(core.stdc.time.tm*);
	.__time64_t _mkgmtime64(core.stdc.time.tm*);
}

version (Windows) {
	pragma(inline, true)
	.errno_t grn_memcpy(void* dest, const (void)* src, size_t n)

		do
		{
			return .memcpy_s(dest, n, src, n);
		}

	pragma(inline, true)
	.errno_t grn_memmove(void* dest, const (void)* src, size_t n)

		do
		{
			return .memmove_s(dest, n, src, n);
		}

	pragma(inline, true)
	void grn_getenv(const (char)* name, char* dest, size_t dest_size)

		do
		{
			char* dest_ = dest;
			size_t dest_size_ = dest_size;

			if (dest_size_ > 0) {
				core.sys.windows.windef.DWORD env_size = core.sys.windows.winbase.GetEnvironmentVariableA(name, dest_, cast(core.sys.windows.windef.DWORD)(dest_size_));

				if ((env_size == 0) || (env_size > dest_size_)) {
					dest_[0] = '\0';
				}
			}
		}

	pragma(inline, true)
	core.stdc.stdio.FILE* grn_fopen(scope const char* name, scope const char* mode)

		do
		{
			return ._fsopen(name, mode, ._SH_DENYNO);
		}

	alias grn_strdup_raw = ._strdup;
	alias grn_unlink = ._unlink;
	alias grn_strncat = .strncat_s;

	pragma(inline, true)
	.errno_t grn_strcpy(scope char* dest, .rsize_t dest_size, scope const char* src)

		do
		{
			return .strcpy_s(dest, dest_size, src);
		}

	pragma(inline, true)
	.errno_t grn_strncpy(scope char* dest, .rsize_t dest_size, scope const char* src, .rsize_t n)

		do
		{
			return .strncpy_s(dest, dest_size, src, n);
		}

	pragma(inline, true)
	.errno_t grn_strcat(scope char* dest, .rsize_t dest_size, scope const char* src)

		do
		{
			return .strcat_s(dest, dest_size, src);
		}

	alias grn_strcasecmp = ._stricmp;
	alias grn_strncasecmp = ._strnicmp;

	pragma(inline, true)
	int grn_snprintf(A ...)(scope char* dest, size_t dest_size, size_t n, A a)

		do
		{
			static if (a.length != 0) {
				return ._snprintf_s(dest, dest_size, n - 1, a[0 .. $]);
			} else {
				return ._snprintf_s(dest, dest_size, n - 1);
			}
		}

	pragma(inline, true)
	int grn_vsnprintf(scope char* dest, size_t dest_size, scope const char* format, core.stdc.stdarg.va_list args)

		do
		{
			int result = core.stdc.stdio.vsnprintf(dest, dest_size, format, args);
			dest[dest_size - 1] = '\0';

			return result;
		}

	alias grn_write = ._write;
	alias grn_read = ._read;

	enum GRN_OPEN_CREATE_MODE = ._S_IREAD | ._S_IWRITE;
	enum GRN_OPEN_FLAG_BINARY = ._O_BINARY;

	pragma(inline, true)
	.errno_t grn_open(int fd, scope const char* pathname, int flags)

		do
		{
			return ._sopen_s(&fd, pathname, flags, ._SH_DENYNO, .GRN_OPEN_CREATE_MODE);
		}

	alias grn_close = ._close;
	alias grn_fileno = ._fileno;
	alias grn_isatty = ._isatty;
	alias grn_getpid = ._getpid;
} else {
	alias grn_memcpy = core.stdc.string.memcpy;
	alias grn_memmove = core.stdc.string.memmove;

	pragma(inline, true)
	void grn_getenv(scope const char* name, scope char* dest, size_t dest_size)

		in
		{
			assert(dest != null);
		}

		do
		{
			const char* env_value = core.stdc.stdlib.getenv(name);
			char* dest_ = dest;
			size_t dest_size_ = dest_size;

			if (dest_size_ > 0) {
				if (env_value != null) {
					core.stdc.string.strncpy(dest_, env_value, dest_size_ - 1);
				} else {
					dest_[0] = '\0';
				}
			}
		}

	pragma(inline, true)
	char* grn_strncat(return scope char* dest, size_t dest_size, scope const char* src, size_t n)

		do
		{
			return core.stdc.string.strncat(dest, src, n);
		}

	pragma(inline, true)
	char* grn_strcpy(return scope char* dest, size_t dest_size, scope const char* src)

		do
		{
			return core.stdc.string.strcpy(dest, src);
		}

	pragma(inline, true)
	char* grn_strncpy(return scope char* dest, size_t dest_size, scope const char* src, size_t n)

		do
		{
			return core.stdc.string.strncpy(dest, src, n);
		}

	pragma(inline, true)
	char* grn_strcat(return scope char* dest, size_t dest_size, scope const char* src)

		do
		{
			return core.stdc.string.strcat(dest, src);
		}

	pragma(inline, true)
	int grn_snprintf(A ...)(scope char* dest, size_t dest_size, size_t n, A a)

		do
		{
			static if (a.length != 0) {
				return core.stdc.stdio.snprintf(dest, n, a[0 .. $]);
			} else {
				return core.stdc.stdio.snprintf(dest, n);
			}
		}

	alias grn_vsnprintf = core.stdc.stdio.vsnprintf;

	enum GRN_OPEN_FLAG_BINARY = 0;

	version (Posix) {
		alias grn_fopen = core.sys.posix.stdio.fopen;
		alias grn_strdup_raw = core.stdc.string.strdup;
		alias grn_unlink = core.sys.posix.unistd.unlink;
		alias grn_strcasecmp = core.sys.posix.strings.strcasecmp;
		alias grn_strncasecmp = core.sys.posix.strings.strncasecmp;
		alias grn_write = core.sys.posix.unistd.write;
		alias grn_read = core.sys.posix.unistd.read;
		enum GRN_OPEN_CREATE_MODE = core.sys.posix.sys.stat.S_IRUSR | core.sys.posix.sys.stat.S_IWUSR | core.sys.posix.sys.stat.S_IRGRP;

		pragma(inline, true)
		void grn_open(ref int fd, scope const char* pathname, int flags)

			do
			{
				fd = core.sys.posix.fcntl.open(pathname, flags, .GRN_OPEN_CREATE_MODE);
			}

		alias grn_close = core.sys.posix.unistd.close;
		alias grn_fileno = core.sys.posix.stdio.fileno;
		alias grn_isatty = core.sys.posix.unistd.isatty;
		alias grn_getpid = core.sys.posix.unistd.getpid;
	}
}

enum GRN_ENV_BUFFER_SIZE = 1024;

version (Windows) {
	alias grn_time_t = .__time64_t;
	alias grn_time = ._time64;
	alias grn_mktime = ._mktime64;
	alias grn_timegm = ._mkgmtime64;
} else {
	alias grn_time_t = core.stdc.time.time_t;
	alias grn_time = core.stdc.time.time;
	alias grn_mktime = core.stdc.time.mktime;

	version (Posix) {
		alias grn_timegm = core.sys.posix.time.timegm;
	}
}
