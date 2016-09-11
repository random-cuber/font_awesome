#!/bin/bash

location=$(dirname $0) 

base_dir=$(cd "$location/.." && pwd)

commit() {
    cd "$base_dir"
    git pull
    echo "// commit $(pwd)"
    git add --all  :/
    git status 
    message=$(git status --short)
    git commit --message "$message"
}

commit
