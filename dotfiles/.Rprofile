# Never save workspace image
utils::assignInNamespace(
  "q", 
  function(save = "no", status = 0, runLast = TRUE) {
    .Internal(quit(save, status, runLast))
  }, 
  "base"
)

# Set default CRAN mirror
options(repos=c(CRAN="https://cloud.r-project.org/"))

# # Unicode (set locale to utf8)
# is_uft8_support <- grepl(
#     "UTF-8|utf8", Sys.getenv("LANG"),
#     ignore.case = TRUE, perl = TRUE
# ) &&
#     R.version$major >= 4L &&
#     R.version$minor >= 2.0
# if (is_uft8_support) {
#     message <- Sys.setlocale("LC_ALL", Sys.getenv("LANG")) |> 
#       suppressWarnings()
# }

# # Load vscode init scripts
# if (interactive() && Sys.getenv("RSTUDIO") == "") {
#   source(file.path(Sys.getenv(if (.Platform$OS.type == "windows") "USERPROFILE" else "HOME"), ".vscode-R", "init.R"))
# }

# Load brendev functions
BDEV <- system('echo "$BDEV"', intern=TRUE)
source(file.path(BDEV, "r", "install_packages.r"))