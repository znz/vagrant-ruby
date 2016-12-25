#!/bin/bash
set -euxo pipefail
OLD_OPENSSL_VERSION="0.9.8zh"
export RUBY_BUILD_CACHE_PATH=/vagrant/ruby
if [ -d "$HOME/.anyenv" ]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    set +x
    eval "$(anyenv init - --no-rehash)"
    set -x
fi
mkdir -p "$RUBY_BUILD_CACHE_PATH"
versions=(
    #1.8.5-p231
    1.8.6
    1.8.6-p420
    1.8.7
    1.8.7-p375
    1.9.0-0
    1.9.0-5
    1.9.1-p0
    1.9.1-p431
    1.9.2-p0
    1.9.2-p330
    1.9.3-p0
    1.9.3-p551
    2.0.0-p0
    2.0.0-p648
)
export RUBY_CONFIGURE_OPTS="--disable-install-doc --with-openssl-dir=$HOME/opt/openssl-$OLD_OPENSSL_VERSION"
for ver in "${versions[@]}"; do
    if ! RBENV_VERSION=$ver ruby -v 2>/dev/null; then
	case "$ver" in
	    1.8.6*|1.9.0-0)
		export MAKEOPTS=-j1
		;;
	    *)
		unset MAKEOPTS
		;;
	esac
	set -x
	if [ -f "/vagrant/ruby-${ver}.patch" ]; then
	    rbenv install --patch "$ver" < "/vagrant/ruby-${ver}.patch"
	else
	    rbenv install "$ver"
	fi
	set +x
    fi
done
unset MAKEOPTS
versions=(
    2.1.0
    2.1.10
    2.2.0
    2.2.5
    2.3.0
    2.3.3
)
export RUBY_CONFIGURE_OPTS="--disable-install-doc"
for ver in "${versions[@]}"; do
    if ! RBENV_VERSION=$ver ruby -v 2>/dev/null; then
	set -x
	if [ -f "/vagrant/ruby-${ver}.patch" ]; then
	    rbenv install --patch "$ver" < "/vagrant/ruby-${ver}.patch"
	else
	    rbenv install "$ver"
	fi
	set +x
    fi
done
