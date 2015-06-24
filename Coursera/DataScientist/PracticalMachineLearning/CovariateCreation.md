# Covariate creation
Jeffrey Leek  


## Two levels of covariate creation

**Level 1: From raw data to covariate**

<img class=center src=covCreation1.png height=200>

**Level 2: Transforming tidy covariates** 


```r
library(kernlab);library(caret);data(spam)
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```

```r
spam$capitalAveSq <- spam$capitalAve^2
```


---

## Level 1, Raw data -> covariates

* Depends heavily on application
* The balancing act is summarization vs. information loss
* Examples:
  * Text files: frequency of words, frequency of phrases ([Google ngrams](https://books.google.com/ngrams)), frequency of capital letters.
  * Images: Edges, corners, blobs, ridges ([computer vision feature detection](http://en.wikipedia.org/wiki/Feature_detection_(computer_vision)))
  * Webpages: Number and type of images, position of elements, colors, videos ([A/B Testing](http://en.wikipedia.org/wiki/A/B_testing))
  * People: Height, weight, hair color, sex, country of origin. 
* The more knowledge of the system you have the better the job you will do. 
* When in doubt, err on the side of more features
* Can be automated, but use caution!


---

## Level 2, Tidy covariates -> new covariates

* More necessary for some methods (regression, svms) than for others (classification trees).
* Should be done _only on the training set_
* The best approach is through exploratory analysis (plotting/tables)
* New covariates should be added to data frames



---

## Load example data



```r
library(ISLR); library(caret); data(Wage);
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]
```


---

## Common covariates to add, dummy variables

__Basic idea - convert factor variables to [indicator variables](http://bit.ly/19ZhWB6)__


```r
table(training$jobclass)
```

```
## 
##  1. Industrial 2. Information 
##           1083           1019
```

```r
dummies <- dummyVars(wage ~ jobclass,data=training)
head(predict(dummies,newdata=training))
```

```
##        jobclass.1. Industrial jobclass.2. Information
## 231655                      1                       0
## 86582                       0                       1
## 161300                      1                       0
## 376662                      0                       1
## 377954                      0                       1
## 228963                      0                       1
```



---

## Removing zero covariates


```r
nsv <- nearZeroVar(training,saveMetrics=TRUE)
nsv
```

```
##            freqRatio percentUnique zeroVar   nzv
## year        1.053254    0.33301618   FALSE FALSE
## age         1.095890    2.90199810   FALSE FALSE
## sex         0.000000    0.04757374    TRUE  TRUE
## maritl      3.195604    0.23786870   FALSE FALSE
## race        8.561576    0.19029496   FALSE FALSE
## education   1.423868    0.23786870   FALSE FALSE
## region      0.000000    0.04757374    TRUE  TRUE
## jobclass    1.062807    0.09514748   FALSE FALSE
## health      2.451560    0.09514748   FALSE FALSE
## health_ins  2.299843    0.09514748   FALSE FALSE
## logwage     1.025641   19.98097050   FALSE FALSE
## wage        1.025641   19.98097050   FALSE FALSE
```

Drop variables with near zero variables. In this examples there are only males from one region. So, `sex` and `region` can be dropped.



---

## Spline basis


```r
library(splines)
bsBasis <- bs(training$age,df=3) 
head(bsBasis)
```

```
##              1          2           3
## [1,] 0.0000000 0.00000000 0.000000000
## [2,] 0.2368501 0.02537679 0.000906314
## [3,] 0.4163380 0.32117502 0.082587862
## [4,] 0.3063341 0.42415495 0.195763821
## [5,] 0.3776308 0.09063140 0.007250512
## [6,] 0.4403553 0.25969672 0.051051492
```

- _column1_: the actual age
- _column2_: squared age
- _column3_: cubed age

This allows us to detect more curvy models.

_See also_: ns(),poly()

---

## Fitting curves with splines


```r
lm1 <- lm(wage ~ bsBasis,data=training)
plot(training$age,training$wage,pch=19,cex=0.5)
points(training$age,predict(lm1,newdata=training),col="red",pch=19,cex=0.5)
```

![](CovariateCreation_files/figure-html/unnamed-chunk-2-1.png) 


---

## Splines on the test set


```r
head(predict(bsBasis,age=testing$age))
```

```
##              1          2           3
## [1,] 0.0000000 0.00000000 0.000000000
## [2,] 0.2368501 0.02537679 0.000906314
## [3,] 0.4163380 0.32117502 0.082587862
## [4,] 0.3063341 0.42415495 0.195763821
## [5,] 0.3776308 0.09063140 0.007250512
## [6,] 0.4403553 0.25969672 0.051051492
```


---

## Notes and further reading

* Level 1 feature creation (raw data to covariates)
  * Science is key. Google "feature extraction for [data type]"
  * Err on overcreation of features
  * In some applications (images, voices) automated feature creation is possible/necessary
    * http://www.cs.nyu.edu/~yann/talks/lecun-ranzato-icml2013.pdf
* Level 2 feature creation (covariates to new covariates)
  * The function _preProcess_ in _caret_ will handle some preprocessing.
  * Create new covariates if you think they will improve fit
  * Use exploratory analysis on the training set for creating them
  * Be careful about overfitting!
* [preprocessing with caret](http://caret.r-forge.r-project.org/preprocess.html)
* If you want to fit spline models, use the _gam_ method in the _caret_ package which allows smoothing of multiple variables.
* More on feature creation/data tidying in the Obtaining Data course from the Data Science course track. 
