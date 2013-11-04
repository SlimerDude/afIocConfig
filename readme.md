# IocConfig

*IocConfig is a support library and exists to aid the development of other Alien-Factory libraries and frameworks.
Though you are welcome to use it, you may find features are missing and the documentation incomplete.*

`IocConfig` is a [Fantom](http://fantom.org/) library for for providing injectable config values.



## Quick Start

    @Inject @Config { "afBedSheet.gzip.threshold" }
    private Int gzipThreshold



## Documentation

Full API & fandocs are available on the [status302 repository](http://repo.status302.com/doc/afIocConfig/#overview).



## Install

Download from [status302](http://repo.status302.com/browse/afIocConfig).

Or install via fanr:

    $ fanr install -r http://repo.status302.com/fanr/ afIocConfig

To use in a project, add a dependency in your `build.fan`:

    depends = ["sys 1.0", ..., "afIocConfig 0+"]
