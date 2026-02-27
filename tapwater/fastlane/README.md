fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios screenshots

```sh
[bundle exec] fastlane ios screenshots
```

Capture App Store screenshots (works with AppScreens Fastlane import/export)

### ios screenshots_free

```sh
[bundle exec] fastlane ios screenshots_free
```

Capture screenshots for Free tier

### ios screenshots_pro

```sh
[bundle exec] fastlane ios screenshots_pro
```

Capture screenshots for Pro tier

### ios screenshots_insights

```sh
[bundle exec] fastlane ios screenshots_insights
```

Capture screenshots for Insights tier

### ios screenshots_fast

```sh
[bundle exec] fastlane ios screenshots_fast
```

Capture screenshots in fast mode (no clean/reinstall)

### ios screenshots_free_fast

```sh
[bundle exec] fastlane ios screenshots_free_fast
```

Capture screenshots for Free tier in fast mode

### ios screenshots_pro_fast

```sh
[bundle exec] fastlane ios screenshots_pro_fast
```

Capture screenshots for Pro tier in fast mode

### ios screenshots_insights_fast

```sh
[bundle exec] fastlane ios screenshots_insights_fast
```

Capture screenshots for Insights tier in fast mode

### ios upload_screenshots

```sh
[bundle exec] fastlane ios upload_screenshots
```

Upload screenshots and build metadata with deliver

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
