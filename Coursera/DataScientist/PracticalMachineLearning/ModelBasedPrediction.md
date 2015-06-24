# Model based prediction
Jeffrey Leek  





## Basic idea

1. Assume the data follow a probabilistic model
2. Use Bayes' theorem to identify optimal classifiers

__Pros:__

* Can take advantage of structure of the data
* May be computationally convenient
* Are reasonably accurate on real problems

__Cons:__

* Make additional assumptions about the data
* When the model is incorrect you may get reduced accuracy

---

## Model based approach


1. Our goal is to build parametric model for conditional distribution $P(Y = k | X = x)$

2. A typical approach is to apply [Bayes theorem](http://en.wikipedia.org/wiki/Bayes'_theorem):
$$ Pr(Y = k | X=x) = \frac{Pr(X=x|Y=k)Pr(Y=k)}{\sum_{\ell=1}^K Pr(X=x |Y = \ell) Pr(Y=\ell)}$$
$$Pr(Y = k | X=x) = \frac{f_k(x) \pi_k}{\sum_{\ell = 1}^K f_{\ell}(x) \pi_{\ell}}$$

3. Typically prior probabilities $\pi_k$ are set in advance.

4. A common choice for $f_k(x) = \frac{1}{\sigma_k \sqrt{2 \pi}}e^{-\frac{(x-\mu_k)^2}{\sigma_k^2}}$, a Gaussian distribution

5. Estimate the parameters ($\mu_k$,$\sigma_k^2$) from the data.

6. Classify to the class with the highest value of $P(Y = k | X = x)$

---

## Classifying using the model

A range of models use this approach

* Linear discriminant analysis assumes $f_k(x)$ is multivariate Gaussian with same covariances
* Quadratic discrimant analysis assumes $f_k(x)$ is multivariate Gaussian with different covariances
* [Model based prediction](http://www.stat.washington.edu/mclust/) assumes more complicated versions for the covariance matrix 
* Naive Bayes assumes independence between features for model building

http://statweb.stanford.edu/~tibs/ElemStatLearn/


---

## Why linear discriminant analysis?

$$log \frac{Pr(Y = k | X=x)}{Pr(Y = j | X=x)}$$
$$ = log \frac{f_k(x)}{f_j(x)} + log \frac{\pi_k}{\pi_j}$$
$$ = log \frac{\pi_k}{\pi_j} - \frac{1}{2}(\mu_k^T \Sigma^{-1}\mu_k - \mu_j^T \Sigma^{-1}\mu_j)$$
$$ + x^T \Sigma^{-1} (\mu_k - \mu_j)$$

http://statweb.stanford.edu/~tibs/ElemStatLearn/


---

## Decision boundaries

<img class="center" src="ldaboundary.png" height=500>

---

## Discriminant function

$$\delta_k(x) = x^T \Sigma^{-1} \mu_k - \frac{1}{2}\mu_k \Sigma^{-1}\mu_k + log(\mu_k)$$


* Decide on class based on $\hat{Y}(x) = argmax_k \delta_k(x)$
* We usually estimate parameters with maximum likelihood


---

## Naive Bayes

Suppose we have many predictors, we would want to model: $P(Y = k | X_1,\ldots,X_m)$

We could use Bayes Theorem to get:

$$P(Y = k | X_1,\ldots,X_m) = \frac{\pi_k P(X_1,\ldots,X_m| Y=k)}{\sum_{\ell = 1}^K P(X_1,\ldots,X_m | Y=k) \pi_{\ell}}$$
$$ \propto \pi_k P(X_1,\ldots,X_m| Y=k)$$

This can be written:

$$P(X_1,\ldots,X_m, Y=k) = \pi_k P(X_1 | Y = k)P(X_2,\ldots,X_m | X_1,Y=k)$$
$$ = \pi_k P(X_1 | Y = k) P(X_2 | X_1, Y=k) P(X_3,\ldots,X_m | X_1,X_2, Y=k)$$
$$ = \pi_k P(X_1 | Y = k) P(X_2 | X_1, Y=k)\ldots P(X_m|X_1\ldots,X_{m-1},Y=k)$$

We could make an assumption to write this:

$$ \approx \pi_k P(X_1 | Y = k) P(X_2 | Y = k)\ldots P(X_m |,Y=k)$$

---

## Example: Iris Data


```r
data(iris); library(ggplot2)
names(iris)
```

```
## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
## [5] "Species"
```

```r
table(iris$Species)
```

```
## 
##     setosa versicolor  virginica 
##         50         50         50
```


---

## Create training and test sets


```r
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)
```

```
## [1] 105   5
```

```
## [1] 45  5
```

---

## Build predictions


```r
library(lda)
library(klaR)
```

```
## Loading required package: MASS
```

```r
modlda = train(Species ~ .,data=training,method="lda")
modnb = train(Species ~ ., data=training,method="nb")
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,3,6,7,11,13,15,18,19,24,28,31,32,33,34,40,42,45,46,52,54,56,59,62,64,66,69,70,71,73,78,81,85,86,87,89,93,101,103
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,3,6,7,11,13,15,18,19,24,28,31,32,33,34,40,42,45,46,52,54,56,59,62,64,66,69,70,71,73,78,81,85,86,87,89,93,101,103
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 4,13,15,16,18,22,25,27,31,32,34,35,38,39,41,48,52,53,55,56,58,59,60,63,65,66,72,73,76,78,80,81,83,87,89,92,93,96
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 4,13,15,16,18,22,25,27,31,32,34,35,38,39,41,48,52,53,55,56,58,59,60,63,65,66,72,73,76,78,80,81,83,87,89,92,93,96
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,3,5,8,13,14,17,21,22,24,27,28,29,31,32,37,39,41,42,43,47,49,50,53,56,61,64,70,74,75,84,88,90,95,97,98,101,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,3,5,8,13,14,17,21,22,24,27,28,29,31,32,37,39,41,42,43,47,49,50,53,56,61,64,70,74,75,84,88,90,95,97,98,101,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 3,4,7,8,10,14,15,17,19,23,25,26,30,32,38,45,46,47,49,56,60,61,65,66,74,76,80,82,84,86,87,89,93,98,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 3,4,7,8,10,14,15,17,19,23,25,26,30,32,38,45,46,47,49,56,60,61,65,66,74,76,80,82,84,86,87,89,93,98,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,7,8,13,14,18,19,21,23,28,30,32,34,37,39,40,41,42,44,51,52,53,60,62,64,65,67,70,72,76,78,80,82,83,85,92,93,99,103,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,7,8,13,14,18,19,21,23,28,30,32,34,37,39,40,41,42,44,51,52,53,60,62,64,65,67,70,72,76,78,80,82,83,85,92,93,99,103,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,3,8,11,13,14,16,23,26,28,29,31,33,35,36,42,43,45,46,56,60,62,64,68,74,77,79,82,84,85,87,88,90,93,96,100,103
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,3,8,11,13,14,16,23,26,28,29,31,33,35,36,42,43,45,46,56,60,62,64,68,74,77,79,82,84,85,87,88,90,93,96,100,103
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,3,5,8,9,10,14,15,16,20,23,24,28,31,36,38,39,42,46,48,50,52,57,59,61,62,63,67,69,74,76,79,81,86,93,95,96,99,100
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,3,5,8,9,10,14,15,16,20,23,24,28,31,36,38,39,42,46,48,50,52,57,59,61,62,63,67,69,74,76,79,81,86,93,95,96,99,100
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,6,8,12,13,22,25,26,30,31,33,36,37,39,44,46,47,49,53,57,58,60,62,63,65,71,74,76,78,79,81,82,83,86,91,100,101,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,6,8,12,13,22,25,26,30,31,33,36,37,39,44,46,47,49,53,57,58,60,62,63,65,71,74,76,78,79,81,82,83,86,91,100,101,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,6,13,17,19,21,27,33,35,37,38,39,41,42,43,46,48,49,51,55,63,69,72,73,75,76,77,78,81,82,84,87,88,89,91,96,101
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,6,13,17,19,21,27,33,35,37,38,39,41,42,43,46,48,49,51,55,63,69,72,73,75,76,77,78,81,82,84,87,88,89,91,96,101
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 5,7,8,9,11,12,13,15,19,20,22,24,25,27,32,34,35,36,38,40,43,45,51,52,55,57,64,67,69,70,74,77,80,82,83,84,86,89,91,92,98,100,101,102
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 5,7,8,9,11,12,13,15,19,20,22,24,25,27,32,34,35,36,38,40,43,45,51,52,55,57,64,67,69,70,74,77,80,82,83,84,86,89,91,92,98,100,101,102
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,9,14,17,19,20,24,25,26,28,30,35,38,39,41,44,53,55,58,66,68,71,72,75,76,79,83,87,90,95,96,98,100,103,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,9,14,17,19,20,24,25,26,28,30,35,38,39,41,44,53,55,58,66,68,71,72,75,76,79,83,87,90,95,96,98,100,103,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 5,8,13,17,18,19,20,24,29,31,38,39,40,44,45,46,47,48,53,54,57,58,59,62,64,68,69,71,72,74,77,81,82,83,84,85,87,88,91,96,98,100,102,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 5,8,13,17,18,19,20,24,29,31,38,39,40,44,45,46,47,48,53,54,57,58,59,62,64,68,69,71,72,74,77,81,82,83,84,85,87,88,91,96,98,100,102,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 6,8,11,12,13,15,23,25,28,31,35,40,47,49,50,54,56,61,63,65,71,73,76,77,79,80,83,87,88,91,94,97,100,101,103,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 6,8,11,12,13,15,23,25,28,31,35,40,47,49,50,54,56,61,63,65,71,73,76,77,79,80,83,87,88,91,94,97,100,101,103,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,10,11,13,23,30,33,40,46,49,50,52,53,55,58,59,60,65,67,68,73,74,80,81,82,84,87,89,91,92,93,96,102,103,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,10,11,13,23,30,33,40,46,49,50,52,53,55,58,59,60,65,67,68,73,74,80,81,82,84,87,89,91,92,93,96,102,103,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,5,7,10,15,18,34,35,38,39,41,43,45,49,51,53,54,63,65,66,70,73,75,78,81,82,84,87,88,89,92,94,95,96,98
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,5,7,10,15,18,34,35,38,39,41,43,45,49,51,53,54,63,65,66,70,73,75,78,81,82,84,87,88,89,92,94,95,96,98
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 3,6,8,9,10,11,14,17,20,23,25,26,27,31,33,38,39,42,47,50,57,59,61,62,63,66,67,72,78,82,84,86,87,88,90,93,95,97,100,101,103
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 3,6,8,9,10,11,14,17,20,23,25,26,27,31,33,38,39,42,47,50,57,59,61,62,63,66,67,72,78,82,84,86,87,88,90,93,95,97,100,101,103
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 5,7,11,12,14,17,19,20,22,23,24,26,27,33,36,37,40,49,50,51,52,56,59,60,62,65,69,71,73,75,79,87,89,91,92,99,101,103
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 5,7,11,12,14,17,19,20,22,23,24,26,27,33,36,37,40,49,50,51,52,56,59,60,62,65,69,71,73,75,79,87,89,91,92,99,101,103
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,5,7,12,14,15,17,19,22,23,26,27,30,31,36,40,41,46,47,50,51,54,59,60,68,74,76,83,86,87,89,92,93,96,97,98,100,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,5,7,12,14,15,17,19,22,23,26,27,30,31,36,40,41,46,47,50,51,54,59,60,68,74,76,83,86,87,89,92,93,96,97,98,100,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,6,13,14,18,20,22,23,26,29,32,34,36,38,40,44,49,52,55,62,64,65,68,70,71,72,80,82,84,85,86,90,91,92,97,101
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,6,13,14,18,20,22,23,26,29,32,34,36,38,40,44,49,52,55,62,64,65,68,70,71,72,80,82,84,85,86,90,91,92,97,101
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 4,6,9,13,14,16,19,20,24,25,29,32,36,39,40,41,44,48,54,55,57,59,60,66,67,70,72,77,79,81,86,88,89,90,95,96,98,99,102
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 4,6,9,13,14,16,19,20,24,25,29,32,36,39,40,41,44,48,54,55,57,59,60,66,67,70,72,77,79,81,86,88,89,90,95,96,98,99,102
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,8,13,15,17,20,21,22,24,26,28,29,31,34,39,40,41,43,45,47,48,51,52,53,56,57,61,62,65,67,69,71,75,76,77,78,83,92,93,97,98,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,8,13,15,17,20,21,22,24,26,28,29,31,34,39,40,41,43,45,47,48,51,52,53,56,57,61,62,65,67,69,71,75,76,77,78,83,92,93,97,98,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 4,6,10,14,16,19,20,21,23,28,30,43,44,46,49,53,54,57,58,60,65,69,73,76,78,81,82,85,90,94,95,97,99,100,103,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 4,6,10,14,16,19,20,21,23,28,30,43,44,46,49,53,54,57,58,60,65,69,73,76,78,81,82,85,90,94,95,97,99,100,103,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 4,5,8,11,13,15,16,22,25,27,28,32,34,35,37,41,43,45,46,47,48,51,60,61,62,67,69,77,79,82,83,87,93,94,98,99,101,103,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 4,5,8,11,13,15,16,22,25,27,28,32,34,35,37,41,43,45,46,47,48,51,60,61,62,67,69,77,79,82,83,87,93,94,98,99,101,103,104
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 5,11,13,14,18,21,22,24,25,37,39,40,42,44,46,48,49,50,55,57,59,62,64,71,75,77,78,80,81,84,85,89,91,95,96,101,102
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 5,11,13,14,18,21,22,24,25,37,39,40,42,44,46,48,49,50,55,57,59,62,64,71,75,77,78,80,81,84,85,89,91,95,96,101,102
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,10,12,21,25,26,31,32,38,43,44,45,47,50,51,55,59,61,62,63,66,69,70,77,78,81,83,85,86,92,94,98,99,100,101,104,105
## --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 2,4,10,12,21,25,26,31,32,38,43,44,45,47,50,51,55,59,61,62,63,66,69,70,77,78,81,83,85,86,92,94,98,99,100,101,104,105
## --> row.names NOT used
```

```r
plda = predict(modlda,testing); pnb = predict(modnb,testing)
table(plda,pnb)
```

```
##             pnb
## plda         setosa versicolor virginica
##   setosa         15          0         0
##   versicolor      0         13         2
##   virginica       0          1        14
```


---

## Comparison of results


```r
equalPredictions = (plda==pnb)
qplot(Petal.Width,Sepal.Width,colour=equalPredictions,data=testing)
```

![](ModelBasedPrediction_files/figure-html/unnamed-chunk-1-1.png) 

---

## Notes and further reading

* [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)
* [Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* [Model based clustering](http://www.stat.washington.edu/raftery/Research/PDF/fraley2002.pdf)
* [Linear Discriminant Analysis](http://en.wikipedia.org/wiki/Linear_discriminant_analysis)
* [Quadratic Discriminant Analysis](http://en.wikipedia.org/wiki/Quadratic_classifier)
