#' @title Respak Calcule
#' @name respak
#'
#' @description The OSP value is important for verifying the quality of the values
#'              calculated by the developed package for calculating the contact
#'                areas between the molecules of the analyzed protein.
#'
#' @param file Prot File (.srf).
#'
#' @seealso [read_prot()]
#' @seealso [occluded_surface()]
#'
#' @importFrom readr read_table
#'
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#' @author Patrick Fleming
#'
#' @export
respak = function(file){
  if(file.exists(file)){
    dyn.load(system.file("libs", "fibos.so", package = "fibos"))
    .Fortran("respak", PACKAGE = "fibos")
    dyn.unload(system.file("libs", "fibos.so", package = "fibos"))
    osp = readr::read_table("prot.pak")
    return(osp)
  }
  else{
    print("Prot not Found.")
  }
}
