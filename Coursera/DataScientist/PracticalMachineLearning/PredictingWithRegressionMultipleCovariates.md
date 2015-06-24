# Predicting with regression, multiple covariates
Jeffrey Leek  





## Example: predicting wages

<img class=center src=wages.jpg height=350>

Image Credit [http://www.cahs-media.org/the-high-cost-of-low-wages](http://www.cahs-media.org/the-high-cost-of-low-wages)

Data from: [ISLR package](http://cran.r-project.org/web/packages/ISLR) from the book: [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)



---

## Example: Wage data


```r
library(ISLR); library(ggplot2); library(caret);
data(Wage); Wage <- subset(Wage,select=-c(logwage))
summary(Wage)
```

```
##       year           age               sex                    maritl    
##  Min.   :2003   Min.   :18.00   1. Male  :3000   1. Never Married: 648  
##  1st Qu.:2004   1st Qu.:33.75   2. Female:   0   2. Married      :2074  
##  Median :2006   Median :42.00                    3. Widowed      :  19  
##  Mean   :2006   Mean   :42.41                    4. Divorced     : 204  
##  3rd Qu.:2008   3rd Qu.:51.00                    5. Separated    :  55  
##  Max.   :2009   Max.   :80.00                                           
##                                                                         
##        race                   education                     region    
##  1. White:2480   1. < HS Grad      :268   2. Middle Atlantic   :3000  
##  2. Black: 293   2. HS Grad        :971   1. New England       :   0  
##  3. Asian: 190   3. Some College   :650   3. East North Central:   0  
##  4. Other:  37   4. College Grad   :685   4. West North Central:   0  
##                  5. Advanced Degree:426   5. South Atlantic    :   0  
##                                           6. East South Central:   0  
##                                           (Other)              :   0  
##            jobclass               health      health_ins  
##  1. Industrial :1544   1. <=Good     : 858   1. Yes:2083  
##  2. Information:1456   2. >=Very Good:2142   2. No : 917  
##                                                           
##                                                           
##                                                           
##                                                           
##                                                           
##       wage       
##  Min.   : 20.09  
##  1st Qu.: 85.38  
##  Median :104.92  
##  Mean   :111.70  
##  3rd Qu.:128.68  
##  Max.   :318.34  
## 
```



---

## Get training/test sets


```r
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]
dim(training); dim(testing)
```

```
## [1] 2102   11
```

```
## [1] 898  11
```



---

## Feature plot


```r
featurePlot(x=training[,c("age","education","jobclass")],
            y = training$wage,
            plot="pairs")
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/unnamed-chunk-1-1.png) 


---

## Plot age versus wage



```r
qplot(age,wage,data=training)
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/unnamed-chunk-2-1.png) 


---

## Plot age versus wage colour by jobclass



```r
qplot(age,wage,colour=jobclass,data=training)
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/unnamed-chunk-3-1.png) 


---

## Plot age versus wage colour by education



```r
qplot(age,wage,colour=education,data=training)
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/unnamed-chunk-4-1.png) 

---

## Fit a linear model 

$$ ED_i = b_0 + b_1 age + b_2 I(Jobclass_i="Information") + \sum_{k=1}^4 \gamma_k I(education_i= level k) $$


```r
modFit<- train(wage ~ age + jobclass + education,
               method = "lm",data=training)
finMod <- modFit$finalModel
print(modFit)
```

```
## Linear Regression 
## 
## 2102 samples
##   10 predictor
## 
## No pre-processing
## Resampling: Bootstrapped (25 reps) 
## 
## Summary of sample sizes: 2102, 2102, 2102, 2102, 2102, 2102, ... 
## 
## Resampling results
## 
##   RMSE      Rsquared   RMSE SD   Rsquared SD
##   35.63984  0.2510179  1.132171  0.02088443 
## 
## 
```

Education levels: 1 = HS Grad, 2 = Some College, 3 = College Grad, 4 = Advanced Degree

---

## Diagnostics


```r
plot(finMod,1,pch=19,cex=0.5,col="#00000010")
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/unnamed-chunk-5-1.png) 


---

## Color by variables not used in the model 


```r
qplot(finMod$fitted,finMod$residuals,colour=race,data=training)
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/unnamed-chunk-6-1.png) 

---

## Plot by index

There should no trend be visible. It should group the residuals around 0. If a trens is visible then we might miss an
important variable in the model!


```r
plot(finMod$residuals,pch=19)
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/unnamed-chunk-7-1.png) 


---

## Predicted versus truth in test set


```r
pred <- predict(modFit, testing)
qplot(wage,pred,colour=year,data=testing)
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/predictions-1.png) 

---

## If you want to use all covariates


```r
modFitAll<- train(wage ~ .,data=training,method="lm")
pred <- predict(modFitAll, testing)
qplot(wage,pred,data=testing)
```

![](PredictingWithRegressionMultipleCovariates_files/figure-html/allCov-1.png) 


---

## Notes and further reading

* Often useful in combination with other models 
* [Elements of statistical learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* [Modern applied statistics with S](http://www.amazon.com/Modern-Applied-Statistics-W-N-Venables/dp/0387954570)
* [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)
