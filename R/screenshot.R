#' Save a thumbnail screenshot of a website
#'
#' @param websites character vector of URLs to websites
#' @param thumbnails character vector of filenames for thumbnail images
#' @param useTinyPng logical, Use the TinyPNG API to shrink the images. Requires
#'   the environment variable \code{TINY_API} to be defined with your API key.
#'
#' @examples
#'   screenshot("https://stephenslab.github.io/wflow-divvy/", "test.png")
#'
#' @return Character vector of filenames of thumbnail images (invisibly)
#' @export
screenshot <- function(websites, thumbnails, useTinyPng = TRUE) {
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
  shrinkImage(thumbnails, useTinyPng = useTinyPng)
  return(invisible(thumbnails))
}

# Uses TinyPNG API or optipng (via webshot::shrink) to reduce file size
shrinkImage <- function(image, useTinyPng = TRUE) {
  if (useTinyPng && Sys.getenv("TINY_API") != "") {
    # tinify() is not vectorized
    for (file in image) {
      tinieR::tinify(
        file,
        overwrite = TRUE,
        quiet = FALSE
      )
    }
    return(invisible(NULL))
  }

  # Send warning if unable to use TinyPNG
  if (useTinyPng)
    warning("Unable to use TinyPNG API. Requires env var TINY_API")

  webshot::shrink(image)
}
