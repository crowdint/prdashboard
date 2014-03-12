collection @pull_requests
attributes :id, :title, :url, :created_at, :comments_count

node :repository do |pull_request|
  pull_request.repository.id
end

node :user do |pull_request|
  pull_request.user.id
end

