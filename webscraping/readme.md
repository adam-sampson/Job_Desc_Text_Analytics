# Webscraping Methodology

## Installing RSelenium with Docker

Instructions were followed from: [https://cran.r-project.org/web/packages/RSelenium/vignettes/RSelenium-docker.html#why-docker](https://cran.r-project.org/web/packages/RSelenium/vignettes/RSelenium-docker.html#why-docker). However, note that there is extra information in these instructions which may be confusing to people who aren't power users.

Method used for Windows:

Get [Docker toolbox for Windows](https://docs.docker.com/toolbox/toolbox_install_windows/)

Install Docker Toolbox

Reboot the computer

Open Docker Quickstart Terminal

Choose either standalone-chrome or standalone-firefox (your personal preference)

Note the IP address given when you start the Quickstart Terminal (for the future)

In the Docker Quickstart Terminal run the command 'docker pull selenium/standalone-chrome'

