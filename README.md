# README

The Final Project from the Ruby on Rails curriculum on The Odin Project.

* Ruby v2.7.0

* Rails 6 (6.0.2 or 6.0.2.2 I'm sure either may work).

* Active Storage 6.0.3.1 (for storing attachments and blobs using AWS).

* aws-sdk-s3 (Needed for doing business with buckets).

* Devise (for user authentication).

* Omniauth-Facebook (for user authentication using your Facebook account, also don't forget to make a Privacy Policy and set it up properly for Facebook authentication to function).

* Postgres (pg >=0.18, < 2.0)

* Image Processing (1.2 for manipulating images)


```ruby
# Gemfile

# Version of rails I used
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'

# db (especially if deploying to Heroku)
gem 'pg', '>= 0.18', '< 2.0'

# Image manipulation
gem 'image_processing', '~> 1.2'

# AWS S3 (if you want that...)
gem 'aws-sdk-s3', require: false

# User authentication
gem 'devise'

# Facebook authentication
gem 'omniauth-facebook'
```

then run

```shell
$ rails active_storage:install
```
to generate a migration for Active Storage, then

```shell
$ bundle install
```

---
&nbsp;
### Active Storage Setup

If using VSCode
&nbsp;
```shell
$ EDITOR=code rails credentials:edit
```
or
&nbsp;
```shell
$ EDITOR=code --wait rails credentials:edit
```

then enter the credentials for your bucket.

&nbsp;

In your storage.yml uncomment the amazon section and edit it as needed to match your credential settings.

```yml
# config/storage.yml

amazon:
  service: S3
  access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
  region: us-east-2 # or whatever region your prefer
  bucket: yourbucketname
```

Dont forget to run in console

```shell
$ rails db:migrate
```

At this point you should be able to run the tests

```shell
$ rails test
```
&nbsp;&nbsp;

Thank you for checking out the readme! Create an issue if I got something wrong or need to add something to this.


