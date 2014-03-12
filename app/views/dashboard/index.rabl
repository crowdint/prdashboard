object false
cache @pull_requests

node :pull_requests do
  partial 'rabl/pull_requests', object: @pull_requests
end

node :repositories do
  @pull_requests.map(&:repository)
end

node :users do
  @pull_requests.map(&:user)
end

