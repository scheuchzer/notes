# R - Functions



## any() / all()

```R
> x <- 1:10
> any(x > 8)
[1] TRUE
> all(x > 8)
[1] FALSE
> any(x > 10)
[1] FALSE
> all(x < 11)
[1] TRUE
```



## attributes()



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


## cumsum() - Cumulative sum

```R
> cumsum(c(1:10))
 [1]  1  3  6 10 15 21 28 36 45 55
```



## getwd() / setwd()



## length() 

Returns the length of an object like vectors and lists. The vector itself doesn't have a length or size function.

```R
> a <- c(1,2)
> length(a)
[1] 2
```

``length()`` does not work on strings, use ``str_length()`` of the ``stringr`` package instead.



## rep() - Repeat

Fills a vector with the same value

```R
> rep(1,4)
[1] 1 1 1 1
```
```R
> rep(c(1,2),2)
[1] 1 2 1 2
```
```R
> rep(c(1,2), each=2)
[1] 1 1 2 2
```



## seq() - Sequence

```R
> seq(from=1.1, to=2, length=10)
 [1] 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0
```

```R
> seq(from=0, by=10, length=3)
[1]  0 10 20
```


```R
> seq(10)
 [1]  1  2  3  4  5  6  7  8  9 10
```

```R
# gets the indexes of the elements
> x <- c(10,20,30)
> seq(x)
[1] 1 2 3
```


## sapply() - Simmplify apply



## str() - Structure

Shows the structure of an object



# sum()

```R
> sum(c(1:10))
[1] 55
```

also see ``cumsum()`` for cumulative sum.



# summary()



# typeof()





