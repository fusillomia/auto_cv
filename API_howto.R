# how to get a new Orcid API

library(tidyverse)
library(rorcid)
library(httr)

usethis::edit_r_environ()

# when .Renviron pops up in a new tab, delete whatever is there, if anything
# save
# go to Session in the top menu bar and restart R session

library(tidyverse)
library(rorcid)

# go to you orcid page -> under your name in the top right there is a developer tools option
# you should see a client ID and a client secret. Generate a new client secret

# paste your client ID in replacement of XXXXX
orcid_client_id <- "XXXXX"

# paste your client secret in replacement of XXXXX
orcid_client_secret <- "XXXXX"

orcid_request <- POST(url  = "https://orcid.org/oauth/token",
                      config = add_headers(`Accept` = "application/json",
                                           `Content-Type` = "application/x-www-form-urlencoded"),
                      body = list(grant_type = "client_credentials",
                                  scope = "/read-public",
                                  client_id = orcid_client_id,
                                  client_secret = orcid_client_secret),
                      encode = "form")

orcid_response <- content(orcid_request)
print(orcid_response$access_token) # this is your new API

usethis::edit_r_environ()

# paste ORCID_TOKEN = "XXXXX" in the new .Renviron tab

# save and restart R session

orcid_auth() # output should be bearer and the API
