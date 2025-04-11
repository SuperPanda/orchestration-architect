Example of splitting notes into its different sections
```
ls | sed -r 's/^([0-9]{4}-[0-9]{2}-[0-9]{2}) \[OA-(NOTE-[0-9]{3})\] ([a-Z]+) - (.+)$/[\2] [\4] [\3] [\1]/g'
```


