# Plotting Predictors
Thomas Scheuchzer <thomas.scheuchzer@gmx.net>  
Monday, June 08, 2015  

## Example: Wage data


```r
library(ISLR); library(ggplot2); library(caret); library(gridExtra);
data(Wage)
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
##            jobclass               health      health_ins      logwage     
##  1. Industrial :1544   1. <=Good     : 858   1. Yes:2083   Min.   :3.000  
##  2. Information:1456   2. >=Very Good:2142   2. No : 917   1st Qu.:4.447  
##                                                            Median :4.653  
##                                                            Mean   :4.654  
##                                                            3rd Qu.:4.857  
##                                                            Max.   :5.763  
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

## Get training/test sets


```r
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training); dim(testing)
```

```
## [1] 2102   12
```

```
## [1] 898  12
```


## Feature plot (*caret* package)


```r
featurePlot(x=training[,c("age","education","jobclass")],
            y = training$wage,
            plot="pairs")
```

![](PlottingPredictors_files/figure-html/unnamed-chunk-1-1.png) 


## Qplot (*ggplot2* package)



```r
qplot(age,wage,data=training)
```

![](PlottingPredictors_files/figure-html/unnamed-chunk-2-1.png) 

## Qplot with color (*ggplot2* package)



```r
qplot(age,wage,colour=jobclass,data=training)
```

![](PlottingPredictors_files/figure-html/unnamed-chunk-3-1.png) 


## Add regression smoothers (*ggplot2* package)



```r
qq <- qplot(age,wage,colour=education,data=training)
qq +  geom_smooth(method='lm',formula=y~x)
```

![](PlottingPredictors_files/figure-html/unnamed-chunk-4-1.png) 


## cut2, making factors (*Hmisc* package)



```r
library(Hmisc)
cutWage <- cut2(training$wage,g=3)
table(cutWage)
```

```
## cutWage
## [ 20.9, 92.7) [ 92.7,118.9) [118.9,314.3] 
##           701           731           670
```

## Boxplots with cut2



```r
p1 <- qplot(cutWage,age, data=training,fill=cutWage,
      geom=c("boxplot"))
p1
```

![](PlottingPredictors_files/figure-html/unnamed-chunk-5-1.png) 

## Boxplots with points overlayed



```r
p2 <- qplot(cutWage,age, data=training,fill=cutWage,
      geom=c("boxplot","jitter"))
grid.arrange(p1,p2,ncol=2)
```

![](PlottingPredictors_files/figure-html/unnamed-chunk-6-1.png) 

## Tables


```r
t1 <- table(cutWage,training$jobclass)
t1
```

```
##                
## cutWage         1. Industrial 2. Information
##   [ 20.9, 92.7)           437            264
##   [ 92.7,118.9)           368            363
##   [118.9,314.3]           261            409
```

```r
prop.table(t1,1)
```

```
##                
## cutWage         1. Industrial 2. Information
##   [ 20.9, 92.7)     0.6233951      0.3766049
##   [ 92.7,118.9)     0.5034200      0.4965800
##   [118.9,314.3]     0.3895522      0.6104478
```


## Density plots


```r
qplot(wage,colour=education,data=training,geom="density")
```

![](PlottingPredictors_files/figure-html/unnamed-chunk-8-1.png) 


## Notes and further reading

* Make your plots only in the training set 
  * Don't use the test set for exploration!
* Things you should be looking for
  * Imbalance in outcomes/predictors
  * Outliers 
  * Groups of points not explained by a predictor
  * Skewed variables 
* [ggplot2 tutorial](http://rstudio-pubs-static.s3.amazonaws.com/2176_75884214fc524dc0bc2a140573da38bb.html)
* [caret visualizations](http://caret.r-forge.r-project.org/visualizations.html)
