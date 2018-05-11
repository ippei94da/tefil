#! /bin/sh

linesplit sample1.txt --separator="." --except="Fig."
linesplit sample2.txt --separator="。 ． 、 ，"
linesplit sample3.txt --separator="、 。" --except="Fig."
linesplit sample4.txt --strip
