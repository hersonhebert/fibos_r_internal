% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ret.R
\name{visualize_reticulate}
\alias{visualize_reticulate}
\title{Generate Plot Visualization with Pymol}
\usage{
visualize_reticulate(raydist)
}
\arguments{
\item{raydist}{Tibble obtained from the execution of read_raydist.}
}
\description{
Visualizing the interaction between molecules is crucial in studying occluded surfaces in a protein.
The 'visualize' function will generate a plot of the protein and its interactions, using either dots or rays.
}
\seealso{
\code{\link[=read_prot]{read_prot()}}

\code{\link[=read_raydist]{read_raydist()}}
}
\author{
Carlos Henrique da Silveira

Herson Hebert Mendes Soares

João Paulo Roquim Romanelli

Patrick Fleming
}
