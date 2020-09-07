#!/usr/bin/perl
use strict;
die unless @ARGV==1;

open my $IN,"<$ARGV[0]"||die;

while(<$IN>){
  chomp;
  my @LINE=split();
  if ($LINE[1] eq "-"){
    $LINE[2]=~tr/ATCGatcg/TAGCtagc/;
    $LINE[2]=reverse($LINE[2]);
  }
  print "$LINE[0]\t$LINE[1]\n$LINE[2]\n";
}
close $IN;
