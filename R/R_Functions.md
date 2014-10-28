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



## browseEnv() - Browse Objects in Environment

Displays the environment as HTML.

```R
browseEnv()
```

or a method only 

```R
> f <- function(a,b) a*b
> browseEnv(envir=environment(f))
```



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



## class

Returns the class name of the given object.



## cumprod() - CUmulative product

```R
> cumprod(c(1:5))
[1]   1   2   6  24 120
```



## cumsum() - Cumulative sum

```R
> cumsum(c(1:10))
[1]  1  3  6 10 15 21 28 36 45 55
```



## exists() - Object existence

Checks if an object with the given name exists. Note that the name is a string!

```R
> x <- "a"
> exists("x")
[1] TRUE
> exists("y")
[1] FALSE
```



## getwd() / setwd()



## length() 

Returns the length of an object like vectors and lists. The vector itself doesn't have a length or size function.

```R
> a <- c(1,2)
> length(a)
[1] 2
```

``length()`` does not work on strings, use `nchar()` or ``str_length()`` of the ``stringr`` package instead.



## ls() - List Ojbects

- Lists currently available local variable names.
- Use `envir=parent.frame(n=1)` to include objects of parent stackframe as well

Also see `browseEnv()``



## min()/max()

also see `pmin()`/`pmax()`.

```R
> min(c(5,4,2))
[1] 2
```



## mode() - Storage mode of an object




## order() - Sort and return indexes of

Sorts a vector and returns the the indexes of the sorted values, not the values itself.

```R
> order(c(4,2,5))
[1] 2 1 3
```



## pmin()/pmax() - Pairwise min/max

```R
> pmin(c(5,4,2), c(1,6,0))
[1] 1 4 0
```



## readline() - Read from keyboard

```R
> v <- readline("Enter your name: ")
Enter your name: foo
> v
[1] "foo"
```



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



### rm() - Remove objects from environment

```R
> x <- 1
> x
[1] 1
> rm(x)
> x
Error: object 'x' not found
```


## save() - Save R Objecs

- Saves R objects to a file
- Saves the object in a binary format
- Functions are objects, too


```R
> f <- function(a,b) a*b
> save(f, file='myfunction')
> rm(f)
> f
Error: object 'f' not found
> load('myfunction')
> f(1,2)
[1] 2
```


## scan() - Read input

- Data is read into a vecor
- By default the method splits by space, tabs and newlines


Read numbers

```R
v <- scan("data.txt")
```


Read strings

```R
v <- scan("data.txt", what="")
```


Read lines of strings

```R
v <- scan("data.txt", what="", sep="\n")
```


Read from keyboard

```R
v <- scan("")
```

also see `readline()` to read from keyboard



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



## sort() - Sort

Also see ``order()`` to the the indices of the sorted values.

```R
> sort(c(4,2,5))
[1] 2 4 5
```



## str() - Structure

Shows the structure of an object



## sum()

```R
> sum(c(1:10))
[1] 55
```

also see ``cumsum()`` for cumulative sum.



## summary()



## typeof()



## unclass()

Removes class attribute and class specific methods from an object.


