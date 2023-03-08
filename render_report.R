library(tidyverse)
library(rorcid)
library(vitae)
library(rcrossref)
path <- "/Users/mia/Desktop/auto_cv/2022-2023_Faculty_CVs.xlsx"

render_report = function(orcid, email, path){
  person <- orcid_person(orcid)[[1]]
  current_year <- as.integer(format(Sys.Date(), "%Y"))
  # Start CV 3 years prior to current year
  start_year <- current_year - 3L
  all_works <- works(orcid) %>% 
    as_tibble() %>%
    mutate(year = as.integer(`publication-date.year.value`)) %>%
    filter(year >= start_year)
  types <- all_works$type
  class(all_works) <- c(class(all_works), "works")
  params <- list(
    name = person$name$`given-names`,
    surname = person$name$`family-name`,
    email = email,
    orcid = orcid,
    all_works = all_works,
    types = types
  )
  output_file = paste0(
    path,
    "CV-", 
    params$name,
    "-", 
    params$surname,
    ".pdf"
  )
  if("patent" %in% types){
    try(
      rmarkdown::render(
        "faculty_eval_last3yrs_patents.Rmd", 
        params = params,
        output_file = output_file
      ),
      outFile = gsub("pdf", "txt", output_file)
    )
  } else {
    try(
      rmarkdown::render(
        "faculty_eval_last3yrs.Rmd", 
        params = params,
        output_file = output_file
      ),
      outFile = gsub("pdf", "txt", output_file)
    )
  }
}

render_report("0000-0002-6671-5207", "mary@mail.cps.utexas.edu", path)




