SVDLIBC-BLAS-TBB
================

This is a blas/tbb-vesion of SVDLIBC originally from

  http://tedlab.mit.edu/~dr/SVDLIBC/

Please modify the `LIBS` line of `Makefile` to link a
specific BLAS implementation of your preference such as
OpenBLAS, ATLAS, or MKL. Or you can update the default BLAS
library by

```bash:Debian/Ubuntu
$ sudo update-alternatives --config libblas.so
```

Warning
-------

I am not sure if parallelizing `svd_opa()` and `svd_opb()`
in `svdutil.cc` by TBB really makes sense or not. It may be
just a waste of CPU and memory resources due to the cost to
create the threads.

