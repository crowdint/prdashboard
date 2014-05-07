object false

node :pulls do
  partial 'api/v1/pulls/show', object: @pull_requests
end

node :repositories do
  @repositories
end

node :users do
  @users
end

