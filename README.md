# mcpelauncher-bins

Pre-compiled mcpelauncher binaries and libraries, packaged for use in Cianova Launcher builds.

This repository stores ready-to-use `.tar.gz` archives containing the compiled `mcpelauncher-client`, `mcpelauncher-extract`, and required shared libraries. Each archive is versioned and consumed directly by the Cianova Launcher CI/CD pipeline to build Flatpak and portable releases — no need to rebuild mcpelauncher from source every time.

## Structure

Each release is a `.tar.gz` with this internal layout:

```
mcpelauncher_bins-v<VERSION>/
├── bin/
│   ├── mcpelauncher-client
│   ├── mcpelauncher-extract
│   ├── gplaywrap
│   └── playdl
└── libs_mc/
    ├── lib/
    │   ├── libmcpelauncher.so
    │   ├── libminecraftpe.so
    │   └── ...
    └── gamecontrollerdb.txt
```

## How to create a release

1. Clone and compile [mcpelauncher-manifest](https://github.com/minecraft-linux/mcpelauncher-manifest)
2. Copy the resulting binaries to `bin/` and libraries to `libs_mc/`
3. Run `./pack.sh v3.0.0` (substitute the version)
4. Upload the generated `mcpelauncher_bins-v3.0.0.tar.gz` to a GitHub Release

## Naming convention

```
mcpelauncher_bins-v<VERSION>.tar.gz
```

The version should match the mcpelauncher manifest version the binaries were compiled from.
