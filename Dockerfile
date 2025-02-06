# # Use Rocker RStudio image
# FROM rocker/rstudio:4.4.2

# # Install renv and remotes
# RUN Rscript -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
# RUN Rscript -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"

# # Switch to root to copy files
# USER root
# COPY renv.lock /home/rstudio/renv.lock
# COPY renv /home/rstudio/renv

# # Ensure correct permissions
# RUN chown -R rstudio:rstudio /home/rstudio/renv /home/rstudio/renv.lock

# # Switch back to rstudio user
# USER rstudio

# # Restore R environment from renv.lock
# RUN Rscript -e "renv::restore(prompt = FALSE)"

# # Set working directory
# WORKDIR /home/rstudio



FROM rocker/rstudio:4.4.2

# Install renv
RUN Rscript -e "install.packages('renv', repos = 'https://cloud.r-project.org')"

# Copy the whole project directory (assuming renv.lock is inside)
COPY . /home/rstudio/project

# Set working directory
WORKDIR /home/rstudio/project

# Change ownership (switching between root and rstudio user)
RUN chown -R rstudio:rstudio /home/rstudio/project

# Switch to rstudio user
USER rstudio

# Restore dependencies
RUN Rscript -e "if (file.exists('renv.lock')) renv::restore(prompt = FALSE) else print('No renv.lock found, skipping restore.')"
