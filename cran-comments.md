## Test environments

* local R installation, R 4.4.0, Intel-based macOS Sonoma 14.4.1
* ubuntu-latest (via GitHub Actions, devel, release, oldrel-1, oldrel-2)
* windows-latest (via GitHub Actions, release, 4.1)
* macos-latest (via GitHub Actions, release)
* macos-14 (via GitHub Actions, release)
* windows (via winbuilder, devel, release, oldrel)
* rhub (with rhub::check_for_cran())

## R CMD check results

Some CI runs did not run due to the Matrix package requiring R 4.4.0.
Other than that, no issues to report.
