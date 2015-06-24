# Random forests
Jeffrey Leek, Assistant Professor of Biostatistics  


## Random forests

1. Bootstrap samples
2. At each split, bootstrap variables
3. Grow multiple trees and vote

__Pros__:

1. Accuracy

__Cons__:

1. Speed
2. Interpretability
3. Overfitting


---

## Random forests

<img class=center src=forests.png height=400>

[http://www.robots.ox.ac.uk/~az/lectures/ml/lect5.pdf](http://www.robots.ox.ac.uk/~az/lectures/ml/lect5.pdf)


---

## Iris data


```r
library(caret);library(randomForest)
data(iris); library(ggplot2)
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
```


---

## Random forests


```r
library(caret)
modFit <- train(Species~ .,data=training,method="rf",prox=TRUE)
modFit
```

```
## Random Forest 
## 
## 105 samples
##   4 predictor
##   3 classes: 'setosa', 'versicolor', 'virginica' 
## 
## No pre-processing
## Resampling: Bootstrapped (25 reps) 
## 
## Summary of sample sizes: 105, 105, 105, 105, 105, 105, ... 
## 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa      Accuracy SD  Kappa SD  
##   2     0.9706811  0.9551272  0.02530961   0.03890522
##   3     0.9680443  0.9510672  0.03107804   0.04772303
##   4     0.9676117  0.9503824  0.03495226   0.05359346
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 2.
```

---

## Getting a single tree


```r
getTree(modFit$finalModel,k=2)
```

```
##    left daughter right daughter split var split point status prediction
## 1              2              3         3        2.60      1          0
## 2              0              0         0        0.00     -1          1
## 3              4              5         1        7.10      1          0
## 4              6              7         3        4.95      1          0
## 5              0              0         0        0.00     -1          3
## 6              8              9         2        2.95      1          0
## 7              0              0         0        0.00     -1          3
## 8              0              0         0        0.00     -1          2
## 9             10             11         2        3.05      1          0
## 10            12             13         4        1.60      1          0
## 11             0              0         0        0.00     -1          2
## 12             0              0         0        0.00     -1          2
## 13             0              0         0        0.00     -1          3
```

---

## Class "centers"


```r
irisP <- classCenter(training[,c(3,4)], training$Species, modFit$finalModel$prox)
irisP <- as.data.frame(irisP); irisP$Species <- rownames(irisP)
p <- qplot(Petal.Width, Petal.Length, col=Species,data=training)
p + geom_point(aes(x=Petal.Width,y=Petal.Length,col=Species),size=5,shape=4,data=irisP)
```

![](RandomForest_files/figure-html/centers-1.png) 

---

## Predicting new values


```r
pred <- predict(modFit,testing); testing$predRight <- pred==testing$Species
table(pred,testing$Species)
```

```
##             
## pred         setosa versicolor virginica
##   setosa         15          0         0
##   versicolor      0         13         2
##   virginica       0          2        13
```

---

## Predicting new values


```r
qplot(Petal.Width,Petal.Length,colour=predRight,data=testing,main="newdata Predictions")
```

![](RandomForest_files/figure-html/unnamed-chunk-2-1.png) 

---

## Notes and further resources

__Notes__:

* Random forests are usually one of the two top
performing algorithms along with boosting in prediction contests.
* Random forests are difficult to interpret but often very accurate. 
* Care should be taken to avoid overfitting (see [rfcv](http://cran.r-project.org/web/packages/randomForest/randomForest.pdf) funtion)


__Further resources__:

* [Random forests](http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm)
* [Random forest Wikipedia](http://en.wikipedia.org/wiki/Random_forest)
* [Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
