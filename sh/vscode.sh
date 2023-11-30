#!/bin/bash
source $BDEV/sh/helper.sh

# =========================================================
#             EXTENSIONS & THEMES TO INSTALL
# =========================================================
extensions=(                            \
  # ===== Editor =====
  formulahendry.code-runner             \
  SlySherZ.comment-box                  \
  bierner.docs-view                     \
  # dakara.dakara-foldplus                \
  # christian-kohler.path-intellisense    \
  mechatroner.rainbow-csv               \
  maptz.regionfolder                    \
  # ===== Spelling =====
  streetsidesoftware.code-spell-checker                     \
  streetsidesoftware.code-spell-checker-australian-english  \
  streetsidesoftware.code-spell-checker-scientific-terms    \
  # ===== Git =====
  # eamodio.gitlens                       \
  # maciejdems.add-to-gitignore           \
  # ===== R =====
  REditorSupport.r                      \
  TianyiShi.rmarkdown                   \
  # ===== Quarto =====
  quarto.quarto                         \
  # ===== Python =====
  ms-python.python                      \
  ms-python.vscode-pylance              \
  ms-python.isort                       \
  # ===== Jupyter =====
  ms-toolsai.jupyter                    \
  ms-toolsai.jupyter-keymap             \
  ms-toolsai.jupyter-renderers          \
  ms-toolsai.vscode-jupyter-cell-tags   \
  ms-toolsai.vscode-jupyter-slideshow   \
  
  # ===== Remote =====
  # Not for WSL, but will refuse to install anyways
  ms-vscode-remote.remote-containers            \
  ms-vscode-remote.remote-ssh                   \
  ms-vscode-remote.remote-ssh-edit              \
  ms-vscode-remote.remote-wsl                   \
  ms-vscode-remote.vscode-remote-extensionpack  \
  ms-vscode.remote-explorer                     \
  ms-vscode.remote-server                       \
  # ===== Docker =====
  ms-azuretools.vscode-docker
)
themes=(                                \
  fisheva.eva-theme                     \
  zhuangtongfa.Material-theme           \
  andrewm098.OneLight-Pro               \
  wangweixuan.yithemes
)

# =========================================================
#            INSTALL EXTENSIONS & THEMES
# =========================================================
vscode-install-extensions "${extensions[@]}"
vscode-install-extensions "${themes[@]}"
