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
	uri: `https://packages.groonga.org/windows/groonga/groonga-9.0.8-x64-vs2017-with-vcruntime.zip`,
	sha512_hash: `4f9c55a81a22cdec04cb4630c8d4497de3b1bc88b5126b00decc2f542f8882e4341efb2daa1366023458f5f301de22788086a2f564227476c345eadda9b47eca`,
};

static immutable download_info windows_x86_64 =
{
	uri: `https://packages.groonga.org/windows/groonga/groonga-9.0.8-x86-vs2017-with-vcruntime.zip`,
	sha512_hash: `619e4236a2a4d2f70cd2db42f010880a88818fba0788b5b569a37962459872a22155a3951ebbdea4aafa2ef5b0ed5c3231dfe1090c8d711086850a1a16660828`,
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
