#' @title Patient Survival in Drug Trial
#' @description Patient survival in drug trial data, imported from Stata 16.
#' @format A data frame with 48 rows and 4 variables:
#' * `studytime` Months to death or end of follow-up;
#' * `died` Event indicator variable, `died = 1` if a patient died;
#' * `drug` Drug type, with `drug = 1` being placebo;
#' * `age` Age of a patient at baseline.
#' @references http://www.stata-press.com/data/r16/cancer.dta
#' @examples
#' data("cancer", package = "KMunicate")
"cancer"

#' @title German Breast Cancer Study Data
#' @description German breast cancer study data, imported from Stata 16.
#' @format A data frame with 686 rows and 14 variables:
#' * `id` A numeric vector;
#' * `hormon` Hormonal therapy;
#' * `x1` Age, in years;
#' * `x2` Menopausal status;
#' * `x3` Tumour size, mm;
#' * `x4` Tumour grade;
#' * `x5` Number of positive nodes;
#' * `x6` Progesterone receptor, fmol;
#' * `rectime` Recurrence-free survival time, days;
#' * `censrec` Censoring indicator;
#' * `x4a` Tumour grade >=2;
#' * `x4b` Tumour grade == 3;
#' * `x5e` exp(-0.12 * x5).
#' @references http://www.stata-press.com/data/r16/brcancer.dta
#' @examples
#' data("brcancer", package = "KMunicate")
"brcancer"
