# Error catching

## Allow process to continue when an error occurs

Use `tryCatch()`    



Example with dplyr:   
... = summary operation or function    
error = function(e){NA} <- specify NA so NA is returned instead of stopping the operation
```
new = old %>% summarize(tryCatch(..., error = function(e){NA}))
```