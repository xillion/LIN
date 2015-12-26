# jLIN

## Introduction ##
jLIN is a compiler that will parse [LIN Node capability files](http://www.cs-group.de/fileadmin/media/Documents/LIN_Specification_Package_2.2A.pdf#page=164) and [LIN description files](http://www.cs-group.de/fileadmin/media/Documents/LIN_Specification_Package_2.2A.pdf#page=175) then generates the corresponding C driver to implement the LIN slave or master node.

## Supported Targets ##
- PIC24FJ64GB004 family
- Support for others should not be too difficult to add

## Usage ##
```
java -jar jLIN.jar --help

Usage: jLIN [options] [command] [command options]
  Options:
    -h, --help
       Show help this message.
       Default: false
  Commands:
    slave      Generate the slave C slave driver.
      Usage: slave [options] sources...
        Options:
        * -o, --output
             Output directory.
          -s, --slave
             name of slave node to export

    master      Generate the slave C master driver.
      Usage: master [options] sources...
        Options:
        * -o, --output
             Output directory.
```
