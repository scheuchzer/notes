# R - Misc




## R Environment


### Configuration  Files

- ``~/.Rprofile`` gets loaded at startup
- ``~/.Rdata`` contains the loaded data of the workspace
- ``~/.Rhistory`` contains the command history

These files get loaded at startup.


To prevent the loading of any files run:

```bash
R --vanilla
```

To get more help about the startup options execute

```R
?Startup
```

in R.



## Help


### Function help


Use ``?{command}`` or ``help({command})``.

Examples:
```R
help(seq)
?seq
?"<"
?"for"
?files
```


### Examples


Functions also provide examples

```R
example(seq)
example(persp)
```


### Help search


It's possible to search the help files

```R
help.search("multivatiate normal")
??"multivariate normal"
```



# Vectorized functions


Vectorized functions get applied to each entry of the vector that gets passed to the function.

Most of the common functions are vectorized functions like
- sqrt()
- round()
- +,-,*,/


## Vector in / Vector out


Example: Addition of two vectors
```
> x <- c(1,2,3,4)
> x + x
[1]  2  4  6  8
> # or as a 'real' function call
> "+"(x,x)
[1]  2  4  6  8
```
The function gets applied to the first entries of both vectors then the second and so on.


Example: add and square
```R
> f <- function(x,c) return((x+c)^2)
> f(1:3, 1)
[1]  4  9 16
> f(1:3, 1:3)
[1]  4 16 36
```
If one of the input vectors is not of the same size (like in ``f(1:3, 1)``) it gets expanded to match the length say the values get copied.


The first call did :
- (1+1)^2 = 4
- (2+1)^2 = 9
- (3+1)^2 = 16

The second:
- (1+1)^2 = 4
- (2+2)^2 = 16
- (3+3)^2 = 36


## Vector in / Matrix out



# Missing values


## NA


An unknown value is represented by ``NA``. So, it's quite common that data sets contain NA values.

Calculations with vectors that contain NA will result in NA.

```R
> x <- c(1,2,3,4,NA,6,7,8,9)
> mean(c)
[1] NA
```


But it's possible to tell the function to remove the NA values

```R
> x <- c(1,2,3,4,NA,6,7,8,9)
> mean(c, na.rm=T)
[1] 5
```


## NULL


This is the technical representation of not existent. When working with statistical data you'll not need ``NULL`` a lot but you'll have to deal with ``NA``
