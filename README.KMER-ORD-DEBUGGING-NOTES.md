# Feedback for Frederik

# 20260721

See here: `/ibex/scratch/projects/c2303/20260715_NF-KMER-ORD/OUTPUTS/20260721_180712/pipeline_info/execution_trace_2026-07-21_18-07-16.txt`

This pipeline failed:

`3	d5/6c790b	49231218	NFCORE_PIPELINE:PIPELINE:KMER_ORD_PROJECT (KAUST061_raw_k=6)	FAILED	1	2026-07-21 18:16:29.755	4h 44m 30s	4h 44m 24s	-	-	-	-	-`

but this was because of a memory error (see `/ibex/project/c2303/20260715_NF-KMER-ORD/work/d5/6c790b099868a61f1ed5117eb8e2cd/.command.err`)

```
Can't expand MemType 0: jcol 234469
╭───────────────────── Traceback (most recent call last) ──────────────────────╮
│ /opt/conda/lib/python3.11/site-packages/kmer_ord/cli/main.py:197 in          │
│ run_pipeline                                                                 │
│                                                                              │
│   194 │   │   SpatialiteDatabase()]                                          │
│   195 │                                                                      │
│   196 │   runner = Runner(operations)                                        │
│ ❱ 197 │   runner.run(context)                                                │
│   198 │                                                                      │
│   199 │   _print_artifacts(context)                                          │
│   200 │   _print_footer(start_time)                                          │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/kmer_ord/workflow/runner.py:12 in    │
│ run                                                                          │
│                                                                              │
│    9 │   │   │   │   context.get(requirement)                                │
│   10 │   │   │                                                               │
│   11 │   │   │   context.logger.info(f"Running operation: {op.name}")        │
│ ❱ 12 │   │   │   op.run(context)                                             │
│   13                                                                         │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/kmer_ord/workflow/operations.py:242  │
│ in run                                                                       │
│                                                                              │
│   239 │   │   │   │   continue                                               │
│   240 │   │   │                                                              │
│   241 │   │   │   # Run DR with proper sequence IDs                          │
│ ❱ 242 │   │   │   merged_file, graph_paths = run_dr_methods(                 │
│   243 │   │   │   │   X=X,                                                   │
│   244 │   │   │   │   methods=self.methods,                                  │
│   245 │   │   │   │   dims=self.dims,                                        │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/kmer_ord/dr/methods.py:250 in        │
│ run_dr_methods                                                               │
│                                                                              │
│   247 │   │   │   info(f"{'':>{m}}  {params_str}")                           │
│   248 │   │   t0 = time.perf_counter()                                       │
│   249 │   │                                                                  │
│ ❱ 250 │   │   embedding, graph = _run_single_method(                         │
│   251 │   │   │   X=X,                                                       │
│   252 │   │   │   method=method,                                             │
│   253 │   │   │   dims=dims,                                                 │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/kmer_ord/dr/methods.py:135 in        │
│ _run_single_method                                                           │
│                                                                              │
│   132 │   │   │   n_components=dims,                                         │
│   133 │   │   │   n_jobs=n_jobs,                                             │
│   134 │   │   )                                                              │
│ ❱ 135 │   │   embedding = model.fit_transform(X)                             │
│   136 │                                                                      │
│   137 │   elif method == "sparse_pca":                                       │
│   138 │   │   from sklearn.decomposition import SparsePCA                    │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/sklearn/utils/_set_output.py:319 in  │
│ wrapped                                                                      │
│                                                                              │
│   316 │                                                                      │
│   317 │   @wraps(f)                                                          │
│   318 │   def wrapped(self, X, *args, **kwargs):                             │
│ ❱ 319 │   │   data_to_wrap = f(self, X, *args, **kwargs)                     │
│   320 │   │   if isinstance(data_to_wrap, tuple):                            │
│   321 │   │   │   # only wrap the first output for cross decomposition       │
│   322 │   │   │   return_tuple = (                                           │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/sklearn/base.py:1403 in wrapper      │
│                                                                              │
│   1400 │   │   │   │   ),                                                    │
│   1401 │   │   │   │   callback_management_context(estimator),               │
│   1402 │   │   │   ):                                                        │
│ ❱ 1403 │   │   │   │   return fit_method(estimator, *args, **kwargs)         │
│   1404 │   │                                                                 │
│   1405 │   │   return wrapper                                                │
│   1406                                                                       │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/sklearn/manifold/_locally_linear.py: │
│ 853 in fit_transform                                                         │
│                                                                              │
│   850 │   │   X_new : array-like, shape (n_samples, n_components)            │
│   851 │   │   │   Returns the instance itself.                               │
│   852 │   │   """                                                            │
│ ❱ 853 │   │   self._fit_transform(X)                                         │
│   854 │   │   return self.embedding_                                         │
│   855 │                                                                      │
│   856 │   def transform(self, X):                                            │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/sklearn/manifold/_locally_linear.py: │
│ 800 in _fit_transform                                                        │
│                                                                              │
│   797 │   │   random_state = check_random_state(self.random_state)           │
│   798 │   │   X = validate_data(self, X, dtype=float)                        │
│   799 │   │   self.nbrs_.fit(X)                                              │
│ ❱ 800 │   │   self.embedding_, self.reconstruction_error_ =                  │
│       _locally_linear_embedding(                                             │
│   801 │   │   │   X=self.nbrs_,                                              │
│   802 │   │   │   n_neighbors=self.n_neighbors,                              │
│   803 │   │   │   n_components=self.n_components,                            │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/sklearn/manifold/_locally_linear.py: │
│ 443 in _locally_linear_embedding                                             │
│                                                                              │
│   440 │   if M_sparse:                                                       │
│   441 │   │   M = _align_api_if_sparse(M.tocsr())                            │
│   442 │                                                                      │
│ ❱ 443 │   return null_space(                                                 │
│   444 │   │   M,                                                             │
│   445 │   │   n_components,                                                  │
│   446 │   │   k_skip=1,                                                      │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/sklearn/manifold/_locally_linear.py: │
│ 177 in null_space                                                            │
│                                                                              │
│   174 │   if eigen_solver == "arpack":                                       │
│   175 │   │   v0 = _init_arpack_v0(M.shape[0], random_state)                 │
│   176 │   │   try:                                                           │
│ ❱ 177 │   │   │   eigen_values, eigen_vectors = eigsh(                       │
│   178 │   │   │   │   M, k + k_skip, sigma=0.0, tol=tol, maxiter=max_iter,   │
│       v0=v0                                                                  │
│   179 │   │   │   )                                                          │
│   180 │   │   except RuntimeError as e:                                      │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/scipy/sparse/linalg/_eigen/arpack/ar │
│ pack.py:1734 in eigsh                                                        │
│                                                                              │
│   1731 │   │   │   mode = 3                                                  │
│   1732 │   │   │   matvec = None                                             │
│   1733 │   │   │   if OPinv is None:                                         │
│ ❱ 1734 │   │   │   │   Minv_matvec = get_OPinv_matvec(A, M, sigma,           │
│   1735 │   │   │   │   │   │   │   │   │   │   │      hermitian=True,        │
│        tol=tol)                                                              │
│   1736 │   │   │   else:                                                     │
│   1737 │   │   │   │   OPinv = aslinearoperator(OPinv)                       │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/scipy/sparse/linalg/_eigen/arpack/ar │
│ pack.py:1138 in get_OPinv_matvec                                             │
│                                                                              │
│   1135                                                                       │
│   1136 def get_OPinv_matvec(A, M, sigma, hermitian=False, tol=0):            │
│   1137 │   if sigma == 0:                                                    │
│ ❱ 1138 │   │   return get_inv_matvec(A, hermitian=hermitian, tol=tol)        │
│   1139 │                                                                     │
│   1140 │   if M is None:                                                     │
│   1141 │   │   #M is the identity matrix                                     │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/scipy/sparse/linalg/_eigen/arpack/ar │
│ pack.py:1131 in get_inv_matvec                                               │
│                                                                              │
│   1128 │   │   return LuInv(M).matvec                                        │
│   1129 │   elif issparse(M) or is_pydata_spmatrix(M):                        │
│   1130 │   │   M = _fast_spmatrix_to_csc(M, hermitian=hermitian)             │
│ ❱ 1131 │   │   return SpLuInv(M).matvec                                      │
│   1132 │   else:                                                             │
│   1133 │   │   return IterInv(M, tol=tol).matvec                             │
│   1134                                                                       │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/scipy/sparse/linalg/_eigen/arpack/ar │
│ pack.py:988 in __init__                                                      │
│                                                                              │
│    985 │   """                                                               │
│    986 │                                                                     │
│    987 │   def __init__(self, M):                                            │
│ ❱  988 │   │   self.M_lu = splu(M)                                           │
│    989 │   │   self.shape = M.shape                                          │
│    990 │   │   self.dtype = M.dtype                                          │
│    991 │   │   self.isreal = not np.issubdtype(self.dtype,                   │
│        np.complexfloating)                                                   │
│                                                                              │
│ /opt/conda/lib/python3.11/site-packages/scipy/sparse/linalg/_dsolve/linsolve │
│ .py:433 in splu                                                              │
│                                                                              │
│   430 │   if (_options["ColPerm"] == "NATURAL"):                             │
│   431 │   │   _options["SymmetricMode"] = True                               │
│   432 │                                                                      │
│ ❱ 433 │   return _superlu.gstrf(N, A.nnz, A.data, indices, indptr,           │
│   434 │   │   │   │   │   │     csc_construct_func=csc_construct_func,       │
│   435 │   │   │   │   │   │     ilu=False, options=_options)                 │
│   436                                                                        │
╰──────────────────────────────────────────────────────────────────────────────╯
MemoryError
```

However the program exited with exit code `1`, which ruins prevents Nextflow from doing a dynamic retry.

From ChatGPT:


There is **no universally standard exit code for "out of memory"** across Unix/Linux applications.

Here are the common cases:

| Situation | Exit code |
| --- | --- |
| Program catches `MemoryError` and exits | Whatever the program chooses (often `1`) |
| Python unhandled `MemoryError` | Usually `1` |
| Process killed by the Linux OOM killer | `137` (128 + SIGKILL 9) |
| Process receives SIGKILL | `137` |
| Process receives SIGSEGV | `139` |

In your case, this was **not** the Linux OOM killer. The traceback ends with:

```Python
MemoryError
```

inside Python, and Nextflow reports:

```
Command exit status: 1
```

So Python raised a `MemoryError`, your program did not catch it, and Python exited with its default exit code of **1**.

### Best practice

If you're writing a CLI tool, it's perfectly reasonable to catch `MemoryError` and return a dedicated exit code, for example:

* **1** — generic error (most common)
* **10** or **70** — out of memory (documented by your tool)

The important thing is that it is **documented and used consistently**. There is no POSIX-defined "memory error" exit code.

For a bioinformatics CLI like `kmer-ord`, I'd recommend:

```
0   Success
1   Unexpected/internal error
2   Invalid arguments
3   Input/output error
10  Out of memory
11  Algorithm failed to converge
```

This makes it much easier for workflows like Nextflow or Snakemake to distinguish resource failures from bugs.

**The program should be modified to catch the MemoryError and propograte it to the another error code that can easily be caught by the Nextflow executor, especially since memory is a problem with this program**