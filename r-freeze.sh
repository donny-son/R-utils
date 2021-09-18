#!/usr/bin/env bash

Rlibdir=''
verbose='false'

while getopts 'd:v' flag
do
    case "${flag}" in
        d) Rlibdir="${OPTARG}";;
        v) verbose='true';;
    esac
done


# Set output directory and output file
outdir=$HOME
outfile=$outdir/r-package-versions.txt

# delete if outfile exists
if [ -f "$outfile" ] ; then
    if $verbose ; then
        echo "Removing existing $outfile"
    fi
    rm "$outfile"
fi


function get_r_pkg_version {
    ls -d */ | egrep -v '^d' | sed -e 's|/||g' | while read pkg
    do
        if [ -f $pkg/DESCRIPTION ] ; then
            version=$(awk '/Version:/' $pkg/DESCRIPTION | sed -e 's|Version:||g')
            echo $pkg\t$version >> $outfile
        else
            echo "$pkg is not an R package"
        fi
    done
}

if [[ -e $Rlibdir ]] ; then
    # when given directory exists
    if $verbose ; then
        echo Fetching R package versions from $Rlibdir...
    fi

    get_r_pkg_version

elif [[ "$Rlibdir" == '' ]] ; then
    # default case
    # Get current R library path
    echo "cat(.libPaths())" > tmp.R
    Rlibdir=$(Rscript tmp.R)
    rm tmp.R

    if $verbose ; then
        echo Fetching R package versions from $Rlibdir...
    fi

    cd $Rlibdir && get_r_pkg_version

else
    echo $Rlibdir does not exists!
    exit 1
fi


if [ -f "$outfile" ] ; then
    echo Success! Saved location is in 
    echo $outfile
    exit 0
fi
