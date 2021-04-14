# metashot/prok-pan

metashot/prok-pan is a workflow for pan genome analysis of closely related
prokariotic genomes, mitochondria, and viruses.

- [MetaShot Home](https://metashot.github.io/)

## Main features

- Input: prokaryotic genomes in FASTA format or annotated genomes in GFF3
  format;
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
- `roary`: Roary output files. This folder includes `summary_statistics.txt`
  (number of genes in the core and accessory), `gene_presence_absence.csv` and
  the pangenome plots (`pangenome_*.png`).

### Secondary outputs
- `prokka`: the prokka output for each input sample (if `--annotate = true`);
- `raxml`: RAxML output (when `--skip_core_tree = false`).

## Documentation

### Phylogenetic tree
If `--skip_core_tree = false` the phylogenetic tree is inferred from the core genome alignment using RaxML.

- default mode: construct a maximum likelihood (ML) tree. This mode runs the
  default RAxML tree search algorithm<sup>[1](#footnote2)</sup> and perform
  multiple searches for the best tree (10 distinct randomized MP trees by
  default, see the parameter `--raxml_nsearch`). The following RAxML parameters
  will be used:

  ```bash
  -f d -m GTRCAT -N [RAXML_NSEARCH] -p 42
  ```
- rbs mode: assess the robustness of inference and construct a ML tree. This
  mode runs the rapid bootstrapping full analysis<sup>[2](#footnote3)</sup>. The
  bootstrap convergence criterion or the number of bootstrap searches can be
  specified with the parameter `--raxml_nboot`. The following parameters will be
  used:

  ```bash
  -f a -m GTRCAT -N [RAXML_NBOOT] -p 42 -x 43
  ```

## System requirements
Please refer to [System
requirements](https://metashot.github.io/#system-requirements) for the complete
list of system requirements options.

---

<a name="footnote2">1</a>: Stamatakis A., Blagojevic F., Nikolopoulos D.S. et
      al. *Exploring New Search Algorithms and Hardware for Phylogenetics: RAxML
      Meets the IBM* Cell. J VLSI Sign Process Syst Sign Im 48, 271–286 (2007).
      [Link](https://doi.org/10.1007/s11265-007-0067-4). 
      
<a name="footnote3">2</a>: Stamatakis A., Hoover P., Rougemont J. *A Rapid
      Bootstrap Algorithm for the RAxML Web Servers*. Systematic Biology, Volume
      57, Issue 5, October 2008, Pages 758–771,
      [Link](https://doi.org/10.1080/10635150802429642).

