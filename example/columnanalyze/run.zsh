#! /usr/bin/zsh

cat qstat.out | columnanalyze
echo ------------------------------------------------------------
cat qstat.out | columnanalyze 4
echo ------------------------------------------------------------
cat qstat.out | columnanalyze 4 5
echo ------------------------------------------------------------
cat qstat.out | columnanalyze 4=bob
echo ------------------------------------------------------------
cat qstat.out | columnanalyze 4=bob 5=r
echo ------------------------------------------------------------
cat qstat.out | columnanalyze 4=bob 5=r 3
