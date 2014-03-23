window.server.respondWith('GET', '/api/v1/organizations', [
  200,
  { 'Content-Type': 'application/json' },
  '
  {
    "organizations": [
      {
        "id": 333603,
        "name": "crowdint",
        "avatar": "https://avatars.githubusercontent.com/u/333603?"
      },
      {
        "id": 12345,
        "name": "MagmaConf",
        "avatar": "https://avatars.githubusercontent.com/u/12345?"
      }
    ]
  }
  '
])


