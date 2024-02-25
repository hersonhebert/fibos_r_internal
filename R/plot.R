#' @title Generate Plot Visualization with Pymol
#' @name pymol_visualize
#'
#' @description Visualizing the interaction between molecules is crucial in studying occluded surfaces in a protein.
#'              The 'visualize' function will generate a plot of the protein and its interactions, using either dots or rays.
#'
#' @param raydist Tibble obtained from the execution of read_raydist.
#' @param pdb Input containing only the name of the 4-digit PDB file, the file will be obtained online. If there is an extension ".pdb" or full path, the file will be obtained locally.
#' @param type Type of visualization: rays or dots.
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
#' @export
pymol_visualize = function(raydist, pdb, type){
  if(grepl(".pdb",pdb)){
    pdb = sub(".pdb", "", pdb)
  }
  path = system.file("scripts", "visualize.py", package = "fibos")
  write_csv(raydist, "plot.tmp", col_names = FALSE)
  cmd = "python3"
  cmd = paste(cmd, path, pdb, type)
  system(cmd)
  file.remove("plot.tmp")
}

#' @title Read Raydist File
#' @name read_raydist
#'
#' @description The FIBOS software generates a file called "raydist."
#'              This file is crucial for generating visualization using Pymol to observe
#'              contact points between two atoms of a protein.
#'
#' @param file Name of raydist file. If no parameters are provided,
#'             it will default to searching for "raydist.lst."
#'
#' @seealso [read_prot()]
#' @seealso [pymol_visualize()]
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#' @author Patrick Fleming
#'
#' @importFrom readr read_table
#'
#' @export
read_raydist = function(file = NULL){
  if(is.null(file)){
    raydist = read_table("raydist.lst",col_names = FALSE)
  }
  else{
    raydist = read_table(file, col_names = FALSE)
  }
  return(raydist)

}
