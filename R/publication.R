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
  citations  <- rcrossref::cr_cn(
    dois,
    format = "text",
    style = "national-library-of-medicine-grant-proposals"
  )
  # The results contain an outer list only if there is more than one doi
  if (length(dois) == 1) {
    results <- list(results)
    citations <- list(citations)
  }
  # Remove leading "1. " from citations
  citations <- lapply(citations, function(x) sub("^[0-9]\\.\\s", "", x))

  metadata <- vector("list", length = length(results))
  for (i in seq_along(results)) {
    # Example of title with embedded HTML tags
    # if (results[[i]]$DOI == "10.5194/bg-2021-40") browser()
    metadata[[i]][["title"]] <- fixHtml(results[[i]][["title"]])
    metadata[[i]][["year"]] <- results[[i]]$created$`date-parts`[1, 1]
    metadata[[i]][["month"]] <- results[[i]]$created$`date-parts`[1, 2]
    metadata[[i]][["day"]] <- results[[i]]$created$`date-parts`[1, 3]
    metadata[[i]][["author"]] <- results[[i]]$author$family[1]
    metadata[[i]][["doi"]] <- results[[i]]$DOI
    metadata[[i]][["citation"]] <- fixHtml(citations[[i]])
  }

  return(metadata)
}

# Repair title that contains HTML
fixHtml <- function(x) {
  result <- x
  result <- gsub("&amp;lt;", "<", result)
  result <- gsub("&amp;gt;", ">", result)
  result <- gsub("\\n", " ", result)
  return(result)
}
