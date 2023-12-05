# ======================================
#                Quarto
# ======================================
# jupyter  (used by quarto)                   ****REMOVED SUDO, NOT YET TESTED
msg "   - jupyter"
pip3 install -U jupyter                       
# quarto  
msg "   - quarto"
# if not already installed, download deb file and install with gdebi
# method from : https://docs.posit.co/resources/install-quarto/#quarto-deb-file-install
if ! quarto check --quiet; then
  yes | sudo curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
  yes | sudo gdebi quarto-linux-amd64.deb
  sudo rm quarto-linux-amd64.deb
fi
quarto check