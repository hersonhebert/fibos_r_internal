#' @title Generate Plot Visualization with Pymol
#' @name visualize_reticulate
#'
#' @description Visualizing the interaction between molecules is crucial in studying occluded surfaces in a protein.
#'              The 'visualize' function will generate a plot of the protein and its interactions, using either dots or rays.
#'
#' @param raydist Tibble obtained from the execution of read_raydist.
#'
#' @seealso [read_prot()]
#' @seealso [read_raydist()]
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#' @author Patrick Fleming
#'
#' @importFrom readr write_csv
#'
visualize_reticulate = function(raydist){
  write_csv(raydist, "plot.tmp", col_names = FALSE)
  reticulate::source_python("visualize.py")
  #file.remove("plot.tmp")
}
