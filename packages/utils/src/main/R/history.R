#  File src/library/utils/R/history.R
#  Part of the R package, http://www.R-project.org
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/

loadhistory <- function(file = ".Rhistory")
    invisible(.Internal(loadhistory(file)))

savehistory <- function(file = ".Rhistory")
    invisible(.Internal(savehistory(file)))

history <- function(max.show = 25, reverse = FALSE, pattern, ...)
{
    file1 <- tempfile("Rrawhist")
    savehistory(file1)
    rawhist <- readLines(file1)
    unlink(file1)
    if(!missing(pattern))
        rawhist <- unique(grep(pattern, rawhist, value = TRUE, ...))
    nlines <- length(rawhist)
    if(nlines) {
        inds <- max(1, nlines-max.show):nlines
        if(reverse) inds <- rev(inds)
    } else inds <- integer()
    file2 <- tempfile("hist")
    writeLines(rawhist[inds], file2)
    file.show(file2, title = "R History", delete.file = TRUE)
}

timestamp <- function(stamp = date(), prefix = "##------ ",
                      suffix = " ------##", quiet = FALSE)
{
    stamp <- paste(prefix, stamp, suffix, sep = "")
   # GNU R helpfully adds a timestamp comment to your command line history as 
   # a somewhat surprising side effect of this method. 
   # .Internal(addhistory(stamp))
    if (!quiet) cat(stamp, sep = "\n")
    invisible(stamp)
}
