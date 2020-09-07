#!/usr/bin/perl
use strict;
use Bio::DB::Fasta;

die "Usage : perl $0 <faa> <fna> <coll_file>  >  <output> \n coll file format: \"gene1 gene2\" for each line " unless @ARGV==3;

if(-d "./tmp.ng"){
  system("rm -rf ./tmp.ng && mkdir ./tmp.ng");
}else{system("mkdir ./tmp.ng");}

my $faa_db=Bio::DB::Fasta->new($ARGV[0]);
my $fna_db=Bio::DB::Fasta->new($ARGV[1]);


open my $IN,"<$ARGV[2]"||die;
while(<$IN>){
  chomp;
  my @LINE=split(/\s/);
  
  my $gene1=$LINE[0];
  my $gene2=$LINE[1];
  my $faa_seq1=$faa_db->seq($gene1);
  my $faa_seq2=$faa_db->seq($gene2);
  open my $faa_out,">./tmp.ng/tmp.faa"||die;
#print "gene1 $gene1 gene2 $gene2\n";

# print to tmp.faa
  print $faa_out  ">$gene1\n$faa_seq1\n>$gene2\n$faa_seq2\n";

  close $faa_out;

  my $fna_seq1=$fna_db->seq($gene1);
  my $fna_seq2=$fna_db->seq($gene2);
  open my $fna_out,">./tmp.ng/tmp.fna"||die;
#print "gene1 $gene1 gene2 $gene2\n";

#print to tmp.fna
  print $fna_out  ">$gene1\n$fna_seq1\n>$gene2\n$fna_seq2\n";
  close $fna_out;

# muscle to muscle_tmp.faa
  system("linsi ./tmp.ng/tmp.faa > ./tmp.ng/linsi_tmp.faa 2>>./tmp.ng/nohup.out ");

# cat together muscle_tmp.faa to tmp_check_muscle_aln.faa
#  system("cat ./tmp.ng/muscle_tmp.faa>> ./tmp.ng/tmp_check_muscle_aln.faa");
#  system("echo >>./tmp.ng/tmp_check_muscle_aln.faa "); 

# pal2nal muscle_tmp.faa to pal2nal_tmp.fna (maybe the -nomismatch setting can avoid the ambiguity of stop codon and so on?)
  system("~/software/pal2nal.v14/pal2nal.pl  ./tmp.ng/linsi_tmp.faa  ./tmp.ng/tmp.fna  -nogap -nomismatch -output fasta >./tmp.ng/pal2nal_tmp.fna");
#parse multiple-line pal2nal_tmp.fna to single-line pal2nal_tmp.fna1
  system("./ng.single_line_fasta.sh");
# cat together pal2nal_tmp.fna1 to tmp_check_pal2nal.fna
#  system("cat ./tmp.ng/pal2nal_tmp.fna1 >>./tmp.ng/tmp_check_pal2nal.fna");

# print to standard output 
  print "$gene1|$gene2|$LINE[2]\n";
  system("grep -v '>' ./tmp.ng/pal2nal_tmp.fna1 2>>nohup.out" );
  print "\n";
}

close $IN;
