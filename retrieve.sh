#!/usr/bin/env bash

# directories
WORK_DIR="/tmp/zipf"
DUMPPATH="$WORK_DIR/dumpfiles"
TOKENPATH="$WORK_DIR/tokens"
RESULTSPATH="$WORK_DIR/results"
# files
MAPFILE="$RESULTSPATH/rank.freq.map"
BFILE="$RESULTSPATH/bvalues.map"
PLOTDATA="$RESULTSPATH/rank.freq.plot"
PLOTIMG="$RESULTSPATH/zipf_plot_greek.png"

fetch() {
	echo "Starting fetch process.."
	local SRC_URL="http://el.wikipedia.org/wiki/%CE%95%CE%B9%CE%B4%CE%B9%CE%BA%CF%8C:%CE%A4%CF%85%CF%87%CE%B1%CE%AF%CE%B1"

	for file in {1..2000}
	do
		elinks -dump -no-numbering -no-references "$SRC_URL" > "$DUMPPATH/$file.raw"
	done

	echo "Fetching done"
}

tokenize() {
	echo "Processing tokens.."

	cd "$DUMPPATH"
	[ ! -e *.raw &>/dev/null ] \
		&& echo "no data to process. try fetch first" && exit 1

	for file in *.raw
	do
		sed -r "/.*(\s+Link|IMG|\s+\*|\s+_|^\[|^$).*/d" "$file" > "$TOKENPATH/${file/raw/tok}"
		sed -i "s/[^α-ωΑ-Ω]/\n/g" "$TOKENPATH/${file/raw/tok}"
		sed -i "/^$/d" "$TOKENPATH/${file/raw/tok}"
		sed -i "s/\(.*\)/\L\1/" "$TOKENPATH/${file/raw/tok}"
	done

	echo "Tokens ready"
}

sortmap() {
	echo "Mapping started.."

	cd "$TOKENPATH"
	[ ! -e *.tok &>/dev/null ] \
		&& echo "cannot read data. try tokenize first" && exit 1

	sort *.tok | uniq -ci | sort -nr | pr -n -t > "$MAPFILE"

	echo "Mapping complete"
}

calcb() {
	echo "Calculating b for all words.."
	# Zifp's Law: 
	# Freq = 1 / rank^b  =>  log(Freq) = -b * log(rank)
	# => b = - log(Freq) / log(rank) = -log[rank](Freq)

	[ ! -e "$MAPFILE" ] && \
		echo "cannot read data. try mapping first" && exit 1

	local bval=0 bw=0 nwords=$(wc -l "$MAPFILE" | awk '{print $1}')
	echo "Rank\tFrequency\tPn-Frequency\tb-value\tWord" > "$BFILE"

	while read rank freq word
	do
		PnFreq=$(bc -l <<< "$freq / $nwords")
		(( "$rank" <= 1 )) && bw=0 ||
		bw="$(bc -l <<< "l($PnFreq) / l($rank)")"
		echo -e "$rank\t$freq\t$PnFreq\t$bw\t$word" >> "$BFILE"
		bval="$(bc -l <<< "$bval + $bw")"
	done < "$MAPFILE"
	bval="$(bc -l <<< "$bval / $nwords")"
	echo "Final b is $bval" >> "$BFILE"

	echo "Done calculating"
}

graph() {
	echo "Starting graph creation"

	[ ! -e "$MAPFILE" ] && \
		echo "cannot read data. try mapping first" && exit 1

	awk '{print $1 " " $2}' "$MAPFILE" > "$PLOTDATA"
	gnuplot << EOF
set logscale
set xlabel "Rank"
set ylabel "Frequency"
set title "Zipf's Law - Greek language - Wikipedia documents collection"
set term png
set output "$PLOTIMG"
plot "$PLOTDATA"
EOF

	echo "Graph created"
}

usage() {
	cat << EOF
usage: $(basename "$0") options

	Options are:
	-a	all, same as -t -m -b -g [Note: no fetch]
	-f	fetch files
	-t	tokenize files
	-m	sort and map tokens - get rank and freq
	-b	calculate b
	-g	create graph plot
	-h	help, print this help message
EOF
}

(( !$# )) && usage && exit 1
mkdir -p "$WORK_DIR" "$DUMPPATH" "$TOKENPATH" "$RESULTSPATH"
user_dir="$PWD"
case "$1" in 
	-a) tokenize; sortmap; calcb; graph;;
	-f) fetch;;
	-t) tokenize;;
	-s) sortmap;;
	-b) calcb;;
	-g) graph;;
	-h) usage && exit 0;;
	*) usage && exit 1;;
esac
cd "$user_dir"
