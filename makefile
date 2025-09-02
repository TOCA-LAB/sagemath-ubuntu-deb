# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------
RELEASE      := 10.7
REVISION     := 1
PACKAGE_NAME := sagemath_$(RELEASE)-$(REVISION)_amd64.deb

PREFIX       := /opt/sagemath
ARCHIVES_DIR := archives
BUILD_DIR    := build
PACKAGE_ROOT := $(BUILD_DIR)/package-root
DEBIAN_DIR   := $(PACKAGE_ROOT)/DEBIAN
DIST_DIR     := dist

SAGE_ARCHIVE := $(ARCHIVES_DIR)/sage-$(RELEASE).tar.gz
SAGE_SRC     := $(BUILD_DIR)/sage-$(RELEASE)

# ------------------------------------------------------------------------------
# Phony targets
# ------------------------------------------------------------------------------
.PHONY: all clean distclean

all: $(DIST_DIR)/$(PACKAGE_NAME) SHA256SUMS

# ------------------------------------------------------------------------------
# Build steps
# ------------------------------------------------------------------------------

# 1. Ensure PREFIX exists and is writable
check-permission:
	@if [ ! -w "$(PREFIX)" ]; then \
		echo "Error: The PREFIX directory must exists and be writable by the current user."; \
		exit 1; \
	fi 

# 2. Download source
$(SAGE_ARCHIVE):
	mkdir -p $(ARCHIVES_DIR)
	wget -O $@ "https://github.com/sagemath/sage/archive/refs/tags/$(RELEASE).tar.gz"

# 3. Extract source
$(SAGE_SRC): $(SAGE_ARCHIVE)
	mkdir -p $(BUILD_DIR)
	tar -xzf $< -C $(BUILD_DIR)

# 4. Build SageMath
build: $(SAGE_SRC) check-permission
	cd $(SAGE_SRC) && make configure
	cd $(SAGE_SRC) && ./configure --prefix="$(PREFIX)" --disable-editable
	cd $(SAGE_SRC) && make

# 5. Prepare package root
prepare: build
	mkdir -p "$(PACKAGE_ROOT)$(PREFIX)"
	cp -r "$(PREFIX)/." "$(PACKAGE_ROOT)$(PREFIX)/"

# 6. Copy Debian control files
$(DEBIAN_DIR)/control: prepare
	mkdir -p $(DEBIAN_DIR)
	cp debian/control $(DEBIAN_DIR)/control
	cp debian/postinst $(DEBIAN_DIR)/postinst
	chmod 755 $(DEBIAN_DIR)/postinst

# 7. Build Debian package
$(DIST_DIR)/$(PACKAGE_NAME): $(DEBIAN_DIR)/control
	mkdir -p $(DIST_DIR)
	fakeroot dpkg-deb --build "$(PACKAGE_ROOT)" "$@"
	# XXX
	#rm -rf "$(PREFIX)"

# 8. SHA256SUM
SHA256SUMS: $(DIST_DIR)/$(PACKAGE_NAME)
	cd $(DIST_DIR) && sha256sum $(PACKAGE_NAME) > SHA256SUMS
	@echo "SHA256SUMS created in $(DIST_DIR)/SHA256SUMS"

# ------------------------------------------------------------------------------
# Cleanup
# ------------------------------------------------------------------------------
clean:
	rm -rf $(BUILD_DIR) $(PACKAGE_ROOT)

distclean: clean
	rm -rf $(ARCHIVES_DIR) $(DIST_DIR) $(PREFIX)

