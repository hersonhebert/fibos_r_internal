#' @title Surface Calc
#' @name execute
#'
#' @description The implemented function executes the implemented methods.
#'              Using this function, it is possible to calculate occluded areas
#'              through the traditional methodology, Occluded Surface, or by
#'              applying the Fibonacci OS methodology. At the end of the method
#'              execution, the "prot.srf" file is generated, and returned for
#'              the function. The data in this file refers to all contacts
#'              between atoms of molecules present in a protein's PDB.
#'
#' @param iresf The number of the first element in the PDB
#' @param iresl The number of the first element in the PDB
#' @param maxres Maximum number of residues.
#' @param maxat Maximum number of atoms.
#'
#' @seealso [read_prot()]
#'
#' @importFrom stats rnorm
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#' @author Patrick Fleming

#'
call_main = function(iresf, iresl, maxres, maxat){
  resnum = integer(maxres)
  x = double(maxat)
  y = double(maxat)
  z = double(maxat)
  main_75 = .Fortran("main", resnum = as.integer(resnum), natm = as.integer(0),
                     x=as.double(rnorm(maxat)) ,y = as.double(rnorm(maxat)),
                     z = as.double(rnorm(maxat)), iresf, iresl, PACKAGE = "fibos")
  return(main_75)
}

execute = function(iresf, iresl, method){
  maxres = 10000
  maxat = 50000
  dyn.load(system.file("libs", "fibos.so", package = "fibos"))
  main_75 = call_main(iresf, iresl, maxres, maxat)
  for(ires in 1:(iresl)){
    intermediate = .Fortran("main_intermediate", main_75$x, main_75$y,
                            main_75$z, as.integer(ires), main_75$resnum,
                            main_75$natm, PACKAGE = "fibos")
    .Fortran("main_intermediate01",x=as.double(rnorm(maxat)),
             y = as.double(rnorm(maxat)),
             z = as.double(rnorm(maxat)), as.integer(ires), main_75$resnum,
             main_75$natm, PACKAGE = "fibos")
    .Fortran("runSIMS", PACKAGE = "fibos", as.integer(method))
    .Fortran("surfcal", PACKAGE = "fibos")
  }
  .Fortran("main_intermediate02", as.integer(method),PACKAGE = "fibos")
  dyn.unload(system.file("libs", "fibos.so", package = "fibos"))
}
