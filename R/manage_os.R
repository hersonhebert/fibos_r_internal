#' @title Calcule the Surface
#' @name occluded_surface
#'
#' @description The calculation of occluded surface areas is essential for
#'              understanding the possibility of an enzyme passing between atoms
#'              of a protein. To perform the calculation, it is considered that
#'              a surface is occluded based on tests with a probe, which is
#'              typically the water molecule.
#'
#' @param pdb Input containing only the name of the 4-digit PDB file, the file will be obtained online. If there is an extension ".pdb" or full path, the file will be obtained locally.
#' @param method Method to be used: OS or FIBOS
#'
#' @seealso [read_prot()]
#'
#' @author Carlos Henrique da Silveira
#' @author Herson Hebert Mendes Soares
#' @author João Paulo Roquim Romanelli
#' @author Patrick Fleming
#'
#' @export
occluded_surface = function(pdb, method){
  print("Calculating...")
  meth = 0
  if(file.exists("prot.srf")){
    file.remove("prot.srf")
  }
  if(file.exists("temp.pdb")){
    file.remove("temp.pdb")
  }
  path = system.file("extdata", "radii", package = "fibos")
  file.copy(from = path, to = getwd())
  interval = clean_pdb(pdb)
  iresf = interval[1]
  iresl = interval[2]
  if(toupper(method) == "OS"){
    meth = 1
  }
  if(toupper(method) == "FIBOS"){
    meth = 2
  }
  if(!(toupper(method) == "OS")&!(toupper(method) == "FIBOS")){
    stop("Wrong Method")
  }
  execute(1, iresl, meth)
  remove_files()
  return(read_prot("prot.srf"))
}

remove_files = function(){
  files_list = dir(pattern = ".ms")
  file.remove(files_list)
  files_list = dir(pattern = ".inp")
  file.remove(files_list)
  files_list = dir(pattern = ".txt")
  file.remove(files_list)
  file.remove("file.srf")
  file.remove("fort.6")
  file.remove("part_i.pdb", "part_v.pdb")
}

