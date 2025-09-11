# SageMath `.deb` Package for (K)Ubuntu (x86-64)

This repository provides a Debian ( `.deb`) package of
[SageMath](https://www.sagemath.org/) for Ubuntu (x86-64).
The goal is to make SageMath easier to install and use, without requiring users
to build it from source manually.




## 📦 Pre-built packages 

The latest pre-build `.deb` package is available on the *Releases Page*:

👉 [Download SageMath `.deb`](https://github.com/TOCA-LAB/sagemath-ubuntu-deb/releases/)


## 🔧 How to build the package manually

First, install all required build dependencies:

```bash
sudo apt install automake bc binutils bzip2 ca-certificates cliquer cmake curl ecl eclib-tools fflas-ffpack flintqs g++ gengetopt gfan gfortran git glpk-utils gmp-ecm lcalc libatomic-ops-dev libboost-dev libbraiding-dev libbz2-dev libcdd-dev libcdd-tools libcliquer-dev libcurl4-openssl-dev libec-dev libecm-dev libffi-dev libflint-dev libfreetype-dev libgc-dev libgd-dev libgf2x-dev libgiac-dev libgivaro-dev libglpk-dev libgmp-dev libgsl-dev libhomfly-dev libiml-dev liblfunction-dev liblrcalc-dev liblzma-dev libm4rie-dev libmpc-dev libmpfi-dev libmpfr-dev libncurses-dev libntl-dev libopenblas-dev libpari-dev libpcre3-dev libplanarity-dev libppl-dev libprimesieve-dev libpython3-dev libqhull-dev libreadline-dev librw-dev libsingular4-dev libsqlite3-dev libssl-dev libsuitesparse-dev libsymmetrica2-dev zlib1g-dev libzmq3-dev libzn-poly-dev m4 make nauty openssl palp pari-doc pari-elldata pari-galdata pari-galpol pari-gp2c pari-seadata patch perl pkg-config planarity ppl-dev python3-setuptools python3-venv r-base-dev r-cran-lattice singular sqlite3 sympow tachyon tar tox xcas xz-utils texlive-latex-extra texlive-xetex latexmk pandoc dvipng
```

Then clone this repository and build it:

```bash
git clone git@github.com:TOCA-LAB/sagemath-ubuntu-deb.git
cd sagemath-ubuntu-deb
make
```

The resulting `.deb` package will be available in the `dist/` directory.

## 🚀 Installing the Package

After obtaining the `.deb` file (either by downloading it from the [Releases
page](https://github.com/TOCA-LAB/sagemath-ubuntu-deb/releases) or by building
it locally), you can install it as follows.  

First, navigate to the directory containing the `.deb` file and run:

```bash
sudo dpkg -i sagemath*.deb
```
If there are missing dependencies, you can resolve them by running:

```bash
sudo apt install -f
```

✅ Once the installation is complete, SageMath will be available under the
installation prefix (default: `/opt/sagemath`).


