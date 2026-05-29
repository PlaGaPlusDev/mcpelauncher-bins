# Sample structure

This directory shows how the tar.gz should look when extracted:

```
sample/
├── bin/
│   ├── mcpelauncher-client     ← compiled from mcpelauncher-manifest
│   ├── mcpelauncher-extract    ← compiled from mcpelauncher-manifest
│   ├── gplaywrap               ← Google Play wrapper
│   └── playdl                  ← Play downloader
└── libs_mc/
    ├── lib/
    │   ├── libmcpelauncher.so  ← mcpelauncher shared library
    │   ├── libminecraftpe.so   ← Minecraft PE library
    │   └── ...                 ← other needed .so files
    └── gamecontrollerdb.txt    ← game controller mappings
```

Replace the placeholder files here with real binaries and run `./pack.sh` at the repo root.
