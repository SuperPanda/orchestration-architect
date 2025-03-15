#!/bin/sh
cat README.md | tail -n+$((`cat README.md | grep -nP '^\`{3}d2,example' | cut -f1 -d\: | tail -n1` + 1)) | head -n-1
