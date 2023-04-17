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
	uri: `https://github.com/groonga/groonga/releases/download/v13.0.1/groonga-13.0.1-x86-vs2019-with-vcruntime.zip`,
	sha512_hash: `86ac8141ae83a6bcb08ed020528cc2b5eed0a4995b3c7f0b8011c0a1b03300c44cacbae84b1fcaa1839e5a885a21b6b99e41e72eecf6a726d499084f42d15c4a`,
};

static immutable download_info windows_x86_64 =
{
	uri: `https://github.com/groonga/groonga/releases/download/v13.0.1/groonga-13.0.1-x64-vs2022-with-vcruntime.zip`,
	sha512_hash: `d8447fe1f5def8a628d1f21c9da8e62d46bdfb46de1353d0e93ca7a87307fbeadd376bce761ba81a1fa12486f8b15e25987c374c1065e040f236b646924f7cd7`,
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
