This is a re-submission after addressing some queries from CRAN maintainers.

In particular: 
* I added authors and (year) of the paper mentioned in the description field of the DESCRIPTION file.
* I expanded the description of the package in the DESCRIPTION file
* I added myself as a copyright holder

Thanks for the feedback on the previous submission.

## Test environments

* local R installation, R 4.0.2, macOS Catalina 10.15.6
* ubuntu (on travis-ci, devel, release, oldrelease)
* windows (via win-builder, devel, release, oldrelease)
* windows (via appveyor)
* rhub (with rhub::check_for_cran())

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

New submission

* Possibly mis-spelled words in DESCRIPTION:
    KMunicate (2:8, 11:80, 12:72)
    Kaplan (2:24, 11:22, 13:15)
    al (12:22)
    et (12:19)
  
These words are spelled correctly: they are the name of a study and a surname, respectively.
