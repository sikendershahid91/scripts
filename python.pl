#!/usr/bin/env perl
										
# standalone script helps start a python project 


use strict;
use warnings;

my $help = 'Usage: perl python.pl [project name str] [path name str]'; 
die "$help\n" if ( $#ARGV > 1 or $#ARGV < 0 or $ARGV[0] eq '-h'); 
my $project_name = $ARGV[0] or die "Error: Provide project name\n$help\n"; 
my $project_path = $ARGV[1] or die "Error: Provide path name\n$help\n"; 

chdir($project_path); 

mkdir uc("$project_name"); 
mkdir "$project_name/src"; 
mkdir "$project_name/test"; 
chdir(uc($project_name)) or die "Error: Cant change directory"; 
$project_name = lc($project_name); 

my @files = (
	"src/main_$project_name.py", 
	"src/$project_name.py", 
	"test/$project_name\_test.py"
	); 

foreach(@files){ 
	open my $out, '>', "$_"or die "Didn't create files: $!\n"; 
	if(/main/){
		print $out "def main():\n";
		print $out "\tpass\n\n"; 
		print $out "if __name__ == '__main__':\n";
		print $out "\tmain()\n";
	}

	if(/test/){
		s/.py//;
		s/_//;
		s/test/Test/g; 
		s/\/(\w+)/\/\u$1/g;
		print $out "import unittest\n"; 
		print $out "from unittest.mock import patch, Mock\n"; 
		print $out "\n\nclass ".(split '/', $_)[-1]."(unittest.TestCase):\n"; 
		print $out "\tdef setUp(self):\n";
		print $out "\t\tpass\n";
		print $out "\tdef test_BEHAVIOR_OF_TEST(self):\n"; 
		print $out "\t\tpass\n"; 
	}
	close($out); 
}

open my $out, '>', "pavement.py" or die "Didn't create paver file: $!\n"; 
my $file_content =
"#!/usr/bin/env python3

from paver.easy import *
import paver.doctools
import os
import glob
import shutil

\@task
def run():
\tif os.name == 'nt':
\t\tsh('py -3 src/main_$project_name.py')
\telse:
\t\tsh('python3 src/main_$project_name.py')

\@task
def test():
\tsh('nosetests --with-coverage --cover-erase --cover-package=src --cover-html test')
\tpass

\@task
def clean():
\tfor pycfile in glob.glob(".'"*/*/*.pyc"'."): os.remove(pycfile)
\tfor pycache in glob.glob(".'"*/__pycache__"'."): os.removedirs(pycache)
\tfor pycache in glob.glob(".'"./__pycache__"'."): shutil.rmtree(pycache)
\tfor cover in glob.glob(".'"./cover"'."): shutil.rmtree(cover)
\tpass

\@task
\@needs(['clean', 'test', 'run'])
def default():
\tpass

";

print $out $file_content; 

close($out);

system('paver') == 0 or print "\nNeed to install paver,nose,coverage";

print "\n\nProject created in path: \n   $project_path" and exit(0); 