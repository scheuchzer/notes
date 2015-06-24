# Preprocessing
Thomas Scheuchzer <thomas.scheuchzer@gmx.net>  
Monday, June 08, 2015  


## Why preprocess?


```r
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                              p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
hist(training$capitalAve,main="",xlab="ave. capital run length")
```

![](Preprocessing_files/figure-html/loadPackage-1.png) 


## Why preprocess?


```r
mean(training$capitalAve)
```

```
## [1] 5.355626
```

```r
sd(training$capitalAve)
```

```
## [1] 34.5348
```


## Standardizing


```r
trainCapAve <- training$capitalAve
trainCapAveS <- (trainCapAve  - mean(trainCapAve))/sd(trainCapAve) 
mean(trainCapAveS)
```

```
## [1] 6.578183e-18
```

```r
sd(trainCapAveS)
```

```
## [1] 1
```


## Standardizing - test set

Important! For standardization you must only use calcualted values from the
training set! `trainCapAve`

```r
testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve  - mean(trainCapAve))/sd(trainCapAve) 
mean(testCapAveS)
```

```
## [1] -0.01901227
```

```r
sd(testCapAveS)
```

```
## [1] 0.61367
```


## Standardizing - _preProcess_ function
`preProcess()` is from `caret`.

`center` and `scale` is the same as we did in `Standardizing`.

```r
preObj <- preProcess(training[,-58],method=c("center","scale"))
trainCapAveS <- predict(preObj,training[,-58])$capitalAve
mean(trainCapAveS)
```

```
## [1] 6.578183e-18
```

```r
sd(trainCapAveS)
```

```
## [1] 1
```



## Standardizing - _preProcess_ function

Apply same preprocessing to the test set.

```r
testCapAveS <- predict(preObj,testing[,-58])$capitalAve
mean(testCapAveS)
```

```
## [1] -0.01901227
```

```r
sd(testCapAveS)
```

```
## [1] 0.61367
```


## Standardizing - _preProcess_ argument


```r
set.seed(32343)
modelFit <- train(type ~.,data=training,
                  preProcess=c("center","scale"),method="glm")
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: algorithm did not converge
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```r
modelFit
```

```
## Generalized Linear Model 
## 
## 3451 samples
##   57 predictor
##    2 classes: 'nonspam', 'spam' 
## 
## Pre-processing: centered, scaled 
## Resampling: Bootstrapped (25 reps) 
## 
## Summary of sample sizes: 3451, 3451, 3451, 3451, 3451, 3451, ... 
## 
## Resampling results
## 
##   Accuracy   Kappa      Accuracy SD  Kappa SD  
##   0.9206509  0.8326426  0.009895751  0.02222464
## 
## 
```



## Standardizing - Box-Cox transforms


```r
preObj <- preProcess(training[,-58],method=c("BoxCox"))
trainCapAveS <- predict(preObj,training[,-58])$capitalAve
par(mfrow=c(1,2)); hist(trainCapAveS); qqnorm(trainCapAveS)
```

![](Preprocessing_files/figure-html/unnamed-chunk-5-1.png) 


## Standardizing - Imputing data


```r
set.seed(13343)

# Make some values NA
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1],size=1,prob=0.05)==1
training$capAve[selectNA] <- NA

# Impute and standardize
preObj <- preProcess(training[,-58],method="knnImpute")
capAve <- predict(preObj,training[,-58])$capAve

# Standardize true values
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth-mean(capAveTruth))/sd(capAveTruth)
```



## Standardizing - Imputing data


```r
quantile(capAve - capAveTruth)
```

```
##            0%           25%           50%           75%          100% 
## -5.5754504278 -0.0002517359  0.0003616927  0.0016696499  0.9495797674
```

```r
quantile((capAve - capAveTruth)[selectNA])
```

```
##          0%         25%         50%         75%        100% 
## -5.57545043 -0.01528234  0.00229953  0.01529668  0.79374120
```

```r
quantile((capAve - capAveTruth)[!selectNA])
```

```
##            0%           25%           50%           75%          100% 
## -0.0007599066 -0.0002349119  0.0003539277  0.0015708629  0.9495797674
```


## Notes and further reading

* Training and test must be processed in the same way
* Test transformations will likely be imperfect
  * Especially if the test/training sets collected at different times
* Careful when transforming factor variables!
* [preprocessing with caret](http://caret.r-forge.r-project.org/preprocess.html)

