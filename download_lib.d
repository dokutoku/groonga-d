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
	uri: `https://packages.groonga.org/windows/groonga/groonga-9.1.0-x86-vs2017-with-vcruntime.zip`,
	sha512_hash: `8fc502b2d1cb674d934fea4c39d88c877972d071e696b02c860c59efdb200eac6dc3f78f6c4d1c1d3d2e7770c9cb3ef4cec9d7e53e0ca8e92af282052f657ae3`,
};

static immutable download_info windows_x86_64 =
{
	uri: `https://packages.groonga.org/windows/groonga/groonga-9.1.0-x64-vs2017-with-vcruntime.zip`,
	sha512_hash: `204e09cfe6360f3ff164348c73715f22707e3c9bd93ac730f4d2a630b819235b6de0e68868bb48b5ce877424de253a07e5be774c2ac2f31b69a6e9f2317b1f22`,
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
