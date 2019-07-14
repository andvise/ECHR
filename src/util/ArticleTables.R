
# ------------------------------------------------------------------------------

create_average_tables <- function(article_number) {
  labels_class   <- c("full", "procedure", "circumstances", "relevantLaw", "law", "topics", "facts", "topcir", "voting", "newvoting", "outcome")
  labels_shuffle   <- c("shuffle1", "shuffle2", "shuffle3", "shuffle4", "shuffle5", "shuffle6", "shuffle7", "shuffle8", "shuffle9", "shuffle10")
  labels_fold   <- c("fold1", "fold2", "fold3", "fold4", "fold5", "fold6", "fold7", "fold8", "fold9", "fold10")
  
  if (article_number == "3") dimensions <- c(length(labels_class),10,10,25)
  else if (article_number == "6") dimensions <- c(length(labels_class),10,10,8)
  else if (article_number == "8") dimensions <- c(length(labels_class),10,10,26)
  
  average_tables <- array(dim = dimensions, dimnames = list(labels_class,labels_shuffle, labels_fold , NULL))
  return(average_tables)
}

# ------------------------------------------------------------------------------

name_of_file <- function(article_number, section) {
  if (section == "topics") file <- paste("topics", article_number, ".csv", sep = "")
  else file <- paste("ngrams_a", article_number, "_", section, ".csv", sep = "")
  
  return(file)
}

# ------------------------------------------------------------------------------

total_data_for_file <- function(section) {
  if (section == "topics") total_data <- 30
  else if (section == "topcir") total_data <- 2030
  else total_data <- 2000
  
  return(total_data)
}

# ------------------------------------------------------------------------------

fold <- function(article_number) {
  if (article_number == "3") max_fold <- 250
  else if (article_number == "6") max_fold <- 80
  else if (article_number == "8") max_fold <- 254
  
  return(max_fold)
}

# ------------------------------------------------------------------------------

length_of_row <- function(article_number) {
  if (article_number == "3") row_length <- 25
  else if (article_number == "6") row_length <- 8
  else if (article_number == "8") row_length <- 26
  
  return(row_length)
}