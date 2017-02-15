# cfseed - CloudFormation Seed

Install tools:

```
curl -L https://raw.githubusercontent.com/TakesxiSximada/cfseed/master/bootstrap.sh | sh
```

Write your Makefile.

```
CFSEED := $(CURDIR)/.cfseed
include environ/$(environ)/config.mk
include $(CFSEED)/cfseed.mk
```

Display help:

```
$ environ=staging make
```

Need unmake https://github.com/TakesxiSximada/unmake
