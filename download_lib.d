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
	uri: `https://packages.groonga.org/windows/groonga/groonga-10.0.6-x86-vs2019-with-vcruntime.zip`,
	sha512_hash: `346911acacef3406882eadfe37bf965cbb9f14f2c9e3d1eda70795cc687b0838d98fb064d97cb874e8314d98ef8586aa4e737d6a28b16e0eaa4c013e54fcab71`,
};

static immutable download_info windows_x86_64 =
{
	uri: `https://packages.groonga.org/windows/groonga/groonga-10.0.6-x64-vs2019-with-vcruntime.zip`,
	sha512_hash: `b48b87a0a0399d885e90a0855da9124d1b063dc06802800c7d6dc1d828abb48fc5fb78f486b42ca82beddd2b10df4c7b5393f68f6c5fc0a84d286ff8cc94be69`,
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
