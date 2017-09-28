### Introduction
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

### Content
`Login, User management with Role, List page, Pagination, Datatable, I18n, CRUD, Ajax, Deployment`
1. Login - Devise hereglej login register hiisen (Hamgiin orgon hereglegddeg athentication gem)
2. Login with Social account - Omniauth ashiglaj Google Yahoo 2-g holboson
3. Deployment - Mina gem ashiglasan (Capistrano-toi haritsuulhad hamaagui hurdan ajilladag)
4. I18n - mn ja en gesen yaml file-uud ashiglaj baigaa


### 3. Deployment
Using mina as deployment tool but can be replaced with Capistrano. If you need more information read further by yourself.
`config/deploy.rb` this file used by mina to answer following question. What would be deployed to where with what?

```sh
$ mina setup 
$ mina deploy 
```
