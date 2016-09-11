#!/bin/bash

location=$(dirname $0) 

base_dir=$(cd "$location/.." && pwd)

asset_dir="$base_dir/assets"

version="4.6.3"

package="download.tar.gz"

url="https://github.com/FortAwesome/Font-Awesome/archive/v${version}.tar.gz"

composer="$base_dir/composer.json"

###

version_get() {
    cat "$composer" | grep '"version":' | sed -r -e 's/^.*([0-9]+[.][0-9]+[.][0-9]+).*$/\1/'
}

version_put() {
    local version="$1"
    sed -i -r -e 's/(^.*"version":.*)([0-9]+[.][0-9]+[.][0-9]+)(.*$)/\1'${version}'\3/' "$composer"
}

version_split() {
    local version="$1"
    local array=(${version//'.'/' '})
    version_major=${array[0]}    
    version_minor=${array[1]}    
    version_micro=${array[2]}    
}

version_build() {
    echo "${version_major}.${version_minor}.${version_micro}"
}

version_increment() {
    version_micro=$(( $version_micro +1 ))
}

version_update() {
    version=$(version_get)
    version_split "$version"
    version_increment
    version=$(version_build)
    version_put "$version"
}

project_release() {
    cd "$base_dir"
    echo "// commit $(pwd)"
    git add --all  :/
    git status 
    message=$(git status --short)
    git commit --message "$message"
    tag="$version"
    git tag -f -a "$tag" -m "release version $version"
    git push 
    git push --tags --force
}

download() {
    cd "$base_dir"
    rm -r -f "$asset_dir"
    mkdir "$asset_dir"
    wget "$url" -O "$package"
    tar xv --strip=1 --dir="$asset_dir" --file="$package" \
        --wildcards '*/README.md' '*/css/*' '*/fonts/*' --exclude="src"
    rm -r -f "$package"
}

###

download

version_put "$version"

project_release
