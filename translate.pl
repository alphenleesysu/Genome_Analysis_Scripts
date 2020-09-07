#!/usr/bin/perl
use strict;
use Bio::SeqIO;
# use lib '/public1/user/lighong/perl5/lib/perl5';

# Usage: $0 [DNA fasta file] > [output] 2>nohup.out

my $obj=Bio::SeqIO->new(-file=>"$ARGV[0]",-format=>"fasta");

while(my $seq_obj=$obj->next_seq){
	my $id=$seq_obj->display_name;
	my $seq=$seq_obj->seq;
	my $translate=$seq_obj->translate->seq;
	# remove stop codon "*"
	#my $translate=$seq_obj->translatei(-complete=>1)->seq;
	
	print ">$id\n$translate\n";
}

