window.server.respondWith('GET', "/api/v1/pulls?organization=crowdint", [
  200,
  { 'Content-Type': 'application/json' },
  '
  {
    "pulls": [
      {
        "id": 5792214,
        "title": "Make templates easier to debug by not burying errors",
        "url": "https://github.com/crowdint/slim_assets/pull/5",
        "created_at": "2013-05-18T01:47:58Z",
        "comments_count": null,
        "number": 5,
        "is_private": false,
        "repository": 3473722,
        "user": 64985
      },
      {
        "id": 349136,
        "title": "Added multi column search",
        "url": "https://github.com/crowdint/rails3-jquery-autocomplete/pull/95",
        "created_at": "2011-09-22T19:30:47Z",
        "comments_count": null,
        "number": 95,
        "is_private": false,
        "repository": 778055,
        "user": 577425
      },
      {
        "id": 13479117,
        "title": "Run notification action after a given time to avoid a race condition wit...",
        "url": "https://github.com/crowdint/spree_conekta/pull/35",
        "created_at": "2014-03-12T16:22:32Z",
        "comments_count": null,
        "number": 35,
        "is_private": false,
        "repository": 12093052,
        "user": 202677
      },
      {
        "id": 12385447,
        "title": "Adds super killer feature",
        "url": "https://github.com/dakillerfeatures/dukillerfeatures/pull/1",
        "created_at": "2014-02-10T19:12:09Z",
        "comments_count": null,
        "number": 1,
        "is_private": true,
        "repository": 1984919,
        "user": 123456
      }
    ],
    "repositories": [
      {
        "id": 778055,
        "full_name": "crowdint/rails3-jquery-autocomplete",
        "url": "https://github.com/crowdint/rails3-jquery-autocomplete",
        "description": "An easy and unobtrusive way to use jQuery autocomplete with Rails 3",
        "private": false
      },
      {
        "id": 12093052,
        "full_name": "crowdint/spree_conekta",
        "url": "https://github.com/crowdint/spree_conekta",
        "description": "",
        "private": false
      },
      {
        "id": 3473722,
        "full_name": "crowdint/slim_assets",
        "url": "https://github.com/crowdint/slim_assets",
        "description": "Use Slim with Rails helpers in the asset pipeline",
        "private": false
      },
      {
        "id": 1984919,
        "full_name": "dakillerfeatures/dukillerfeatures",
        "url": "https://github.com/dakillerfeatures/dukillerfeatures",
        "description": "Le test private repo",
        "private": true
      }
    ],
    "users": [
      {
        "id": 64985,
        "nickname": "mattvague",
        "avatar": "https://avatars.githubusercontent.com/u/64985?",
        "url": "https://github.com/mattvague"
      },
      {
        "id": 577425,
        "nickname": "slash4",
        "avatar": "https://avatars.githubusercontent.com/u/577425?",
        "url": "https://github.com/slash4"
      },
      {
        "id": 202677,
        "nickname": "supherman",
        "avatar": "https://avatars.githubusercontent.com/u/202677?",
        "url": "https://github.com/supherman"
      },
      {
        "id": 123456,
        "nickname": "efigarolam",
        "avatar": "https://avatars1.githubusercontent.com/u/2565682?",
        "url": "https://github.com/efigarolam"
      }
    ]
  }
  '
])

window.server.respondWith('GET', "/api/v1/pulls?organization=MagmaConf", [
  200,
  { 'Content-Type': 'application/json' },
  '
  {
    "pulls": [
      {
        "id": 349136,
        "title": "Le Call for papers",
        "url": "https://github.com/magmaconf/cfp/pull/1",
        "created_at": "2011-09-22T19:30:47Z",
        "comments_count": null,
        "number": 1,
        "is_private": false,
        "repository": 123,
        "user": 456
      },
      {
        "id": 13479117,
        "title": "Le Landing page",
        "url": "https://github.com/magmaconf/site/pull/3",
        "created_at": "2014-03-12T16:22:32Z",
        "comments_count": null,
        "number": 3,
        "is_private": true,
        "repository": 231,
        "user": 908
      }
    ],
    "repositories": [
      {
        "id": 123,
        "full_name": "magmaconf/cfp",
        "url": "https://github.com/magmaconf/cfp",
        "description": "Call For Papers",
        "private": false
      },
      {
        "id": 12093052,
        "full_name": "magmaconf/site",
        "url": "https://github.com/magmaconf/site",
        "description": "Site Homepage",
        "private": true
      }
    ],
    "users": [
      {
        "id": 456,
        "nickname": "efigarolam",
        "avatar": "https://avatars.githubusercontent.com/u/2565682?",
        "url": "https://github.com/efigarolam"
      },
      {
        "id": 908,
        "nickname": "ingedmundo",
        "avatar": "https://avatars.githubusercontent.com/u/1649055?",
        "url": "https://github.com/ingedmundo"
      }
    ]
  }
  '
])



