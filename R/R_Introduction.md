# R 



## Tips for Java Guys

### <- is the new =

The assignment operator is ``<-`` and not ``=``. ``=`` is only used for function arguments and ifs.


### %% Modulo

The modulo operator is ``%%`` and not ``%``.


### No fixed type for variable

You can assign values of different types to any variable.

```R
x <- 'hi'
x <- 42
```


### Boolean

Booleans are ``TRUE`` and ``FALSE``. You could even use the short form ``T`` and ``F``.

### Help

To get the documentation for a function prefix the command with ``?``.

```R
?hist
```


## Everything is function

```R
1+2
# is the same as
"+"(1,2)
```


## Vectors

Probably the most important data structure. 


### Index

The vector index starts at **1** and not 0. 

```R
> v <- c(1,2,3)
> v
[1] 1 2 3
> v[1]
[1] 1
> v[2]
[1] 2
> v[3]
[1] 3
```


The ``[1]`` indicates that this output line starts with the index 1 of the vector ``v``. If the output is longer than
one line you will see the start index of the next line.

```R
> v <- c(1:42)
> v
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29
[30] 30 31 32 33 34 35 36 37 38 39 40 41 42
```


### Subset

To select a subset of a vector use the notation ``from:to``.

```R
> v <- c(1:42)
> v[10:15]
[1] 10 11 12 13 14 15
```

In this example we select the elements 10 to 15 from a vector with 42 elements. The result is a new vector. The result output starts with index 1 of that new vector.

As you can see, the subset notation also works for the ``c()`` function. We simply concatenate the numbers from 1 to 42. Subset notation is also valid in a for loop declaration:

```R
for (n in 1:100) {
	...
}
```



## Return values

The output of the last line of a function is used as the return value.

```R
echo <- function(x) {
	x
}
> echo(1)
[1] 1
```


You can also use the ``return()`` function to return a value.

```R
echo <- function(x) {
	return(x)
}
> echo(1)
[1] 1
```



## Default argument values

Functions can be defined with default values for its arguments.

```R
say <- function(msg='no') {
	sprintf('computer says: %s', msg)
}
> say()
[1] "computer says: no"
> say('hi')
[1] "computer says: hi"
> 
```



## Batch Mode

```bash
R CMD BATCH z.R
```



## Image/PDF creation

You can redirect all graphical output to a file. Create this special graphical output device with

```R
pdf('output.pdf')
# or
png('output.png')
```


After this, all plots will go to that file. To finish the PDF/PNG document you need to close the graphical device.

```R
# some plot
hist(rnorm(100))
# close the document
dev.off()
```
