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
	uri: `https://github.com/groonga/groonga/releases/download/v11.0.3/groonga-11.0.3-x86-vs2019-with-vcruntime.zip`,
	sha512_hash: `0b871fb93899a6bbf8bfd022aacbe7aca5e7787601058b59f7f420da568fee1c1d691f2a7fd357643ba1a2c74885d7c97bff75bb49ced4a7741550ab1d46ae36`,
};

static immutable download_info windows_x86_64 =
{
	uri: `https://github.com/groonga/groonga/releases/download/v11.0.3/groonga-11.0.3-x64-vs2019-with-vcruntime.zip`,
	sha512_hash: `92f2593e00b2c4394274d311770c6621bab848adaf66d91b1df31446ba78b3c8fbe834abac061c66e25f52858613623c55c8384f13aef36e3442b83782aa5073`,
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
