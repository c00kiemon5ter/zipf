# Zipf
A script to fetch data, process them, and make word lists. Manipulate the lists to find word frequencies and sort according to rank. Calculate related data to prove and hold [Zipf's Law](http://en.wikipedia.org/wiki/Zipf) for the Greek language. Create related graph-plot. 

## Plot Graph
![gnuplot-graph](blob/master/data/results/zipf_plot_greek.png)

## Usage 

	usage: retrieve.sh options

		Options are:
			-a	all, same as -t -m -b -g [Note: no fetch]
			-f	fetch files
			-t	tokenize files
			-m	sort and map tokens - get rank and freq
			-b	calculate b
			-g	create graph plot
			-h	help, print this help message

## Results
Results are placed on [`/tmp/zipf/results`](tree/master/data/results)

* [`rank.freq.map`](blob/master/data/results/rank.freq.map) Holds all words and their frequency sorted by their rank
* [`bvalues.map`](blob/master/data/results/bvalues.map) Report-like file. Holds all words, their frequency, their relational frequency, each word's b-value (also refered as 'a') sorted by the word's rank, including the b-value average rate.
* [`rank.freq.plot`](blob/master/data/results/rank.freq.plot) Includes just the values (rank and frequency) fed to the graph.
* [`zipf_plot_greek.png`](blob/master/data/resulrs/zipf_plot_greek.png) The graph image

## Data
Collected data are placed on [`/tmp/zipf/dumpfiles`](tree/master/data/dumpfiles)
Processed data are placed on [`/tmp/zipf/tokens`](tree/master/data/tokens)
Data are collected from [the Greek Wikipedia](http://el.wikipedia.org) using it's [random page](http://el.wikipedia.org/wiki/%CE%95%CE%B9%CE%B4%CE%B9%CE%BA%CF%8C:%CE%A4%CF%85%CF%87%CE%B1%CE%AF%CE%B1) generator. The script currently collects 2000 random pages.

## Dependencies
Dependencies include 

* [`elinks`](http://elinks.or.cz/) An advanced and well-established feature-rich text mode web browser.
* [`gnuplot`](http://www.gnuplot.info/) a portable command-line driven graphing utility for linux, OS/2, MS Windows, OSX, VMS, and many other platforms

