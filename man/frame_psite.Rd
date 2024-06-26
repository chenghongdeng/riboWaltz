% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/frames.R
\name{frame_psite}
\alias{frame_psite}
\title{Percentage of P-sites per reading frame.}
\usage{
frame_psite(
  data,
  annotation,
  sample,
  multisamples = "average",
  plot_style = "split",
  transcripts = NULL,
  region = "all",
  length_range = NULL,
  cl = 100,
  colour = NULL
)
}
\arguments{
\item{data}{Either list of data tables or GRangesList object from
\code{\link{psite_info}}.}

\item{annotation}{Data table as generated by \code{\link{create_annotation}}.}

\item{sample}{Either character string, character string vector or named list
of character string(s)/character string vector(s) specifying the name of
the sample(s) and replicate(s) of interest. If a list is provided, each
element of the list is considered as an independent sample associated with
one ore multiple replicates. Multiple samples and replicates are handled
and visualised according to \code{multisamples} and \code{plot_style}.}

\item{multisamples}{Either "average" or "independent". It specifies how to
handle multiple samples and replicates stored in \code{sample}:
\itemize{
\item if \code{sample} is a character string vector and \code{multisamples} is
set to "average" the elements of the vector are considered as replicates
of one sample and a single bar plot is returned.
\item if \code{sample} is a character string vector and \code{multisamples} is
set to "independent", each element of the vector is analysed independently
of the others. The number of plots returned and their organization is
specified by \code{plot_style}.
\item if \code{sample} is a list, \code{multisamples} must be set to "average".
Each element of the list is analysed independently of the others, its
replicates averaged and its name reported in the plot. The number of plots
returned and their organization is specified by \code{plot_style}.
Note: when this parameter is set to "average" the bar plot associated with
each sample displays the frame-specific mean signal computed across the
replicates and the corresponding standard error is also reported. Default
is "average".
}}

\item{plot_style}{Either "split", "facet", "dodge" or "mirror". It specifies
how to organize and display multiple bar plots:
\itemize{
\item "split": one bar plot for each sample is returned as an independent
ggplot object.
\item "facet": the bar plots are placed one next to the other, in independent
boxes.
\item "dodge": all bar plots are displayed in one box and, for each frame,
samples are placed side by side.
\item "mirror": \code{sample} must be either a character string vector or
a list of exactly two elements and the resulting bar plots are mirrored
along the x axis.
Default is "split".
}}

\item{transcripts}{Character string vector listing the name of transcripts to
be included in the analysis. Default is NULL, i.e. all transcripts are used.}

\item{region}{Character string specifying the region(s) of the transcripts to
be analysed. It can be either "5utr", "cds", "3utr", respectively for 5'
UTRs, CDSs and 3' UTRs, or "all", i.e. all regions are considered. Note:
according to this parameter the bar plots are differently arranged to
optimise the organization and the visualization of the data.}

\item{length_range}{Integer or integer vector for restricting the analysis to
a chosen range of read lengths. Default is NULL, i.e. all read lengths are
used.}

\item{cl}{Integer value in \link{1,100} specifying a confidence level for
restricting the analysis to an automatically-defined range of read lengths.
The new range is computed according to the most frequent read lengths,
which accounts for the cl\% of the sample and is defined by discarding the
(100-cl)\% of read lengths falling in the tails of the  read lengths
distribution. If multiple sample names are provided, one range of read
lengths is computed, such that at least the cl\% of all samples is
represented. Default is 100.}

\item{colour}{Character string or character string vector specifying the
colour of the bar plot(s). If \code{plot_style} is set to either "dodge" or
"mirror", a colour for each sample is required. Default is NULL, i.e. the
default R colour palette is used.}
}
\value{
List containing: one or more ggplot object(s) and the data table with
the corresponding x- and y-axis values ("plot_dt"); an additional data
table with raw and scaled number of P-sites per frame for each sample
("count_dt").
}
\description{
This function computes, for each transcript region (5' UTR, coding sequence
and 3' UTR), the percentage of P-sites falling in the three possible
translation reading frames. It takes into account only transcripts with
annotated regions of length > 0 and the resulting values are visualized as
bar plots.  Multiple samples and replicates can be handled.
}
\examples{
## data(reads_list)
## data(mm81cdna)
##
## ## Generate fake samples and replicates
## for(i in 2:6){
##   samp_name <- paste0("Samp", i)
##   set.seed(i)
##   reads_list[[samp_name]] <- reads_list[["Samp1"]][sample(.N, 5000)]
## }
##
## ## Compute and add p-site details
## psite_offset <- psite(reads_list, flanking = 6, extremity = "auto")
## reads_psite_list <- psite_info(reads_list, psite_offset)
##
## ## Define the list of samples and replicate to use as input
## input_samples <- list("S1" = c("Samp1", "Samp2"),
##                       "S2" = c("Samp3", "Samp4", "Samp5"),
##                       "S3" = c("Samp6"))
##
## Generate bar plots
## example_frames <- frame_psite(reads_psite_list, mm81cdna,
##                               sample = input_samples,
##                               multisamples = "average",
##                               plot_style = "facet",
##                               region = "all",
##                               colour = c("#333f50", "#39827c", "gray70"))
}
\seealso{
\code{\link{frame_psite_length}} for a similar plot stratified by
read length.
}
