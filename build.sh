#!/bin/bash
set -e
set -o pipefail

# ------------------------------------------------------------------------------
#
#                               Configuration
#
# ------------------------------------------------------------------------------
RELEASE="10.7"                             # Sagemath release number
PACKAGE_NAME="sagemath_${RELEASE}_amd64.deb"

# Directories
PREFIX="/opt/sagemath"                     # Target directory for sagemath installation
ARCHIVES_DIR="archives"                    # Directory for downloaded source archives
BUILD_DIR="build"                          # Directory for building SageMath
PACKAGE_ROOT="${BUILD_DIR}/package-root"   # Temporary root for the .deb package
DEBIAN_DIR="${PACKAGE_ROOT}/DEBIAN"        # Directory for Debian control files
DIST_DIR="dist"                            # Directory for the final .deb package


# ------------------------------------------------------------------------------
#
#                                  Main 
#
# ------------------------------------------------------------------------------


if [ -d "$PREFIX" ]; then
    echo "PREFIX directory already exists"
    exit 1
fi

echo "Creating PREFIX directory"
if [ ! -w "$PREFIX" ]; then
  echo "Creating PREFIX directory requires privileged permission"
  sudo mkdir -p "$PREFIX"
  CURUSER="$(whoami)"
  sudo chown ${CURUSER}:${CURUSER} "${PREFIX}"
else
  mkdir -p "${PREFIX}"
fi

mkdir -p "$ARCHIVES_DIR" "$BUILD_DIR" "$PACKAGE_ROOT" "$DEBIAN_DIR" "$DIST_DIR"

echo "Downloading SageMath ${RELEASE}..."
wget -O "${ARCHIVES_DIR}/sage-${RELEASE}.tar.gz" \
  "https://github.com/sagemath/sage/archive/refs/tags/${RELEASE}.tar.gz"

echo "Extracting source..."
tar -xzf "${ARCHIVES_DIR}/sage-${RELEASE}.tar.gz" -C "$BUILD_DIR"

echo "Building SageMath..."
cd "$BUILD_DIR/sage-${RELEASE}" || exit 1
make configure
./configure --prefix="${PREFIX}" --disable-editable
make

echo "Preparing package root..."
mkdir -p "${PACKAGE_ROOT}${PREFIX}"

cp -r "${PREFIX}/." "${PACKAGE_ROOT}${PREFIX}/"

echo "Copying Debian control files..."
cp debian/control "${DEBIAN_DIR}/control"
cp debian/postinst "${DEBIAN_DIR}/postinst"
chmod 755 "${DEBIAN_DIR}/postinst"

echo "Building Debian package..."
fakeroot dpkg-deb --build "$PACKAGE_ROOT" "${DIST_DIR}/${PACKAGE_NAME}"

echo "Cleaning PREFIX directory"
rm -rf "${PREFIX}"

cd "$DIST_DIR"
sha256sum "${PACKAGE_NAME}" > SHA256SUMS

echo "Package built successfully: ${DIST_DIR}/${PACKAGE_NAME}"
echo -n "SHA256SUMS created: "
cat SHA256SUMS

