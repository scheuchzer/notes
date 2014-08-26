# R - Functions

## c() - Concatenate

Concatenates vectors.

```R
> v <- c(1,2,3)
> v
[1] 1 2 3
```


```R
> a <- c(1,2)
> b <- c(3,4)
> c <- c(a,b)
> c
[1] 1 2 3 4
```


Note that even the numbers are vectors in R. They are treated as one-element vectors!

```R
> x <- 2
> x
[1] 2
> x[1]
[1] 2
```


## length() 

Returns the length of an object like vectors and lists. The vector itself doesn't have a length or size function.

```R
> a <- c(1,2)
> length(a)
[1] 2
```

``length()`` does not work on strings, use ``str_length()`` of the ``stringr`` package instead.


## rnorm()


## mean()


## hist()


### Number of columns

```R
hist(z, breaks=12)
```


## sd()

