# Capture R package versions

## One-liner

`R` package version extractor that works like `pip freeze`.

## Install


```{bash}
```


## Usage

Create `r-package-version.txt` in home directory by going through the default `.libPaths()`.

```{bash}
r-freeze
```

### Passing arguments

 - `-d` : Pass a directory of your choice. Should contain R libraries, if the `DESCRIPTIONS` file is not found, then it skips that subdirectory.

 - `-v` : Verbose

Create `r-package-version.txt` in home directory by going through the passed directory.
```{bash}
r-freeze -d /path/to/r/library
```

## Description

Configuring the correct R environment can be quite tedious. Although packages like `packrat` can help with solving dependency issues by taking snapshots of the library version, I was unable to find an easy way to lock `R` environments without invoking the interpreter. 

