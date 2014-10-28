# R - String Functions



## grep()

```R
> grep("Pole", c("Equator", "North Pole", "South Pole"))
[1] 2 3
```



## nchar()

The `length()` method for strings



## paste()

Concat strings. Use `sep` to use specific separator.



## sprintf()

Like C and Java printf.

```R
> sprintf("Say: %s", 'Hi')
[1] "Say: Hi"
```


## substr()

```R
> substring("Foo Bar", 3,5)
[1] "o B"
```


## strsplit()

```R
> strsplit("Foo Bar", split=" ")
[[1]]
[1] "Foo" "Bar"
```


## regexpr()

Finds the character position of the first occurence.

Use `grepexpr()` to get all occurrences.