server '18.178.206.235', user: 'masaya', roles: %w[app db web]

set :ssh_options, {
  keys: %w[~/.ssh/ramen_master_key_rsa],
  forward_agent: true
}
