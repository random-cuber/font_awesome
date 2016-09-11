#!/bin/bash

location=$(dirname $0) 

base_dir=$(cd "$location/.." && pwd)

asset_dir="$base_dir/assets"

version="4.6.3"

package="download.tar.gz"

url="https://github.com/FortAwesome/Font-Awesome/archive/v${version}.tar.gz"

download() {
    cd "$base_dir"
    rm -r -f "$asset_dir"
    mkdir "$asset_dir"
    wget "$url" -O "$package"
    tar xv --strip=1 --dir="$asset_dir" --file="$package" \
        --wildcards '*/README.md' '*/css/*' '*/fonts/*' --exclude="src"
    rm -r -f "$package"
}

download
