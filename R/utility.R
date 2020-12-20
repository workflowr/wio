#' Export list as a YAML header
#'
#' @export
exportYamlHeader <- function(theList, theFile) {
  con <- file(theFile, "w")
  cat("---\n", file = con)
  yaml::write_yaml(theList, file = con)
  cat("---\n\n", file = con, append = TRUE)
  close(con)
}
