# Contrib::Auth
Plug-n-play vendor agnostic Rails authentication engine API. (Working in progress, not ready for production environments)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'contrib-auth'
```

And then execute:
```bash
$ bundle
```

Setup the provider:

```ruby
Contrib::Auth.configure do |config|
  config.provider = Contrib::Auth::Provider::GoogleAuth.new(YOUR_API_KEY)
end
```

Mount the engine in your app:

```ruby
Rails.application.routes.draw do
  mount Contrib::Auth::Engine => "/auth"
end
```

## Usage

Once installed, the `contrib-auth` will expose authentication endpoints in your application. For instance:

```bash
curl http://localhost:3000/auth/sign_in_with_password -d '{"email":"nandosousafr@gmail.com","password":"batatinha1234"}' -H 'Content-Type: application/json'
```

If the credentials are correct, the API will respond `200` with the following response:

```json
{
    "id_token": "[ID_TOKEN]",
    "refresh_token": "[REFRESH_TOKEN]",
    "expires_in": "3600",
}
```

## Supported providers

| Provider                                           | Status              |
| ---------------------------------------------------|:-------------------:|
| [Firebase](https://firebase.google.com/docs/auth)  | Working in progress |
| Auth0                                              | Pending             |
| Devise                                             | Pending             |

## Contributing

Requirements:
 - Docker

There are some make tasks available to quickly start working on this project:

| Command                                            | Description              |
| ---------------------------------------------------|:------------------------:|
| make build                                         | Build the docker image   |
| make bash                                          | Access the bash inside the container |

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
