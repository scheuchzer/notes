# R - Classes

S3 and S4 classes




## S3 Classes

- Basically a list with an additional `class` attribute
- List items are the member variables


### Examples: Address

Create class:

```R
> z <- list(street="Evergreen Terrace", number="742", union=T)
> class(z) <- "address"
```


Show details

```R
> z <- list(street="Evergreen Terrace", number="742")
> class(z) <- "address"
```	


Default `print()` behaviour

```R
> print(z)
$street
[1] "Evergreen Terrace"

$number
[1] "742"

attr(,"class")
[1] "address"
```


Implement `print()`

```R
print.address <- function(a) {
  cat(a$number, "," a$street, "\n")
  cat(a$number, "\n")
}
```


Check presence

```R
> methods(,"address")
[1] print.address
```


Print the object

```R
> z
Evergreen Terrace 
742 
```


### Class constructor

```R
address <- function(street, number) {
  z <- list()
  class(z) <- 'address'
  z$street <- street
  z$number <- number
  return(z)
}

print.address <- function(a) {
  cat(a$street, "\n")
  cat(a$number, "\n")
}
```


Usage

```R
> a <- address(street='Evergreen', number = 742)
> a
Evergreen 
742 
```


### Inheritance

```R
addressWithFloor <- function(street, number, floor) {
  z <- address(street, number)
  class(z) <- c("addressWithFloor", "address")
  z$floor <- floor
  return(z)
}
```


Usage

```R
> a <- addressWithFloor("Haupstrasse", 20, 1)
> a
Haupstrasse 
20
```

The `print.address` method is used. So we have to implement a new `print()` method.

```R
print.addressWithFloor <- function(a) {
  print.address(a)
  cat(a$floor, "\n")
}
```

```R
> a
Haupstrasse 
20 
1 
```


### Problems

- As S3 classes are simple lists anybody can add and remove attributes
- S3 classes are very error prone to typos
	- `a$streeeeeet <- "test"` will work



## S4 Classes

- access members with `@`e
- typo safe
- members are called slots


### Example: Address

```R
setClass("address",
         representation(
           street="character",
           number="numeric"
           )
         )
```


Usage

```R
> a <- new("address", street="Evergreen Terrace", number=742)
> a
An object of class "address"
Slot "street":
[1] "Evergreen Terrace"

Slot "number":
[1] 742

> a@number
[1] 742
> slot(a, "number")
[1] 742
```


### Implement print (Generic functions)

For S4 classes we don't have a `print()` method. Instead we have a `show()` method.

```R
setMethod("show", "address",
          function(object) {
            cat(object@number, object@street, sep=", ")
          }
)
```