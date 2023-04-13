#! /bin/bash
sed -i "" -e "s/function \(.*\)\((.*)\)/const \1 = function\2/g" $@
