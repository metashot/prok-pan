# metashot/prok-pan

metashot/prok-pan is a workflow for pan genome analysis of closely related
prokariotic genomes, mitochondria, and viruses.

- [MetaShot Home](https://metashot.github.io/)

## Main features

- Input: prokaryotic genomes in FASTA format;
- Rapid prokaryotic genome annotation using
  [prokka](https://github.com/tseemann/prokka);
- Pan genome analysis and visualization using
  [Roary](https://sanger-pathogens.github.io/Roary/);
- Phylogenetic tree inference (core genome) using 
  [RAxML](https://10.1093/bioinformatics/btu033), optional.

## Quick start

1. Install Docker (or Singulariry) and Nextflow (see
   [Dependences](https://metashot.github.io/#dependencies));
1. Start running the analysis:

  ```bash
  nextflow run metashot/prok-pan \
    --genomes "data/*.fa" \
    --outdir results
  ```

## Parameters
See the file [`nextflow.config`](nextflow.config) for the complete list of
parameters.

## Output
The files and directories listed below will be created in the `results`
directory after the pipeline has finished.

### Main outputs
TODO

### Secondary outputs
TODO

## Documentation

### RAxML
This mode runs the default RAxML tree search algorithm<sup>[2](#footnote1)</sup>
and perform multiple searches for the best tree (10 distinct randomized MP trees
by default, see the parameter `--raxml_nsearch`). The following RAxML parameters
will be used:

```bash
-f d -m GTRCAT -N [RAXML_NSEARCH]
```

## System requirements
Please refer to [System
requirements](https://metashot.github.io/#system-requirements) for the complete
list of system requirements options.

---

<a name="footnote1">1</a>: Stamatakis A., Blagojevic F., Nikolopoulos D.S. et
      al. *Exploring New Search Algorithms and Hardware for Phylogenetics: RAxML
      Meets the IBM* Cell. J VLSI Sign Process Syst Sign Im 48, 271–286 (2007).
      [Link](https://doi.org/10.1007/s11265-007-0067-4). 
