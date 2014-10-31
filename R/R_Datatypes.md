# R - Datatypes


```yuml
[Vector]^-[Matrix]
[Vector]^-[List]
[List]^-[DataFrame]
[List]^-[Class]
```



## Vectors

The basis of all R datatypes! Everything is a vector.


- same type (or mode) for all elelemts
- Strings are single-element vectors of mode character

```R
x <- "abc"
length(x)
[1] 1
```
x is a vector of length 1


### Vector operations

Arithmetic functions with vectors are applied element wise


```R
> x <- c(1,2,3)
> x + c(1,2,3)
[1] 2 4 6
> x * c(2,4,8)
[1]  2  8 24

```


### Vector indexing

The actual syntax is ``vector1[vector2]``. Examples are probably more clearer.

Subset:

```R
> x <- c(10,11,12,13)
> x[c(1,4)]
[1] 10 13
> x[c(2:4)]
[1] 11 12 13
```


Exclusions:
```R
> x[-1]
[1] 11 12 13
> x[c(-1:-3)]
[1] 13
> # only the last
> x[length(x)]
[1] 13
> # all except the last
> x[-length(x)]
[1] 10 11 12

```



## Strings


### paste()

Concatenate the strings delimited by a char. The default delimiter is a space.

```R
c <- paste("a", "b", "c")
c
[1] "a b c"
```


### strspli()

Split by a delimiter

```R
strsplit("a b c", " ")
```



## Matrices

A matrix can only contain elements of one mode. Use Data Frames if you need multiple modes.


### Extract submatrixes

```R
# rows
m[1,]
# columns
m[,2]
```


### Arithmetics

```R
m %*% m            # matrix multiplication
```


### rbind() / cbind() - Row Bind / Column Bind

Adds rows or columns to a matrix. 



## Lists

- 'Vector' with elements of different type (mode).
- Elements can be named

```R
x <- list(a=1, b="hello")
x$b
[1] "hello"
```



## Data Frames

- A data frame is a list of vectors
- Therefore it can contain elements of different types
- A data frame is the equivalent of a database table
- Used for reading data from files or database


```R
d <- data.frame(list(kids=c("Joe", "Jack"), ages=c(10, 12)))
d
  kids ages
1  Joe   10
2 Jack   12
```


### Import data

```R
t <- read.table("a.txt", header=FALSE)
t
class(t)
head(t)
```



## Classes

Simple lists with a class name attribute.

See [R - Classes](R_Classes.md) for details.
