# Release Guide

## Manual Release Process

### 1. Update Version
Edit `VersionInfo.cs` and update the version number:
```csharp
public const string Version = "1.2.0";  // Update this
```

### 2. Build Release
Run the publish script:
```powershell
.\publish-release.ps1 1.2.0
```

Or manually:
```powershell
dotnet publish -c Release -r win-x64 `
  --self-contained true `
  -p:PublishSingleFile=true `
  -p:IncludeNativeLibrariesForSelfExtract=true `
  -p:EnableCompressionInSingleFile=true `
  -o publish/TabbySSH-v1.2.0-win-x64
```

### 3. Test the Build
1. Extract and run the executable from `publish/TabbySSH-v1.2.0-win-x64/`
2. Verify all features work correctly
3. Check that themes load properly
4. Test session management

### 4. Create GitHub Release
1. Go to your GitHub repository
2. Click "Releases" → "Create a new release"
3. Tag: `v1.2.0` (must match version)
4. Title: `TabbySSH v1.2.0`
5. Description: Add release notes (see below)
6. Upload: `TabbySSH-v1.2.0-win-x64.zip`
7. Click "Publish release"

## Automated Release (GitHub Actions)

### Setup (one-time)
1. The workflow file `.github/workflows/release.yml` is already configured
2. No additional setup needed - uses built-in `GITHUB_TOKEN`

### Creating a Release
1. Update version in `VersionInfo.cs`
2. Commit and push changes
3. Create and push a tag:
   ```bash
   git tag v1.2.0
   git push origin v1.2.0
   ```
4. GitHub Actions will automatically:
   - Build the release
   - Create a GitHub Release
   - Upload the zip file

## Release Notes Template

```markdown
## TabbySSH v1.2.0

### New Features
- Feature 1 description
- Feature 2 description

### Improvements
- Improvement 1
- Improvement 2

### Bug Fixes
- Fixed issue with X
- Fixed issue with Y

### Downloads
- **Windows x64**: [TabbySSH-v1.2.0-win-x64.zip](download-link)

### Installation
1. Download the zip file
2. Extract to a folder (e.g., `C:\Program Files\TabbySSH\`)
3. Run `TabbySSH.exe`
4. No installation required - portable application
```

## Build Options Explained

- `--self-contained true`: Includes .NET runtime (no need to install .NET separately)
- `-p:PublishSingleFile=true`: Creates a single executable file
- `-p:IncludeNativeLibrariesForSelfExtract=true`: Includes native DLLs in the single file
- `-p:EnableCompressionInSingleFile=true`: Compresses the single file
- `-r win-x64`: Targets Windows x64 platform

## File Size Considerations

- **Self-contained single file**: ~50-70 MB (includes .NET runtime)
- **Framework-dependent**: ~5-10 MB (requires .NET 8.0 installed)

For a Windows-only application, self-contained is recommended for easier distribution.


