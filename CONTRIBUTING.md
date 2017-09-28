### Coding style
```
https://packagecontrol.io/packages/SublimeLinter-ruby
https://packagecontrol.io/packages/SublimeLinter-rubocop
```

### Making changes
Create branch with issue number and create merge request to master
```sh
$ git checkout master
$ git pull
$ git checkout -b issue_no master
```
`Make some changes and review the codes to eliminate unnecessary thins from the code and push it`
`Commit must be describe what is being committed with it`
```sh
$ git status
$ git add path_of_changes
$ git commit -m "issue_no explaination of changes"
$ git push origin issue_no
```

`Create pull request.`
https://github.com/batbayar-su/rails_boilerplate/compare

### You can use mailcatcher while you need to check mail service within the change. Ofcouse you can use any other similar tools you want.
```sh
$ gem install mailcatcher
$ mailcatcher
```.