#' Download metadata from a publication from a DOI
#'
#' Uses the R package rcrossref to query the CrossRef API.
#'
#' @export
getPublicationMetadata <- function(dois) {
  crossref_email <- Sys.getenv("crossref_email")
  if (nchar(crossref_email) == 0) {
    message("CrossRef prefers (and you get more reliable service) if you submit your email with your API requests. This allows them to contact you if they need you to change your queries.")
  }

  results <- rcrossref::cr_cn(dois, format = "citeproc-json")
  # The results contain an outer list only if there is more than one doi
  if (length(dois) == 1) {
    results <- list(results)
  }

  metadata <- vector("list", length = length(results))
  for (i in seq_along(results)) {
    metadata[[i]][["title"]] <- results[[i]][["title"]]
    metadata[[i]][["year"]] <- results[[i]]$created$`date-parts`[, 1]
    metadata[[i]][["author"]] <- results[[i]]$author$family[1]
    metadata[[i]][["doi"]] <- results[[i]]$DOI
  }

  return(metadata)
}
