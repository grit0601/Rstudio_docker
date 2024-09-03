###### uncomment the code below, you can use the latest verse
# ARG BASE_CONTAINER=rocker/verse:latest

# I fixed this image to use 4.4.1 based R
# https://hub.docker.com/layers/rocker/verse/4.4.1/images/sha256-d3fe816c21e85ffa3fe28d78b10ac448738d767aae9eb7b957dd77ca6b7475ec?context=explore
ARG BASE_CONTAINER=rocker/verse:4.4.1
FROM $BASE_CONTAINER

# install r packages
RUN R -e "install.packages('tidyverse', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('brms', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('tidybayes', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('broom', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('broom.mixed', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('marginaleffects', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('modelsummary', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('rstan', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('osfr', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))"

# install cmdstanr
RUN mkdir -p /home/rstudio/.cmdstanr
ENV PATH="/home/rstudio/.cmdstanr:${PATH}"
RUN R -e "cmdstanr::install_cmdstan(dir = '/home/rstudio/.cmdstanr', cores = 4)"

# install lib dependencies

# add data
COPY /example/Script_example.Rmd /home/rstudio/example/
COPY /example/Script_example.r /home/rstudio/example/
COPY /example/df_example.csv /home/rstudio/example/
