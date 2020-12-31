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
			string base_dir = std.path.buildNormalizedPath(dir_path, std.path.baseName(zip_file, `.zip`));
			auto zip = new std.zip.ZipArchive(std.file.read(std.path.buildNormalizedPath(dir_path, zip_file)));

			foreach (name, am; zip.directory) {
				if (!std.algorithm.searching.endsWith(name, `.dll`, `.exe`, `.lib`, `.pdb`)) {
					continue;
				}

				string out_filename = std.path.buildPath(base_dir, name);
				std.file.mkdirRecurse(std.path.dirName(out_filename));
				std.file.write(out_filename, zip.expand(am));
			}
	}
}

static immutable download_info windows_x86 =
{
	uri: `https://github.com/groonga/groonga/releases/download/v10.1.0/groonga-10.1.0-x86-vs2019-with-vcruntime.zip`,
	sha512_hash: `0c0cbc7a0adf889afd39a4c4accc45aafc223bc152f1640d155967796fb7f77b76db35e4ff2eac0bff2cb31c8fe558d9ce902c7dc8a92f03acf44ef8705566bc`,
};

static immutable download_info windows_x86_64 =
{
	uri: `https://github.com/groonga/groonga/releases/download/v10.1.0/groonga-10.1.0-x64-vs2019-with-vcruntime.zip`,
	sha512_hash: `a8ca441d82327cdd7bd9ac7bbd91d76e6dc46101e60fbaf46af4232deee50248b40765d43c44a23189770f8543e9687b4108fa4aa2acfb3916014cb8b0671b5c`,
};

/**
 * ?
 */
void main()

	do
	{
		windows_x86.extract_lib(`./`);
		windows_x86_64.extract_lib(`./`);
	}
