# Find and Parallel Copy to Clipboard Command

```command
find $(PATH_TO_SEARCH) -iname "$MATCH_GLOB" | parallel cat {} | wl-copy
```

