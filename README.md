s3downloader
============

This script will download all files in buckets that are specified

Examples
--------

Downloads all files in the node0 bucket
```
ruby bin/s3downloader.rb node0
```

Requirements
------------

* One must have ruby installed
* One must have the bundler gem installed
* A configuration file with access credentials in yaml format needs to be provided, an example `config.yml_example` has been provied

Notes
-----
* This script will thus far only download based on the exact key name
 * If they key name consists of a directory, that directory needs to already exist!!!!

Get Started
-----------
```
git clone https://github.com/jtslear/s3logdownloader.git
cd s3downloader
bundle install
mv config.yml_example config.yml
vim config.yml
ruby bin/s3downloader.rb <bucket_name>
```
