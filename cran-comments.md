## Test environments

* local R installation, R 4.2.1, Intel-based macOS Monterey 12.5
* ubuntu-latest (via GitHub Actions, devel, release, oldrel)
* windows-latest (via GitHub Actions, devel, release, oldrel)
* macos-latest (via GitHub Actions, release, oldrel)
* windows (via winbuilder, devel, release, oldrel)
* rhub (with rhub::check_for_cran())
* arm64 macOS (with devtools::check_mac_release())
* arm64 macOS (with rhub::check(platform = 'macos-m1-bigsur-release'))

## R CMD check results

On all platforms I get the following note:

❯ checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘Alessandro Gasparini <alessandro@ellessenne.xyz>’
  
  New maintainer:
    Alessandro Gasparini <alessandro@ellessenne.xyz>
  Old maintainer(s):
    Alessandro Gasparini <alessandro.gasparini@ki.se>
    
This is okay, as I just updated my e-mail in the DESCRIPTION file.
