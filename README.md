# evolved-nanno
Code to analyze genomic variation bewteen evolved strains of *Nannochloropsis salina*

## Variant calling ([`evolved-nanno/sarek`](https://github.com/serenalotreck/evolved-nanno/tree/main/sarek))
The [sarek](https://nf-co.re/sarek/3.5.1/) pipeline from `nf-core` was used for all variant calling. We tested 3 variant callers within this pipeline: strelka, freebayes, and LoFreq.

As strelka is the variant caller that produced the best results andw as used to identify candidate loci, the `run_sarek_TEMPLATE` file contains `strelka` as the variant caller. In order to run freebayes, just substitute `freebayes` for `strelka`, and change the `-config` path to the freebayes-specific slurm configuration, also provided in this directory. Both strelka and freebayes were run with two separate samplesheets to accomodate the presence of two control replicates in a tumor/normal setting, so they are set up as job arrays over the samplesheets listed in the `samplesheets.txt` file.

LoFreq doesn't have the same capacity as strelka and freebayes to run tumor/normal pairs, and will fail if provided with a samplesheet that has both 0's and 1's int he `status` column. Therefore, a different samplesheet has been provided specifically for LoFreq, and it does not need to be run as an array job, soi t also has a separate job template file.

Each variant caller's results are characterized in a notebook beginning with the same name in the [`notebooks`](https://github.com/serenalotreck/evolved-nanno/blob/main/notebooks/) directory.

## Candidate gene identification
All candidate gene identification was performed in the notebook [`evolved-nanno/notebooks/strelka_variant_exploration.ipynb`](https://github.com/serenalotreck/evolved-nanno/blob/main/notebooks/strelka_variant_exploration.ipynb)

## Data availability
The genome, genome annotation, and WGS files used for these analyses can be found at TODO
