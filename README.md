# groonga-d
D language binding for Groonga, a full-text search engine.

## How to build
groonga library is required to build groonga-d.

### Windows
The Windows library is [distributed from the official](https://github.com/groonga/groonga/releases), so download it from there.
To download automatically, execute the following command.

```
rdmd download_lib.d
```

Build after downloading.

```
dub build --arch=x86_mscoff
dub build --arch=x86_64
```
