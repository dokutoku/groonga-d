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
	uri: `https://packages.groonga.org/windows/groonga/groonga-9.0.9-x86-vs2017-with-vcruntime.zip`,
	sha512_hash: `07a1bca5bd6ae7dfd70ad7bf3c628916a960f3f367f173b55457e3df1509797cd04882351453769e274abb83540810b83f127b7015e4e9ee62a91619283f72b4`,
};

static immutable download_info windows_x86_64 =
{
	uri: `https://packages.groonga.org/windows/groonga/groonga-9.0.9-x64-vs2017-with-vcruntime.zip`,
	sha512_hash: `81cbf9c329c2252053d6e6a59b7247b32064ec4e42e898b7a02db7014a47c6a56b10b0d2f787e815804243e0a58660e2f45d7bb3c81ccb33ed6bf08f301d02da`,
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
