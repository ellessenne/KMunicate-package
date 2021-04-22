.PHONY: style docs pre_submission_test

style:
	R -e "styler::style_dir(filetype = c('r', 'rmd'))"

docs:
	make style
	R -e "devtools::document()"
	R -e "devtools::build_readme()"
	R -e "devtools::build_vignettes()"
	R -e "pkgdown::build_site()"

pre_submission_test:
	make docs
	R -e "devtools::check()"
	R -e "devtools::check_win_devel(quiet = TRUE)"
	R -e "devtools::check_win_release(quiet = TRUE)"
	R -e "devtools::check_win_oldrelease(quiet = TRUE)"
	R -e "rhub::check_for_cran()"
