# SuperTokens

> For any contact inquires please email mustafa@binalhag.dev

- [Heading](#Gettingstarted)
  - [Sub-heading](#sub-heading)
  - [Sub-heading](#sub-heading)
  - [Sub-heading](#sub-heading)
- [Heading](#heading-1)
  - [Sub-heading](#sub-heading-1)
  - [Sub-heading](#sub-heading-1)
- [Heading](#heading-2)
  - [Sub-heading](#sub-heading-2)
  - [Sub-heading](#sub-heading-2)

## Getting started

Install project dependencies

    $ bundle install

Migrate database

    $ rails db:migrate

Start rails server

    $ rails server

Postman environment

https://www.postman.com/lunar-satellite-120138/workspace/supertokens/collection/20741642-ec703425-55b1-4d8a-bdb7-353a0284c9d1?action=share&creator=20741642

OPTIONAL

Spin up sample front end

    $ cd client
    $ npm install
    $ npm run dev

## What is SuperTokens?

- SuperTokens is a Token Authentication method built with Ruby on the Rails framework meant for Web APIs.

Json Web Tokens was my first exposure to user authentication but with its shortcommings ive decided to make a custom authentication method

**Json Web Token**

- Cant be invalidated once sent out ❌
- Token life span cant be updated ❌
- Token allows API request(s) from any device from any location ❌
- No limit amount on logged in devices ❌

**SuperTokens**

- Can be invalidated anytime ✅
- Token life span cant be set to auto-refresh on every use; life span length can be modified at any time ✅
- Request IP is compared to the the IP of user that minted that token ✅
- A variable amount of logged in devices can be set and changed any time ✅

# Features

## Token Generation

> Example login method `app/controllers/users_controller.rb`

```ruby
   def login
        user = User.find_by!(email:params[:email]).try(:authenticate, params[:password])
        if user
            # Takes in a user instance and the request obj
            token = SuperToken.generate_token(user, request)
            render json: user, serializer: UserTokenSerializer
        else
            render json: {message: "Incorrect Password"}
        end
    end
```

How the token is generated

```ruby
    # generate hash https://github.com/rails/rails/blob/main/activerecord/lib/active_record/secure_token.rb
    hash = SecureRandom.base58(36)

    # generate token based off user
    SuperToken.create!(token:hash, user_id: user.id, client_ip: request.remote_ip, agent: request.user_agent, expiry: Time.now)

```

## Token Validation

> How to authenticate a route

`app/controllers/users_controller.rb`

```ruby
    def authorize
        @user = SuperToken.vaildate_super request
    end
```

example response from `vaildate_super` method

```ruby
{status: "bad", error:"401 not authorized", message:"EXPIRED TOKEN"}

{status: "ok", user:super_token.user.profile}

{status: "bad", error:"403 forbidden", message:"DIFFERENT DEVICE "}
```
