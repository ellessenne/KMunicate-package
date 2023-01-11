## Test environments

* local R installation, R 4.2.2, Intel-based macOS Ventura 13.1
* ubuntu-latest (via GitHub Actions, devel, release, oldrel-1, oldrel-2, oldrel-3)
* windows-latest (via GitHub Actions, devel, 4.1, 3.6)
* macos-latest (via GitHub Actions, release)
* windows (via winbuilder, devel, release, oldrel)
* rhub (with rhub::check_for_cran())
* arm64 macOS (with devtools::check_mac_release())

## R CMD check results

On winbuilder, R 4.1.3, I get the following NOTE:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Alessandro Gasparini <alessandro@ellessenne.xyz>'

Possibly mis-spelled words in DESCRIPTION:
  KMunicate (2:8, 14:19, 15:44)
  Kaplan (2:24, 13:22, 16:5)
  al (14:48)
  et (14:45)
  
These words are actually okay.
