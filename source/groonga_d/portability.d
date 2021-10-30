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


private static import core.stdc.time;
private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

/+
#ifdef WIN32
	#ifdef __cplusplus
		#define grn_memcpy(dest, src, n) ::memcpy_s((dest), (n), (src), (n))
	#else
		#define grn_memcpy(dest, src, n) memcpy_s((dest), (n), (src), (n))
	#endif
#else
	#ifdef __cplusplus
		#define grn_memcpy(dest, src, n) std::memcpy((dest), (src), (n))
	#else
		#define grn_memcpy(dest, src, n) memcpy((dest), (src), (n))
	#endif
#endif

#ifdef WIN32
	#define grn_memmove(dest, src, n) memmove_s((dest), (n), (src), (n))
#else
	#define grn_memmove(dest, src, n) memmove((dest), (src), (n))
#endif

enum GRN_ENV_BUFFER_SIZE = 1024;

#ifdef WIN32
	# define grn_getenv(name, dest, dest_size) char *dest_ = (dest); size_t dest_size_ = (dest_size); if (dest_size_ > 0) { DWORD env_size; env_size = GetEnvironmentVariableA((name), dest_, dest_size_); if (env_size == 0 || env_size > dest_size_) { dest_[0] = '\0'; } }
#else
	# define grn_getenv(name, dest, dest_size) const char *env_value = getenv((name)); char *dest_ = (dest); size_t dest_size_ = (dest_size); if (dest_size_ > 0) { if (env_value) { strncpy(dest_, env_value, dest_size_ - 1); } else { dest_[0] = '\0'; } }
#endif

#ifdef WIN32
	#define grn_fopen(name, mode) _fsopen((name), (mode), _SH_DENYNO)
#else
	#define grn_fopen(name, mode) fopen((name), (mode))
#endif

#ifdef WIN32
	#define grn_strdup_raw(string_) _strdup((string_))
#else
	#define grn_strdup_raw(string_) strdup((string_))
#endif

#ifdef WIN32
	#define grn_unlink(filename) _unlink((filename))
#else
	#define grn_unlink(filename) unlink((filename))
#endif

#ifdef WIN32
	# define grn_strncat(dest, dest_size, src, n) strncat_s((dest), (dest_size), (src), (n))
#else
	# define grn_strncat(dest, dest_size, src, n) strncat((dest), (src), (n))
#endif

#ifdef WIN32
	# define grn_strcpy(dest, dest_size, src) strcpy_s((dest), (dest_size), (src))
#else
	# define grn_strcpy(dest, dest_size, src) strcpy((dest), (src))
#endif

#ifdef WIN32
	# define grn_strncpy(dest, dest_size, src, n) strncpy_s((dest), (dest_size), (src), (n))
#else
	# define grn_strncpy(dest, dest_size, src, n) strncpy((dest), (src), (n))
#endif

#ifdef WIN32
	# define grn_strcat(dest, dest_size, src) strcat_s((dest), (dest_size), (src))
#else
	# define grn_strcat(dest, dest_size, src) strcat((dest), (src))
#endif

#ifdef WIN32
	# define grn_strcasecmp(string1, string2) _stricmp((string1), (string2))
#else
	# define grn_strcasecmp(string1, string2) strcasecmp((string1), (string2))
#endif

#ifdef WIN32
	# define grn_strncasecmp(string1, string2, n) _strnicmp((string1), (string2), (n))
#else
	# define grn_strncasecmp(string1, string2, n) strncasecmp((string1), (string2), (n))
#endif

#ifdef WIN32
	# define grn_snprintf(dest, dest_size, n, ...) do { _snprintf_s((dest), (dest_size), (n) - 1, __VA_ARGS__); } while (groonga_d.groonga.GRN_FALSE)
#else
	# define grn_snprintf(dest, dest_size, n, ...) snprintf((dest), (n), __VA_ARGS__)
#endif

#ifdef WIN32
	# define grn_vsnprintf(dest, dest_size, format, args) do { vsnprintf((dest), (dest_size), (format), (args)); (dest)[(dest_size) - 1] = '\0'; } while (groonga_d.groonga.GRN_FALSE)
#else
	# define grn_vsnprintf(dest, dest_size, format, args) vsnprintf((dest), (dest_size), (format), (args))
#endif

#ifdef WIN32
	#define grn_write(fd, buf, count) _write((fd), (buf), (count))
#else
	#define grn_write(fd, buf, count) write((fd), (buf), (count))
#endif

#ifdef WIN32
	#define grn_read(fd, buf, count) _read((fd), (buf), (count))
#else
	#define grn_read(fd, buf, count) read((fd), (buf), (count))
#endif

#ifdef WIN32
	# define GRN_OPEN_CREATE_MODE (_S_IREAD | _S_IWRITE)
	enum GRN_OPEN_FLAG_BINARY = _O_BINARY;
	# define grn_open(fd, pathname, flags) _sopen_s(&(fd), (pathname), (flags), _SH_DENYNO, GRN_OPEN_CREATE_MODE)
#else
	# define GRN_OPEN_CREATE_MODE (S_IRUSR | S_IWUSR | S_IRGRP)
	enum GRN_OPEN_FLAG_BINARY = 0;
	# define grn_open(fd, pathname, flags) (fd) = open((pathname), (flags), GRN_OPEN_CREATE_MODE)
#endif

#ifdef WIN32
	#define grn_close(fd) _close((fd))
#else
	#define grn_close(fd) close((fd))
#endif

#ifdef WIN32
	#define grn_fileno(stream) _fileno((stream))
#else
	#define grn_fileno(stream) fileno((stream))
#endif

#ifdef WIN32
	#define grn_isatty(stream) _isatty((stream))
#else
	#define grn_isatty(stream) isatty((stream))
#endif

#ifdef WIN32
	#define grn_getpid() _getpid()
#else
	#define grn_getpid() getpid()
#endif
+/

version (Win32) {
	/+
	alias grn_time_t = __time64_t;
	alias grn_time = _time64;
	alias grn_mktime = _mktime64;
	+/
} else {
	alias grn_time_t = core.stdc.time.time_t;
	alias grn_time = core.stdc.time.time;
	alias grn_mktime = core.stdc.time.mktime;
}
