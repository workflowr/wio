#' Get list of workflowr projects hosted on GitHub
#'
#' @export
getProjectsOnGitHub <- function() {

  appId <- Sys.getenv("GH_APP_ID")
  if (nchar(appId) == 0) {
    stop("Unable to find environment variable GH_APP_ID")
  }
  appKey <- Sys.getenv("GH_APP_KEY")
  if (nchar(appKey) == 0) {
    stop("Unable to find environment variable GH_APP_KEY")
  }
  if (!file.exists(appKey)) {
    stop("The key file specified by GH_APP_KEY does not exist: %s",
         appKey)
  }
  installations <- ghapps::gh_app_installation_list(
    app_id = appId,
    app_key = appKey
  )
  projects <- list()
  for (install in installations) {
    token <- ghapps::gh_app_token(
      installation = install$account$login,
      app_id = appId,
      app_key = appKey
    )
    repositories <- gh::gh(
      "/installation/repositories",
      .token = token
    )
    for (repo in repositories$repositories) {
      if (repo$visibility == "private") {
        message("Skipping private repo: ", repo$full_name)
        next
      }
      if (!repo$has_pages) {
        message("Skipping repo with no GitHub Pages: ", repo$full_name)
        next
      }
      projects <- c(projects, list(list(owner = repo$owner$login,
                                        repo = repo$name)))
    }
  }

  return(projects)
}
