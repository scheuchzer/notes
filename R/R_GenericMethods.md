# R - Generic Methods


## Common static functions

- print
- show


## Find implementations

Example: Find all implementations of print

```R
> methods(print)
  [1] print.acf*                                    print.anova                                  
  [3] print.aov*                                    print.aovlist*                               
  [5] print.ar*                                     print.Arima*      
  ...
```


Example: Find all generic methods

```R
> methods(class="default")
  [1] add1.default*            aggregate.default        AIC.default*             all.equal.default        ansari.test.default*    
  [6] anyDuplicated.default    aperm.default            ar.burg.default*         ar.yw.default*           as.array.default     
```


Example: Find invisible methods

```R
> getAnywhere(print.lm)
A single object matching ‘print.lm’ was found
It was found in the following places
  package:stats
  registered S3 method for print from namespace stats
  namespace:stats
```

Direct call method in namespace

```R
> stats:::print.lm(lmout)

Call:
lm(formula = y ~ x)

Coefficients:
(Intercept)            x  
       -3.0          3.5 
```


