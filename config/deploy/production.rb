server '18.178.206.235', user: 'masaya', roles: %w[app db web]

set :ssh_options, {
  keys: %w[~/.ssh/id_rsa_64a5d5dc33b4d617dd1ca8a705a7be77],
  forward_agent: true
}
