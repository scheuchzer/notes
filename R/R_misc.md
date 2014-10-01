# R - Misc




## R Environment


Internal R Files:

- ``~/.Rprofile`` gets loaded at startup
- ``~/.Rdata`` contains the loaded data of the workspace
- ``~/.Rhistory`` contains the command history

These files get loaded at startup.


To prevent the loading of any files run:

```bash
R --vanilla
```

To get more help about the startup options execute

```R
?Startup
```

in R.



## Help


Use ``?{command}`` or ``help({command})``.

Examples:
```R
help(seq)
?seq
?"<"
?"for"
?files
```


Functions also provide examples

```R
example(seq)
example(persp)
```


It's possible to search the help files

```R
help.search("multivatiate normal")
??"multivariate normal"
```






