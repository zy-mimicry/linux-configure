#! /usr/bin/env perl
#deal.pl

use 5.018;
use warnings;
use strict;

die "Shouldn't pass the args: $!" if @ARGV >= 1;

my $top = $ENV{"IM_TOP"};

my $self_file_conf_path = "";
my $kernel_conf_path =  "";
my $self_conf_file = "file.in.conf";
my $in_file_name = "need_deal.in";
my $out_file_name = "file.out";

die "Files are not exist!" unless -e "$top/$self_file_conf_path/$self_conf_file" and -e "$top/$kernel_conf_path/$in_file_name"; 

open IN_FILE, "< $top/$self_file_conf_path/$self_conf_file" and
    open OUT_FILE ,"> $top/$kernel_conf_path/$out_file_name" and
    open IN_CONFIG, "< $top/$kernel_conf_path/$in_file_name" or
    die "Open files failed: $!";

my @in_file_lines = <IN_FILE>;
my @config_in_lines = <IN_CONFIG>;
my @out_file_buffer;

my %file_struct = (
    "history" => undef,
    "contexts" => undef
);
my @true_configs;
my %in_file_contexts;

die "Signature Failed." unless @in_file_lines ~~ m/\{.*(telecom).*\}/i;

my $hit="";
my $region="";
foreach (@in_file_lines){
    if (m/\[history\]/i){
        $hit = "hit history";
        next;
    }elsif (m/\[contexts\]/i){
        $hit = "hit contexts";
        next;
    }

    if ($hit eq "hit history") {
        $hit = "";
        if (m/\{(.*)\}/i){
            $file_struct{"history"} = $1;
        }else{
            die "History section is None." ;
        }
    } elsif ($hit eq "hit contexts"){
        #$hit = "";
        if (m/^{$/){
            $region="in";
            next;
        }elsif (m/^}$/){
            $file_struct{"contexts"} = \@true_configs;
            undef $hit;
            undef $region;
            last;
        }elsif ($region eq "in"){
            if (m/\s*([A-Za-z0-9_"']*)\s*=\s*([A-Za-z0-9_"']*)\s*/){
				push @true_configs , "$1" . "=" .  "$2" . "\n";
                $in_file_contexts{$1} = $2;
            }
            next;
        }
    }
}

foreach (@config_in_lines){
    (m/\s*(.*)\s*=(.*)/)
        ? (exists $in_file_contexts{$1})
            ? push @out_file_buffer, "#" . $_
            : push @out_file_buffer , $_
        : push @out_file_buffer, $_;
}

push @out_file_buffer,"\n". $file_struct{"history"};
push @out_file_buffer,$_ foreach (@true_configs);
push @out_file_buffer,$file_struct{"history"};

chomp @out_file_buffer;
say OUT_FILE "$_" foreach (@out_file_buffer);

close IN_FILE and close OUT_FILE and close IN_CONFIG;
