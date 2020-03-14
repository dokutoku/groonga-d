/**
 * download groonga lib
 *
 * Author: dokutoku
 * License: CC0 Universal
 */
module hello;


private static import std.algorithm.searching;
private static import std.ascii;
private static import std.digest;
private static import std.digest.sha;
private static import std.file;
private static import std.stdio;
private static import std.path;
private static import std.net.curl;
private static import std.zip;

struct download_info
{
	string uri;
	string sha512_hash;

	private bool verify(string file_path) const

		do
		{
			return std.file.exists(file_path) && std.file.isFile(file_path) && std.digest.secureEqual(this.sha512_hash, std.digest.toHexString!(std.ascii.LetterCase.lower)(std.digest.sha.sha512Of(std.file.read(file_path))).idup);
		}

	private void download(string dir_path) const

		in
		{
			assert(dir_path.length != 0);
			assert(std.path.isValidPath(dir_path));
		}

		do
		{
			string file_path = std.path.buildNormalizedPath(dir_path, std.path.baseName(this.uri));

			if (this.verify(file_path)) {
				return;
			}

			std.net.curl.download(this.uri, file_path);

			if (!this.verify(file_path)) {
				throw new Exception(`The hash value of the downloaded file is invalid.`);
			}
		}

	void extract_lib(string dir_path) const

		in
		{
			assert(std.path.extension(this.uri) == `.zip`);
		}

		do
		{
			this.download(dir_path);
			string zip_file = std.path.baseName(this.uri);
			auto zip = new std.zip.ZipArchive(std.file.read(zip_file));

			foreach (name, am; zip.directory) {
				if (!std.algorithm.searching.endsWith(name, `.dll`, `.exe`, `.lib`, `.pdb`)) {
					continue;
				}

				std.file.mkdirRecurse(std.path.dirName(name));
				std.file.write(name, zip.expand(am));
			}
	}
}

static immutable download_info windows_x86 =
{
	uri: `https://github.com/groonga/groonga/releases/download/v9.1.2/groonga-9.1.2-x64-vs2017-with-vcruntime.zip`,
	sha512_hash: `0b5bc129673001b937126660c651369a75db79e4a816b57ee00901e0d447cb3fafe57b017591c1eb7f539f805a5f6f2d508597ad49fb4896323bb8aedf670e96`,
};

static immutable download_info windows_x86_64 =
{
	uri: `https://github.com/groonga/groonga/releases/download/v9.1.2/groonga-9.1.2-x86-vs2017-with-vcruntime.zip`,
	sha512_hash: `17ed9a324e7c3f44018e98133b27774f0b5515d613904647973f7ab4f2b12ed2c82bc7033fc4d5335ebe238f9e933ce1c4f931339850aa0dbe17002c8d3b2599`,
};

/**
 * ?
 */
void main()

	body
	{
		windows_x86.extract_lib(`./`);
		windows_x86_64.extract_lib(`./`);
	}
