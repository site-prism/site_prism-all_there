# SitePrism All There Hacking setup

To successfully get this gem running locally and to hack on it, you need to fork the repo and have
`geckodriver` and/or `chromedriver` downloaded

```bash
$ git clone git@github.com:site-prism/site_prism-all_there.git
$ cd site_prism-all_there
$ bundle
```

Hacking commands you may need are ...

```bash
$ bundle exec rake specs # Run all rspec tests
$ bundle exec rake cops # Run all rubocop tests
$ bundle exec rake # Runs specs, then runs cops
```

- Write your code. Make sure to add unit / feature tests AND documentation (If appropriate)
- Run `bundle exec rake` and ensure it passes
- Submit a pull request

Happy Testing / Developing!

Cheers,

The SitePrism Team
