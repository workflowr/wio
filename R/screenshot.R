#' Save a thumbnail screenshot of a website
#'
#' @param websites character vector of URLs to websites
#' @param thumbnails character vector of filenames for thumbnail images
#'
#' @examples
#'   screenshot("https://stephenslab.github.io/wflow-divvy/", "test.png")
#'
#' @return Character vector of filenames of thumbnail images (invisibly)
#' @export
screenshot <- function(websites, thumbnails) {
  if (length(websites) == 0) {
    return(invisible(character(0)))
  }

  webshot::webshot(
    url = websites,
    file = thumbnails,
    vwidth = 16 * 75,
    vheight = 9 * 75,
    cliprect = "viewport",
    zoom = 2
  )
  webshot::resize(thumbnails, as.character(16 * 50))
  webshot::shrink(thumbnails)
  return(invisible(thumbnails))
}
