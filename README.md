# cfseed - CloudFormation Seed

This is a utility for separately using CloudFormation's Stack for each environment.

## How to use

First, Create S3 Bucket.

```
$ environ=production make bucket
```

Next, copy your tempaltes to s3 bucket.

```
$ environ=production make sync
```

Create a CloudFormation Stack.

```
$ environ=production make stack
```

Update stack.

```
$ environ=production make up
```

Create a change-set.

```
$ environ=production make change-set
```

Execute the change-set.

```
$ environ=production make apply
```

Execute the change-set.

```
$ environ=production make apply
```

Delete your stack resources.

```
$ environ=production make down
```

Delete your stack.

```
$ environ=production make balse
```

### Do you want to create staging?

Yes, You can do it very very easy. `environ=production` replace `environ=staging`.

```
$ environ=staging make bucket
$ environ=staging make sync
$ environ=staging make stack
$ environ=staging make up
```

This `environ=staging` switches directories in environ directory. You can add new environment by creating a directory.

## Install

There are three ways as typical ways.

### Install in your project with Git submodule style.

Add cfseed as a submodule to your project.

```
$ git submodule add git@github.com:TakesxiSximada/cfseed.git .cfseed
```

Next, you will copy the template files.

```
$ sh .cfseed/install.sh
```

This method is easy to follow the main stream repository.

### Install in your project with fork style.

This method is almost same as the method of git submodule. The only difference is to fork the cfseed repository to your organization account and make it a submodule. This method can extend cfseed your own.

### Install in your project with file copy style.

If you do not want to use submodules from the beginning, you can also copy the files. cfseed has a bootstrap for that.


## Install in your project with file copy style.

```
curl -L https://raw.githubusercontent.com/TakesxiSximada/cfseed/master/bootstrap.sh | sh
```


## Let's show you help after installation

Need unmake https://github.com/TakesxiSximada/unmake

```
$ go get github.com/TakesxiSximada/unmake
```

Let's show you help after installation.

```
$ environ=staging make
```

or


```
$ environ=staging make help
```
