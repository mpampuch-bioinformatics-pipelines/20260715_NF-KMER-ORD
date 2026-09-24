# Resource estimates for big data
  
## WADIZEE data

These data were this big

```
file                                                                                                                                                                             format  type  num_seqs        sum_len  min_len   avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/61_Pleodorinaillinoisensis/61_Pleodorinaillinoisensis.hifi_reads.fastq  FASTQ   DNA    269,123  2,845,287,257      289  10,572.4   50,331
file                                                                                                                                                                       format  type  num_seqs        sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/62_Coelastrummicroporum/62_Coelastrummicroporum.hifi_reads.fastq  FASTQ   DNA    882,730  7,715,113,255      175  8,740.1   54,892
file                                                                                                                                                                           format  type  num_seqs      sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/63_Monoraphidiumcircinale/63_Monoraphidiumcircinale.hifi_reads.fastq  FASTQ   DNA    145,416  981,279,844      191  6,748.1   37,718
file                                                                                                                                                             format  type  num_seqs        sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/64_Chlamydomonassp/64_Chlamydomonassp.hifi_reads.fastq  FASTQ   DNA    319,754  2,969,380,655      177  9,286.5   47,928
file                                                                                                                                                                 format  type  num_seqs        sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/65_Phormidesmismolle/65_Phormidesmismolle.hifi_reads.fastq  FASTQ   DNA    377,148  2,988,320,293      161  7,923.5   44,645
q2file                                                                                                                                                         format  type  num_seqs        sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/66_Desmodesmussp/66_Desmodesmussp.hifi_reads.fastq  FASTQ   DNA    503,386  4,666,868,069      168    9,271   48,125
file                                                                                                                                                         format  type  num_seqs         sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/67_Scenedesmussp/67_Scenedesmussp.hifi_reads.fastq  FASTQ   DNA    988,205  12,499,795,226      147   12,649   49,926
file                                                                                                                                                     format  type  num_seqs        sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/68_Nitzschiasp/68_Nitzschiasp.hifi_reads.fastq  FASTQ   DNA    307,737  2,186,901,517       83  7,106.4   34,207
file                                                                                                                                                                         format  type  num_seqs        sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/70_Fistuliferasaprophila/70_Fistuliferasaprophila.hifi_reads.fastq  FASTQ   DNA    428,240  4,247,020,542      213  9,917.4   53,844
file                                                                                                                                                         format  type  num_seqs        sum_len  min_len  avg_len  max_len
/ibex/project/c2303/ALL-BCL-SEQ-READS/BCLCustomers/lauersk/Revio/r84180_20260101_070352/1_C01/version_01/71_Desmodesmussp/71_Desmodesmussp.hifi_reads.fastq  FASTQ   DNA    302,635  2,568,773,939       89    8,488   51,117
  ```

Here are the resources used from the execution trace

```
sample	treatment	kmer	status	exit	duration	realtime	%cpu	peak_rss	peak_vmem	rchar	wchar	duration_s	realtime_s	peak_rss_gb	peak_vmem_gb
KAUST061	no_pca_pre	k6	COMPLETED	0	4h 56m 8s	4h 56m 2s	349.6%	20.8 GB	48.8 GB	47.5 GB	28.1 GB	17768	17762	20.8	48.8
KAUST061	pca_pre	k6	COMPLETED	0	4h 7m 2s	4h 6m 58s	255.4%	20.2 GB	48.9 GB	44.5 GB	26 GB	14822	14818	20.2	48.9
KAUST061	pca_pre_ipca	k6	COMPLETED	0	4h 40m 23s	4h 38m 59s	290.2%	18.6 GB	48.9 GB	45.1 GB	26 GB	16823	16739	18.6	48.9
KAUST063	no_pca_pre	k6	COMPLETED	0	3h 16m 47s	3h 16m 44s	172.5%	11.3 GB	44.3 GB	14.6 GB	7.6 GB	11807	11804	11.3	44.3
KAUST063	pca_pre	k6	COMPLETED	0	1h 54m 46s	1h 54m 28s	214.8%	9.3 GB	43.4 GB	11.7 GB	6.5 GB	6886	6868	9.3	43.4
KAUST063	pca_pre_ipca	k6	COMPLETED	0	1h 48m 20s	1h 48m 14s	227.1%	9.8 GB	43.9 GB	11.6 GB	6.5 GB	6500	6494	9.8	43.9
KAUST064	no_pca_pre	k6	COMPLETED	0	8h 20m 19s	8h 18m 33s	463.2%	19.7 GB	51 GB	37.6 GB	18.1 GB	30019	29913	19.7	51
KAUST064	pca_pre	k6	COMPLETED	0	6h 32m 5s	6h 31m 57s	290.2%	17.8 GB	50.8 GB	33.1 GB	15.8 GB	23525	23517	17.8	50.8
KAUST064	pca_pre_ipca	k6	COMPLETED	0	6h 40m 48s	6h 39m 15s	334.7%	17.8 GB	50.9 GB	33.3 GB	15.8 GB	24048	23955	17.8	50.9
KAUST065	no_pca_pre	k6	COMPLETED	0	2h 54m 10s	2h 52m 2s	579.8%	23.5 GB	52 GB	42.1 GB	20.5 GB	10450	10322	23.5	52
KAUST065	pca_pre	k6	COMPLETED	0	5h 31m 25s	5h 31m 19s	219.4%	19.2 GB	51.9 GB	33.3 GB	17.7 GB	19885	19879	19.2	51.9
KAUST065	pca_pre_ipca	k6	COMPLETED	0	5h 46m 39s	5h 45m 45s	248.9%	18.5 GB	51.9 GB	33.6 GB	17.7 GB	20799	20745	18.5	51.9
KAUST066	no_pca_pre	k6	COMPLETED	0	7h 23m 47s	7h 22m 38s	251.6%	38.7 GB	55.4 GB	52.3 GB	28.7 GB	26627	26558	38.7	55.4
KAUST066	pca_pre	k6	COMPLETED	0	7h 41m 39s	7h 41m 36s	187.4%	27.4 GB	55.5 GB	48.8 GB	25.1 GB	27699	27696	27.4	55.5
KAUST066	pca_pre_ipca	k6	COMPLETED	0	7h 12m 3s	7h 12m	193.2%	27.4 GB	55.4 GB	48.1 GB	25.1 GB	25923	25920	27.4	55.4
KAUST068	no_pca_pre	k6	COMPLETED	0	6h 23m 44s	6h 23m 35s	233.1%	20.6 GB	50.7 GB	30.7 GB	16.2 GB	23024	23015	20.6	50.7
KAUST068	pca_pre	k6	COMPLETED	0	4h 20m 39s	4h 20m 34s	233.0%	16.6 GB	50.6 GB	25.7 GB	13.9 GB	15639	15634	16.6	50.6
KAUST068	pca_pre_ipca	k6	COMPLETED	0	4h 11m 55s	4h 11m 53s	214.9%	17.9 GB	50.3 GB	25.4 GB	13.9 GB	15115	15113	17.9	50.3
KAUST070	no_pca_pre	k6	COMPLETED	0	6h 12m 55s	6h 12m 50s	272.1%	27.4 GB	53.1 GB	46 GB	24.9 GB	22375	22370	27.4	53.1
KAUST070	pca_pre	k6	COMPLETED	0	3h 48m 17s	3h 48m 14s	279.4%	25 GB	53.1 GB	46.8 GB	21.7 GB	13697	13694	25	53.1
KAUST070	pca_pre_ipca	k6	COMPLETED	0	3h 47m 40s	3h 47m 36s	299.7%	25 GB	52.6 GB	46.5 GB	21.7 GB	13660	13656	25	52.6
KAUST071	no_pca_pre	k6	COMPLETED	0	2h 41m 7s	2h 41m 3s	344.6%	28.5 GB	50.6 GB	33.1 GB	16.8 GB	9667	9663	28.5	50.6
KAUST071	pca_pre	k6	COMPLETED	0	2h 38m 7s	2h 34m 49s	229.8%	16.3 GB	50.4 GB	30.4 GB	14.5 GB	9487	9289	16.3	50.4
KAUST071	pca_pre_ipca	k6	COMPLETED	0	1h 43m 33s	1h 43m 29s	245.7%	16.1 GB	50.1 GB	30.4 GB	14.5 GB	6213	6209	16.1	50.1
```


## New data:

These data are this big:

```
file                             format  type   num_seqs         sum_len  min_len  avg_len  max_len
SRX9925339_SRR13514087.fastq.gz  FASTQ   DNA   9,987,580  58,717,280,955       50    5,879  559,994
file                             format  type    num_seqs          sum_len  min_len  avg_len  max_len
SRX9925340_SRR13514086.fastq.gz  FASTQ   DNA   41,239,309  308,046,225,426       50  7,469.7  429,532
file                              format  type   num_seqs         sum_len  min_len   avg_len  max_len
SRX27934295_SRR32629517.fastq.gz  FASTQ   DNA   1,303,039  21,205,330,538      152  16,273.7   48,606
file                              format  type   num_seqs         sum_len  min_len   avg_len  max_len
SRX27934296_SRR32629516.fastq.gz  FASTQ   DNA   1,963,960  32,702,845,955      127  16,651.5   48,292
```


How can I estimate how many memory each new dataset should get for the projection workflow


**ChatGPT:**

Yes. The existing runs are enough to make a **first-order walltime estimate**, but I would be much more cautious about extrapolating memory. The new datasets are substantially larger than your calibration set, especially the 308 Gb dataset.

The key point is that your workflow's **runtime scales roughly with input size**, while **peak RSS does not show a clean linear relationship with input size** in the existing runs.

### 1. First, put the datasets on the same scale

Using `sum_len` as the measure of sequence data:

| Dataset | Total bases | Size relative to largest old dataset |
| --- | --- | --- |
| 61 | 2.85 Gb | 0.23× |
| 62 | 7.72 Gb | 0.62× |
| 63 | 0.98 Gb | 0.08× |
| 64 | 2.97 Gb | 0.24× |
| 65 | 2.99 Gb | 0.24× |
| 66 | 4.67 Gb | 0.37× |
| **67** | **12.50 Gb** | **1.00×** |
| 68 | 2.19 Gb | 0.17× |
| 70 | 4.25 Gb | 0.34× |
| 71 | 2.57 Gb | 0.21× |
| **New 1** | **58.72 Gb** | **4.70×** |
| **New 2** | **308.05 Gb** | **24.65×** |
| **New 3** | **21.21 Gb** | **1.70×** |
| **New 4** | **32.70 Gb** | **2.62×** |

So the 308 Gb dataset is **~25× larger than your largest previous dataset**.

* * *

# 2. Walltime: this is reasonably predictable

For the existing data, I would use approximately these empirical rates:

| Treatment | Typical walltime |
| --- | --- |
| `no_pca_pre` | ~1.6–2.0 h / Gb |
| `pca_pre` | ~1.3–1.8 h / Gb |
| `pca_pre_ipca` | ~1.3–1.8 h / Gb |

There is considerable sample-to-sample variation, so I would not use a single exact number.

A simple linear fit to your previous runs gives:

* `no_pca_pre`: ~**1.0 h + 1.0 h/Gb**
* `pca_pre`: ~**1.2 h/Gb**
* `pca_pre_ipca`: ~**1.1 h/Gb**

But the individual runs vary by roughly a factor of 2, so I'd use a range rather than the fitted line.

### Estimated walltimes

| Dataset | Gb | `no_pca_pre` | `pca_pre` | `pca_pre_ipca` |
| --- | --- | --- | --- | --- |
| New 1 | 58.7 | **~50–120 h** | **~45–105 h** | **~45–105 h** |
| New 2 | 308.0 | **~250–600 h** | **~230–550 h** | **~230–550 h** |
| New 3 | 21.2 | **~20–45 h** | **~18–40 h** | **~18–40 h** |
| New 4 | 32.7 | **~25–65 h** | **~25–60 h** | **~25–60 h** |

I would actually request somewhat more than the upper end for production jobs, because your old data show substantial variation.

For example, for a scheduler request I'd initially use approximately:

| Dataset | `no_pca_pre` | `pca_pre` | `pca_pre_ipca` |
| --- | --- | --- | --- |
| 58.7 Gb | **3 days** | **3 days** | **3 days** |
| 308 Gb | **10–14 days** | **10–14 days** | **10–14 days** |
| 21.2 Gb | **2 days** | **2 days** | **2 days** |
| 32.7 Gb | **3 days** | **3 days** | **3 days** |

Those are deliberately conservative walltime requests rather than predictions of actual runtime.

* * *

# 3. Memory is the tricky part

This is where I **would not extrapolate linearly**.

Your old data show:

* 1 Gb → ~9–11 GB RSS
* 2–3 Gb → ~16–29 GB RSS
* 4.2–4.7 Gb → ~25–39 GB RSS
* yet virtual memory is consistently around **43–55 GB**

For example:

**KAUST066:**

> 4.67 Gb input → 38.7 GB peak RSS, 55.4 GB peak VMem

while:

**KAUST063:**

> 0.98 Gb input → 9.3–11.3 GB peak RSS, 43–44 GB VMem

This suggests that there is a substantial fixed memory footprint plus a data-dependent component.

If I naïvely extrapolate RSS linearly, I get absurd values for the large datasets — hundreds of GB for 58 Gb and >1 TB for 308 Gb. **I would not trust that extrapolation.**

There are at least two possibilities:

1. Memory is mostly determined by the k-mer/index structures and has a relatively modest increase with input size.
2. Memory eventually starts scaling strongly with the number of distinct k-mers, in which case your new datasets could indeed need substantially more RAM.

The current data aren't sufficient to distinguish those regimes.

* * *

# 4. An important clue: number of reads

Your new data are unusual because they are not merely larger in bases; they contain **many more reads**.

For example:

| Dataset | Reads | Avg read |
| --- | --- | --- |
| Largest old (67) | 988k | 12.6 kb |
| New 1 | 10.0m | 5.9 kb |
| **New 2** | **41.2m** | **7.5 kb** |
| New 3 | 1.30m | 16.3 kb |
| New 4 | 1.96m | 16.7 kb |

This matters if your projection workflow stores/read-processes individual reads or k-mers.

The 308 Gb dataset has **~42× as many reads as your largest old dataset**, not merely 25× the bases.

That makes me particularly hesitant to say "just give it 4× the memory."

* * *

# 5. What I would actually do

I'd use a **pilot → extrapolate → production** strategy.

For each new dataset, process perhaps **5–10% of the reads** through the exact projection workflow, ideally using the same k-mer and treatment settings.

Then measure:

* peak RSS
* walltime
* CPU utilization
* number of reads processed
* number of k-mers, if available

The most useful quantity will be:

$$\text{walltime per Gb}$$

and, separately,

$$\text{peak RSS vs input Gb / reads}$$

If memory scales approximately as

$$M = M_0 + aG$$

where $G$ is Gb of input, then the pilot will tell you `M0` and `a` much more reliably than the old data.

If instead it looks like

$$M = M_0 + aG^\alpha$$

with $\alpha < 1$, you can safely avoid massive RAM allocations.

* * *

# 6. Initial memory requests I'd use

Based **only on your current traces**, I'd provision more conservatively than the old ~50 GB VMem limit.

For the three PCA variants, I would initially try:

| Dataset | Initial memory request |
| --- | --- |
| 21.2 Gb | **64 GB** |
| 32.7 Gb | **64–96 GB** |
| 58.7 Gb | **96–128 GB** |
| 308 Gb | **256 GB initially, preferably after pilot** |

I would **not immediately request 1 TB+** for the 308 Gb dataset just because of linear extrapolation.

Conversely, I would not put the 308 Gb dataset into a 64 GB job and hope for the best.

If your cluster has nodes with 128/256/512 GB RAM, the 308 Gb job is exactly the kind of case where I'd do a pilot first.

* * *

# 7. A better way to exploit your existing runs

You actually have enough information to build a useful empirical model.

I'd fit two models:

### Runtime model

$$T = \beta_0 + \beta_1(\text{total bases}) + \beta_2(\text{number of reads})$$

separately for each treatment.

This is better than bases alone because your new datasets have very different read-length distributions.

### Memory model

I'd start with

$$M = \beta_0 + \beta_1(\text{total bases}) + \beta_2(\text{number of reads})$$

but I'd also inspect whether memory is actually dominated by something like the number of distinct k-mers.

In particular, **the 308 Gb dataset should not be treated as simply "25 copies of KAUST067."**

* * *

## My recommended starting allocation

If I had to submit the jobs **right now without doing a pilot**, I'd use something like:

| New dataset | Size | Memory | Walltime |
| --- | --- | --- | --- |
| `SRX9925339` | 58.7 Gb | **128 GB** | **3 days** |
| `SRX9925340` | 308.0 Gb | **256 GB** | **14 days** |
| `SRX27934295` | 21.2 Gb | **64–96 GB** | **2 days** |
| `SRX27934296` | 32.7 Gb | **96 GB** | **3 days** |

I'd regard the **256 GB / 14 day** allocation for `SRX9925340` as a _safe first production estimate_, not as a claim that it actually needs 256 GB or 14 days.

### One more thing

Your execution traces strongly suggest that **PCA preprocessing reduces runtime substantially for many samples and often reduces RSS**, so if your scientific workflow permits it, I'd provision based primarily on the `pca_pre` / `pca_pre_ipca` behavior rather than `no_pca_pre`.

If you give me the **exact command/script for the projection workflow** (or the Nextflow/Snakemake process definition), I can make this much more rigorous: I can derive an empirical **memory + walltime scaling model from these 24 runs**, include both **Gb and read count**, and give you a table of recommended `mem` and `time` values for each of the four new datasets, including a conservative and aggressive estimate.