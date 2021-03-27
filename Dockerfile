FROM hongyuanjia/eplusr:9.1.0-verse

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/ideas-lab-nus/reproducing-building-simulation" \
      org.label-schema.vendor="IDEAS Lab" \
      maintainer="Hongyuan Jia <hongyuanjia@outlook.com>"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    tk8.6-dev

WORKDIR /home/rstudio
RUN git clone https://github.com/ideas-lab-nus/reproducing-building-simulation.git
WORKDIR reproducing-building-simulation

ENV RENV_VERSION 0.13.0
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
RUN R -e "renv::restore(repos = c(RSPM = 'https://cluster.rstudiopm.com/cran/__linux__/bionic/latest'), confirm = FALSE); renv::isolate()"

CMD ["/init"]
