# TIBs 2022

```shell
ssh -v diana@hpc-matematicas-z.fciencias.unam.mx -p 2585
scp -P 2585 diana@hpc-matematicas-z.fciencias.unam.mx:/home/diana/data/biogas.tar.gz .
q9Tfl9B4

```



### Datos

Los datos con los que trabajaremos se enlistan en la siguiente tabla. Durante el taller usaremos los datos del microbioma de pacientes con hipertensión **(htn)** y los otros datos se usaran en la práctica por equipos.

| samples   | BioProject                                                   | Article                                                      |
| --------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| htn       | [PRJEB13870](https://www.ebi.ac.uk/ena/browser/view/PRJEB13870?show=reads) | **[Gut microbiota dysbiosis contributes to ...](https://link.springer.com/article/10.1186/s40168-016-0222-x#Ack1)** |
| biogas    | [PRJEB21678](https://www.ebi.ac.uk/ena/browser/view/PRJEB21678) | [**Genetic repertoires of anaerobic microbiomes ...**](https://biotechnologyforbiofuels.biomedcentral.com/articles/10.1186/s13068-018-1258-x). |
| pulque    | [PRJNA603591](https://www.ebi.ac.uk/ena/browser/view/PRJNA603591) | [**Genomic profiling of bacterial and fungal ...**](https://www.nature.com/articles/s41598-020-71864-4) |
| sedimento | [PRJNA364776](https://www.ebi.ac.uk/ena/browser/view/PRJNA364776) | [**Microbial Dark Matter project phase II**](https://www.osti.gov/award-doi-service/biblio/10.46936/10.25585/60000876) * |
| tea       | [PRJNA698063](https://www.ebi.ac.uk/ena/browser/view/PRJNA698063) | [**Niche differentiation of microbes......**)](https://www.researchsquare.com/article/rs-347764/v1) |

### Preprocesamiento

Para obtener los datos necesarios para hacer la reconstrucción de genomas, fue necesario hacer un preprocesamiento de estos, el cual consistió en los siguientes pasos:

1. **Control de calidad:** se verificó la calidad de las lecturas con **[FastQC](https://github.com/s-andrews/FastQC),** este genera reportes que nos permiten verificar el estado de las lecturas, los posibles problemas y que futuros análisis son necesarios. La limpieza se hizo con **[TrimGalore](https://github.com/FelixKrueger/TrimGalore)**, que nos permite eliminar lecturas de baja calidad, adaptadores, etc.

   ```shell
   bash src/01.qc_preprocessing.sh
   ```

2. **Ensamble**: después de la limpieza de las lecturas se realizó un co-ensamble, se utilizaron todas las lecturas generadas para cada estudio. El ensamble se realizó con **[Megahit](https://github.com/voutcn/megahit)**.

   ```shell
   cp results/01.trimgalore/*/*.fq data/
   bash src/change_name_extension.sh
   bash src/02.assembly.sh
   ```

   Nota: Para las muestras de biogas y sedimento, los autores de los datos depositaron también el co-ensable por lo que este ya no fue generado. Sin embargo, se realizó un filtrado por longitud de los contigs, mediante la herramienta **reformat** del programa **[BBtools](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/)**.

   ```shell
   ## activar el ambiente de bbmap
   conda activate /home/dhernandez/.conda/envs/bbmap
   ## ejecutar reformat
   reformat.sh in=contigs.fasta out=filtered.fasta minlength=1000
   ```

3. **Profundidad**: La profundidad de cada contig generado se realizó mediante el mapeo de las lecturas al ensamble. Este paso permite evaluar la calidad del ensable y es necesario para hacer la reconstrucción de genomas ya que, como veremos más adelante, es uno de los parámetros que toman en cuenta los bineadores. El mapeo se realizó con la herramienta BBMap del programa **[BBtools](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/)**.

   ```shell
   ## activar el ambiente de bbmap
   conda activate /home/dhernandez/.conda/envs/bbmap
   ## correr bbmap
   bash src/03.depth_assembly.sh
   ## desactivar el ambiente
   conda deactivate
   ```

### Binning

Explicación del proceso de Binning ...





Utilizaremos varios programas para hacer la reconstrucción de los genomas y haremos una comparación de estos.

**NOTA**: Cada programa tiene una ayuda y un manual de usuario, es **importante** revisarlo y conocer cada parámetro que se ejecute. En terminal se puede consultar el manual con el comando `man` y también se puede consultar la ayuda con `-h` o `--help`, por ejemplo `fastqc -h`.

La presente práctica sólo es una representación del flujo de trabajo, sin embargo, no sustituye los manuales de cada programa y el flujo puede variar dependiendo del tipo de datos y pregunta de investigación.

**¡Manos a la obra!**

Conéctate al servidor:

```shell
ssh USER@hpc-matematicas-z.fciencias.unam.mx
```

Crea tu espacio de trabajo y una liga símbólica hacia los datos que se usarán:

```shell
mkdir -p htn/{data,results,logs}
cd htn
ln -s /home/diana/htn/data/* .
cd ..
```

#### MaxBin

#### BinSanity

#### MetaBat

#### CONCOCT

#### Vamb

### Calidad y limpieza

#### CheckM

#### mmGenome

### Refinamiento

#### DASTool

#### MetaWrap

### Asignación taxonómica

#### GTDBtk

#### MiGA

### Anotación

#### Prokka

#### MEBs

#### KoFamScan

#### EggNogg-Mapper



```shell
scp  -P 2585 htn_coverage_table.tsv diana@hpc-matematicas-z.fciencias.unam.mx:/home/diana/practica/data

##
conda install -c bioconda samtools=1.7
##
concoct --composition_file data/htn.fasta --coverage_file data/htn_coverage_table.tsv -b results/concoct_htn
##
```

