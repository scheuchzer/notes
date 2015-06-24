# Forecasting
Jeffrey Leek, Assistant Professor of Biostatistics  



## Time series data

<img class=center src=GOOG.png height=450>

[https://www.google.com/finance](https://www.google.com/finance)

---

## What is different?

* Data are dependent over time
* Specific pattern types
  * Trends - long term increase or decrease
  * Seasonal patterns - patterns related to time of week, month, year, etc.
  * Cycles - patterns that rise and fall periodically
* Subsampling into training/test is more complicated
* Similar issues arise in spatial data 
  * Dependency between nearby observations
  * Location specific effects
* Typically goal is to predict one or more observations into the future. 
* All standard predictions can be used (with caution!)

---

## Beware spurious correlations!


<img class=center src=spurious.jpg height=450>

[http://www.google.com/trends/correlate](http://www.google.com/trends/correlate)

[http://www.newscientist.com/blogs/onepercent/2011/05/google-correlate-passes-our-we.html](http://www.newscientist.com/blogs/onepercent/2011/05/google-correlate-passes-our-we.html)

---

## Also common in geographic analyses

<img class=center src=heatmap.png height=450>

[http://xkcd.com/1138/](http://xkcd.com/1138/)


---

## Beware extrapolation!

<img class=center src=extrapolation.jpg height=450>

[http://www.nature.com/nature/journal/v431/n7008/full/431525a.html](http://www.nature.com/nature/journal/v431/n7008/full/431525a.html)

---

## Google data



```r
library(quantmod)
invisible(Sys.setlocale("LC_ALL", "C"))  
options("getSymbols.warning4.0"=FALSE)
from.dat <- as.Date("01/01/08", format="%m/%d/%y")
to.dat <- as.Date("12/31/13", format="%m/%d/%y")
getSymbols("GOOG", src="google", from = from.dat, to = to.dat)
```

```
## [1] "GOOG"
```

```r
head(GOOG)
```

```
##            GOOG.Open GOOG.High GOOG.Low GOOG.Close GOOG.Volume
## 2008-01-02    346.09    348.34   338.53     342.25          NA
## 2008-01-03    342.29    343.08   337.92     342.32          NA
## 2008-01-04    339.51    340.14   327.17     328.17          NA
## 2008-01-07    326.64    330.81   318.36     324.30          NA
## 2008-01-08    326.17    329.65   315.18     315.52          NA
## 2008-01-09    314.70    326.34   310.94     326.27          NA
```

---

## Summarize monthly and store as time series


```r
GOOG <- as.data.frame(GOOG)  
rownames(GOOG) <- as.Date(rownames(GOOG), format = "%Y-%m-%d", tz = "US")  #make row names date objects  
GOOG <- GOOG[, -5]  #remove last column, only has NAs  
names(GOOG) <- c("Open", "High", "Low", "Close")  

mGoog <- to.monthly(GOOG)
googOpen <- Op(mGoog)
ts1 <- ts(googOpen,frequency=12)
plot(ts1,xlab="Years+1", ylab="GOOG")
```

![](Forecasting_files/figure-html/tseries-1.png) 


---

## Example time series decomposition

* __Trend__  - Consistently increasing pattern over time 
* __Seasonal__ -  When there is a pattern over a fixed period of time that recurs.
* __Cyclic__ -  When data rises and falls over non fixed periods

[https://www.otexts.org/fpp/6/1](https://www.otexts.org/fpp/6/1)


---

## Decompose a time series into parts


```r
plot(decompose(ts1),xlab="Years+1")
```

![](Forecasting_files/figure-html/unnamed-chunk-1-1.png) 

---

## Training and test sets


```r
ts1Train <- window(ts1,start=1,end=5)
ts1Test <- window(ts1,start=5,end=(7-0.01))
```

```
## Warning in window.default(x, ...): 'end' value not changed
```

```r
ts1Train
```

```
##      Jan    Feb    Mar    Apr    May    Jun    Jul    Aug    Sep    Oct
## 1 346.09 264.07 235.52 223.65 288.87 290.96 259.53 236.02 238.15 205.86
## 2 154.15 166.98 166.50 171.72 197.32 209.16 211.89 224.15 229.61 246.25
## 3 313.16 267.03 264.34 285.16 262.99 239.97 222.42 244.25 227.26 264.74
## 4 297.94 301.94 308.58 294.09 272.58 263.76 253.12 305.30 270.10 254.67
## 5 326.14                                                               
##      Nov    Dec
## 1 178.61 143.20
## 2 268.27 293.77
## 3 307.56 281.22
## 4 289.76 299.70
## 5
```

---

## Simple moving average

$$ Y_{t}=\frac{1}{2*k+1}\sum_{j=-k}^k {y_{t+j}}$$


```r
library(forecast);
```

```
## Loading required package: zoo
## 
## Attaching package: 'zoo'
## 
## Die folgenden Objekte sind maskiert von 'package:base':
## 
##     as.Date, as.Date.numeric
## 
## Loading required package: timeDate
## This is forecast 6.1
```

```r
plot(ts1Train)
lines(ma(ts1Train,order=3),col="red")
```

![](Forecasting_files/figure-html/unnamed-chunk-2-1.png) 



---

## Exponential smoothing

__Example - simple exponential smoothing__
$$\hat{y}_{t+1} = \alpha y_t + (1-\alpha)\hat{y}_{t-1}$$

<img class=center src=expsmooth.png height=300>

[https://www.otexts.org/fpp/7/6](https://www.otexts.org/fpp/7/6)

---

## Exponential smoothing


```r
ets1 <- ets(ts1Train,model="MMM")
fcast <- forecast(ets1)
plot(fcast); lines(ts1Test,col="red")
```

![](Forecasting_files/figure-html/ets-1.png) 


---

## Get the accuracy


```r
accuracy(fcast,ts1Test)
```

```
##                      ME      RMSE      MAE      MPE      MAPE      MASE
## Training set -0.4052602  24.07031 19.40497 -0.69944  7.867479 0.3685844
## Test set     77.2247187 101.55663 79.50341 18.01131 18.796156 1.5101138
##                    ACF1 Theil's U
## Training set 0.09043751        NA
## Test set     0.77662386  3.704502
```

---

## Notes and further resources

* [Forecasting and timeseries prediction](http://en.wikipedia.org/wiki/Forecasting) is an entire field
* Rob Hyndman's [Forecasting: principles and practice](https://www.otexts.org/fpp/) is a good place to start
* Cautions
  * Be wary of spurious correlations
  * Be careful how far you predict (extrapolation)
  * Be wary of dependencies over time
* See [quantmod](http://cran.r-project.org/web/packages/quantmod/quantmod.pdf) or [quandl](http://www.quandl.com/help/packages/r) packages for finance-related problems.





