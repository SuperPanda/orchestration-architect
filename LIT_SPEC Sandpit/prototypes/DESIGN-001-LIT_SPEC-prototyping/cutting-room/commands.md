## Example of splitting notes into its different sections for semantic reasons 

```
ls | sed -r 's/^([0-9]{4}-[0-9]{2}-[0-9]{2}) \[OA-(NOTE-[0-9]{3})\] ([a-Z]+) - (.+)$/[\2] [\4] [\3] [\1]/g'
```

See also [Semantic Filename Experiment](../../2025-03-13 [OA-NOTE-009] Prototype - Using Intermediate Representation for Semantic Renaming of Files/semantic-rename.sh)

## Find sections
```
ctags -R ../../../../..
cat ./tags | cut -f1,2,3,4 | sed -r 's/^([^\t]+)\t([^\t]+)\t([^\t]+)\t([^$]+)$/\2\t\1\t\4\t\3/g' | most
#cat ./tags | cut -f1,2,3,4 | grep "s$" | sed -r 's/^([^\t]+)\t([^\t]+)\t([^\t]+)\t([^$]+)$/\2\t\1\t4\t\3/g'
```


