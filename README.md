Gitbucket
=========

Usage
-----
Backup a GitHub repository to Bitbucket
```bash
gitbucket.rb backup <repository_name> \
                    --github-username=<github_username> \
                    --github-password=<github_password> \
                    --bitbucket-username=<bitbucket_username> \
                    --bitbucket-password=<bitbucket_password>
```
If you want to backup a repository belongs to a organization:
```bash
gitbucket.rb backup <repository_name> \
                    --github-username=<github_username> \
                    --github-password=<github_password> \
                    --bitbucket-username=<bitbucket_username> \
                    --bitbucket-password=<bitbucket_password> \
                    --org=<organization_name>
```

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b my_gitbucket`)
3. Commit your changes (`git commit -am "Add selecting repository"`)
4. Push to the branch (`git push origin my_gitbucket`)
5. Create an [Issue][1] with a link to your branch
6. Enjoy a refreshing Diet Coke and wait


Submitting an Issue
-------------------
I use the [GitHub issue tracker](https://github.com/JosephKu/gitbucket/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](http://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.


Copyright
---------
Copyright (c) 2012 Joseph Ku.
See [LICENSE](https://github.com/JosephKu/gitbucket/blob/master/LICENSE) for details.

[1]: https://github.com/JosephKu/bitbucket/issues
