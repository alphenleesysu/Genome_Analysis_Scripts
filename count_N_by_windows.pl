#!/usr/bin/perl
use strict;
use Bio::SeqIO;
use POSIX;

die "Usage: perl $0 <fasta> <bin_length> <the character you want to count> <tail_seq_length_is_longer than XX bp> \n
	example: 1. perl count_N_by_windows.pl bse.fa 100 [G,C,g,c] 0 > tmp.out 
		 2. perl count_N_by_windows.pl bse.fa 100 \\# 0 > tmp.out\n" unless @ARGV==4;

# define glocal variable
my $obj=Bio::SeqIO->new(-file=>"$ARGV[0]",-format=>"fasta");
my $bin=$ARGV[1];

# define the function for counting GC ratio
sub gc_Count{
  my ($sub_seq,$start,$end,$gc,$n,$ratio)=(undef,1,undef,0,0,undef);

  # throw error if sequence shorter than a bin
  if(length($_[0])<$bin){
    print "error:sequence $_[1] shorter than a bin\n";
    return;
  }
  
  # count GC ratio by sliding window
  for(my $i=1;$i<=length($_[0])/$bin;$i++){
      
        $sub_seq=substr($_[0],$start-1,$bin);
        $gc=($sub_seq=~/$ARGV[2]/)?$sub_seq=~s/$ARGV[2]//g:0;
        $n=($sub_seq=~/[N,n]/)?$sub_seq=~s/[N,n]//g:0;
        # "eval" is used to transfer the biaoliang into variable inside the "tr" expression
        my $tmp=$bin-$n;
        $ratio=$tmp==0?0:$gc/$tmp;
        $end=$start+$bin-1;
        print "$_[1]\t$start\t$end\t$bin\t$n\t$gc\t$ratio\n";   
        $start=$start+$bin;
  }
 
  # deal with the tail part
  my $seq_len=length($_[0]);
  my $tail_start=floor($seq_len/$bin)*$bin+1;
    #get the tail sequence
  if($tail_start<=$seq_len){
    my $tail_len=$seq_len-$tail_start+1;
    my $tail_seq=substr($_[0],$tail_start-1,$tail_len);
    my ($tail_gc,$tail_n)=(0,0);
    my $tail_gc=($tail_seq=~/$ARGV[2]/)?$tail_seq=~s/$ARGV[2]//g:0;
    my $tail_n=($tail_seq=~/[N,n]/)?$tail_seq=~s/[N,n]//g:0;

    my $tmp=$tail_len-$tail_n;
    my $tail_ratio=($tmp==0)?0:$tail_gc/$tmp;
    # if tail longer than ..., then count the tail and print
    if($tail_len>=$ARGV[3]){
    print "$_[1]\t$tail_start\t$seq_len\t$tail_len\t$tail_n\t$tail_gc\t$tail_ratio\n";
    }
  }
 
}

# count GC ratio of each sequence and print
print "#chr\tstart\tend\tbin\tn\t$ARGV[2]\tratio\n";
while (my $seq=$obj->next_seq){
  gc_Count($seq->seq,$seq->display_name);
}

