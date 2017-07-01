# HDXR styleguide

Dataset versus package:
> HDX refers to dataset but ckan refers to a package. This is a creation for HDX so shall refer to dataset rather than package (this also removes confusion about ckan package versus r package)


# What will HDXR be?
HDXR will be a relatively light package for interacting between the HDX and R.
It will do the minimal possible to the information it gets.
It will keep everything it can.
It will be opinionated in how it does this. But it will be consistent with how HDX does things.

Main principles:
- Rectangular data - data will be formatted in a tidy format. 
    + As there are plenty of lists in JSON format, these will be lists in dataframes.

# What is HDXR at the moment?

hdxr at the moment allows you to search for packages (called datasets in hdxr), it returns a messy dataframe just now.

It explores the datasets to give you a list of resources in each one (resources being the data themselves)

It can also download csv data at the moment and return a nested dataframe.

# What would I like to do with hdxr

1) Connect with your API key (possible in hdx connect)
2) Update your organisations information (is it possible to use yihui's packages that already format a lot of this nicely?)
3) Use it to create a new dataset
4) Upload resources for that dataset
5) Edit the metadata of a dataset
6) Edit the metadata of a resource

# What should I do to make this easier to do?

- Read up about json
- Read up about ckan
- Read up about python
- Read up about hdx python api
- Read up about writing an api
