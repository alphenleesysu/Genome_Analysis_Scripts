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
  
  my $gene1=$LINE[1];
  my $gene2=$LINE[2];
  my $gene3=$LINE[3];
  my $gene4=$LINE[4];
  my $gene5=$LINE[5];
  my $gene6=$LINE[6];
  my $gene7=$LINE[7];
  my $gene8=$LINE[8];
  my $gene9=$LINE[9];
  my $gene10=$LINE[10];
  my $gene11=$LINE[11];
  my $faa_seq1=$faa_db->seq($gene1);
  my $faa_seq2=$faa_db->seq($gene2);
  my $faa_seq3=$faa_db->seq($gene3);
  my $faa_seq4=$faa_db->seq($gene4);
  my $faa_seq5=$faa_db->seq($gene5);
  my $faa_seq6=$faa_db->seq($gene6);
  my $faa_seq7=$faa_db->seq($gene7);
  my $faa_seq8=$faa_db->seq($gene8);
  my $faa_seq9=$faa_db->seq($gene9);
  my $faa_seq10=$faa_db->seq($gene10);
  my $faa_seq11=$faa_db->seq($gene11);
# alter num: add my "$faa_seqXXX=$faa_db->seq($geneXXX);"


# print to tmp.faa
  open my $faa_out,">./tmp.ng/tmp.faa"||die;
  print $faa_out  ">$gene1\n$faa_seq1\n>$gene2\n$faa_seq2\n>$gene3\n$faa_seq3\n>$gene4\n$faa_seq4\n>$gene5\n$faa_seq5\n>$gene6\n$faa_seq6\n>$gene7\n$faa_seq7\n>$gene8\n$faa_seq8\n>$gene9\n$faa_seq9\n>$gene10\n$faa_seq10\n>$gene11\n$faa_seq11\n";
# alter num: add ">$geneXXX\n$faa_seqXXX\n"
  close $faa_out;

  my $fna_seq1=$fna_db->seq($gene1);
  my $fna_seq2=$fna_db->seq($gene2);
  my $fna_seq3=$fna_db->seq($gene3);
  my $fna_seq4=$fna_db->seq($gene4);
  my $fna_seq5=$fna_db->seq($gene5);
  my $fna_seq6=$fna_db->seq($gene6);
  my $fna_seq7=$fna_db->seq($gene7);
  my $fna_seq8=$fna_db->seq($gene8);
  my $fna_seq9=$fna_db->seq($gene9);
  my $fna_seq10=$fna_db->seq($gene10);
  my $fna_seq11=$fna_db->seq($gene11);
# alter num: add my "$fna_seqXXX=$fna_db->seq($geneXXX);"

# print to tmp.fna
  open my $fna_out,">./tmp.ng/tmp.fna"||die;
  print $fna_out  ">$gene1\n$fna_seq1\n>$gene2\n$fna_seq2\n>$gene3\n$fna_seq3\n>$gene4\n$fna_seq4\n>$gene5\n$fna_seq5\n>$gene6\n$fna_seq6\n>$gene7\n$fna_seq7\n>$gene8\n$fna_seq8\n>$gene9\n$fna_seq9\n>$gene10\n$fna_seq10\n>$gene11\n$fna_seq11\n";
# alter num: add ">$geneXXX\n$fna_seqXXX\n"
  close $fna_out;

# muscle to muscle_tmp.faa
  system("muscle -in ./tmp.ng/tmp.faa  -out ./tmp.ng/muscle_tmp.faa 2>>./tmp.ng/nohup.out ");

# cat together muscle_tmp.faa to tmp_check_muscle_aln.faa
  system("cat ./tmp.ng/muscle_tmp.faa>> ./tmp.ng/tmp_check_muscle_aln.faa");
  system("echo >>./tmp.ng/tmp_check_muscle_aln.faa "); 

# pal2nal muscle_tmp.faa to pal2nal_tmp.fna (maybe the -nomismatch setting can avoid the ambiguity of stop codon and so on?)
  system("~/software/pal2nal.v14/pal2nal.pl  ./tmp.ng/muscle_tmp.faa  ./tmp.ng/tmp.fna  -nogap -nomismatch -output fasta >./tmp.ng/pal2nal_tmp.fna");
#parse multiple-line pal2nal_tmp.fna to single-line pal2nal_tmp.fna1
  system("./ng.single_line_fasta.sh");
# cat together pal2nal_tmp.fna1 to tmp_check_pal2nal.fna
  system("cat ./tmp.ng/pal2nal_tmp.fna1 >>./tmp.ng/tmp_check_pal2nal.fna");

# print to standard output 
#  print "$LINE[0]|$gene1|$gene2 \n";
  system("cat ./tmp.ng/pal2nal_tmp.fna1" );
  print "\n\n";
}

close $IN;
