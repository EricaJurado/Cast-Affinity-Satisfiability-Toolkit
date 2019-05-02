# Using CAST
### Settup
 - Clone this repository.
 - Install python
 - Install clingo
### Input
Required Input Files:
  - interests.txt
  - facets.txt
  - affintiy_rules.lp
  - instance.lp

Interests and facets are listed by name individually on separate lines in their
file, in plain english. The affinity rules and the additional constraints in the
instance file are written in clingo. See the *mario* folder for examples of these
files. See the wiki page (coming soon) for more detailed explainations of all
available clingo constraints that can be added in these files.

Put these files in a shared folder. The name of this folder will be given to the
clingo file formatter. 

### File formatter
In the main directory, run the file formatter by typing:
```sh
$ mkdir generated
$ python3 clingo_file_formatter.py
```
you will be prompted to enter the folder name containing the files specific to your
problem instance. The file formatter will process these files and place all necessary
files into the *generated* folder 

### Running clingo
To run clingo and recieve one possible answer set, do the following:
```sh
$ cd generated
$ clingo 1 *
```
in order to save your computed output for later use, or for network analysis:
```sh
$ clingo 1 * > ../example_output.txt
```
If run multiple times, the results will appear in the same order each time. In order
to produce random output: 
```sh
$ clingo -n 1 --rand-freq=1 *
```
or random output from a seed:
```sh
$ clingo -n 1 --rand-freq=1 --seed=<SEED> *
```
### Network Analysis
In order to run the file that we used to perform network analysis:
```sh
$ python3 networks/network_analysis.py
```
you will be prompted for the name of the file you wish to analyze, as well as the
solution number which you wish to analyze.


