FROM islasgeci/base:1.0.0
COPY . /workdir
RUN R -e "remotes::install_github('nepito/wyscout_tools', build_vignettes=FALSE, upgrade = FALSE)"
