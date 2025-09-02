# SageMath `.deb` Package for Ubuntu (x86-64)

The goal of this repository is to make [SageMath](https://www.sagemath.org/)
available as a `.deb` package  for Ubuntu x86-64.

## 📦 Pre-built package download

You can download the pre-built  `.deb` from the following link:

👉 [Download SageMath `.deb`](https://github.com/TOCA-LAB/sagemath-ubuntu-deb/releases/)

## 🔧 How to build the package manually

Type de following commands in your terminal

```bash
sudo apt install automake bc binutils bzip2 ca-certificates cliquer cmake curl ecl eclib-tools fflas-ffpack flintqs g++ gengetopt gfan gfortran git glpk-utils gmp-ecm lcalc libatomic-ops-dev libboost-dev libbraiding-dev libbz2-dev libcdd-dev libcdd-tools libcliquer-dev libcurl4-openssl-dev libec-dev libecm-dev libffi-dev libflint-dev libfreetype-dev libgc-dev libgd-dev libgf2x-dev libgiac-dev libgivaro-dev libglpk-dev libgmp-dev libgsl-dev libhomfly-dev libiml-dev liblfunction-dev liblrcalc-dev liblzma-dev libm4rie-dev libmpc-dev libmpfi-dev libmpfr-dev libncurses-dev libntl-dev libopenblas-dev libpari-dev libpcre3-dev libplanarity-dev libppl-dev libprimesieve-dev libpython3-dev libqhull-dev libreadline-dev librw-dev libsingular4-dev libsqlite3-dev libssl-dev libsuitesparse-dev libsymmetrica2-dev zlib1g-dev libzmq3-dev libzn-poly-dev m4 make nauty openssl palp pari-doc pari-elldata pari-galdata pari-galpol pari-gp2c pari-seadata patch perl pkg-config planarity ppl-dev python3-setuptools python3-venv r-base-dev r-cran-lattice singular sqlite3 sympow tachyon tar tox xcas xz-utils texlive-latex-extra texlive-xetex latexmk pandoc dvipng
```


```bash
git clone git@github.com:TOCA-LAB/sagemath-ubuntu-deb.git
cd sagemath-ubuntu-deb
bash build.sh
```

The resulting `.deb` package will be available in the `dist/` directory.

