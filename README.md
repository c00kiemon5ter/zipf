# Zipf
A script to fetch data, process them, and make word lists. Manipulate the lists to find word frequencies and sort according to rank. Calculate related data to prove and hold [Zipf's Law](http://en.wikipedia.org/wiki/Zipf#Zipf.27s_law) for the Greek language. Create related graph-plot. 

## Info
* Total documents: 10.000
* Total words: 4.984.085
* Vocabulary size: 174.258 (unique words)
* Words occuring more than 10 times: 31.133
* Words occuring once: 70.247
* Final b for all words is -1.06015791025300522471

## Plot Graph
![gnuplot-graph](zipf/raw/master/data/results/zipf_plot_greek.png)

## Usage 

	usage: retrieve options

		Options are:
			-a	all, same as -t -m -b -g [Note: no fetch]
			-f	fetch files
			-t	tokenize files
			-m	sort and map tokens - get rank and freq
			-b	calculate b
			-g	create graph plot
			-h	help, print this help message

## Results
Results are placed on [`/tmp/zipf/results`](zipf/tree/master/data/results)

* [`rank.freq.map`](zipf/blob/master/data/results/rank.freq.map) Holds all words and their frequency sorted by their rank
* [`bvalues.map`](zipf/blob/master/data/results/bvalues.map) Report-like file. Holds all words, their frequency, their relational frequency, each word's b-value (also refered as 'a') sorted by the word's rank, including the b-value average rate.
* [`rank.freq.plot`](zipf/blob/master/data/results/rank.freq.plot) Includes just the values (rank and frequency) fed to the graph.
* [`zipf_plot_greek.png`](zipf/blob/master/data/results/zipf_plot_greek.png) The graph image

## Data
Collected data are placed on [`/tmp/zipf/dumpfiles`](zipf/tree/master/data/dumpfiles) <br/>
Processed data are placed on [`/tmp/zipf/tokens`](zipf/tree/master/data/tokens) <br/>
Data are collected from [the Greek Wikipedia](http://el.wikipedia.org) using it's [random page](http://el.wikipedia.org/wiki/%CE%95%CE%B9%CE%B4%CE%B9%CE%BA%CF%8C:%CE%A4%CF%85%CF%87%CE%B1%CE%AF%CE%B1) generator. The script currently collects 10.000 random pages as default.

## Dependencies
Dependencies include 

* [`elinks`](http://elinks.or.cz/) An advanced and well-established feature-rich text mode web browser.
* [`gnuplot`](http://www.gnuplot.info/) a portable command-line driven graphing utility for linux, OS/2, MS Windows, OSX, VMS, and many other platforms

## License
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br/><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title"><a href="https://github.com/c00kiemon5ter/zipf">Zipf Law for the Greek Language</a></span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://c00kiemon5ter.ath.cx" property="cc:attributionName" rel="cc:attributionURL">Ivan Kanakarakis</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.
