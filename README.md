### Introduction
Daraah zuilsiig aguulsan ireeduid rails 4 deer hiigdeh project-uudiin ehleh tseg bolgoj ashiglana.
- Login, User management with Role, List page, Pagination, Datatable, I18n, CRUD, Ajax, Deployment

### Environment
- Ruby version: 2.2.4
- Rails version: 4.2.7
- Gemset name: r4bp (RVM zereg version management hereglej baigaa tohioldold hamaatai)
- Configuration files: .ruby-version, .ruby-gemset (RVM zereg version management hereglej baigaa tohioldold hamaatai)
- Gems
 - devise (authentication)
 - omniauth (social authentication)
 - cancancan (authorization)
 - rolify (authorization)
 - mina (deployment)
 - kaminari (pagination)


### Development
- [Documentation](https://docs.google.com/a/unimedia.co.jp/spreadsheets/d/1iV1ivguW_ftDL__kTIZ0ykMbpHcEWQBY8Fj34P9NKpY/edit?usp=sharing)
- [Issue management](http://gitlab.unimedia.mn/unimedia/rails4_boilerplate/boards)
- [Contribution](http://gitlab.unimedia.mn/unimedia/rails4_boilerplate/blob/master/CONTRIBUTING.md)


### Content
Daraah zuilsiig aguulsan project ba Rails 4 project uusgeh ehleh tseg bolgoj ashiglaj bolno.
`Login, User management with Role, List page, Pagination, Datatable, I18n, CRUD, Ajax, Deployment`
1. Login - Devise hereglej login register hiisen (Hamgiin orgon hereglegddeg athentication gem)
2. Login with Social account - Omniauth ashiglaj Google Yahoo 2-g holboson
3. Deployment - Mina gem ashiglasan (Capistrano-toi haritsuulhad hamaagui hurdan ajilladag)
4. I18n - mn ja en gesen yaml file-uud ashiglaj baigaa

### 1. Login
Devise gem hereglesen bogood register login hesguud n hiigdsen

### 2. Social login
Devise-tai hamt ashiglasan baigaa. Google-g holboj beldsen oor busad site-tai holbono gevel omniauth-n gem-g ashiglaarai.

### 3. Deployment
Mina gem hereglej baigaa bogood doorh baidlaar initialize hiine. Iluu medeelel heregtei bol alban yosnii doc-s n harah heregtei.
`config/deploy.rb` deer server-n tohirgoonuud bolon environment beldeh tohirgoonuudaa hiij ogood doorhiig ajluulna.

```sh
$ mina setup 
$ mina deploy 
```
