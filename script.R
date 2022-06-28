customModel <- R6Class("Model",
                 public = list(
                   initialize = function(dataset, undersampling = NULL, oversampling = NULL) {
                     
                   },
                   fit = function(x) {
                     private$queue <- c(private$queue, list(x))
                     invisible(self)
                   },
                   predict = function() {
                     if (private$length() == 0) return(NULL)
                     # Can use private$queue for explicit access
                     head <- private$queue[[1]]
                     private$queue <- private$queue[-1]
                     head
                   }
                 ),
                 private = list(
                   queue = list(),
                   length = function() base::length(private$queue)
                 )
)