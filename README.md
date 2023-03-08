# [ghost.computer](https://ghost.computer)

## getting it running

- `brew services start postgresql`
- `bundle`
- `npm install`
- `rails db:create`
- `rails db:migrate`
- create a new user in the REPL:
  - `rails c`
  - `User.create(username: 'apaleslimghost', password: 'hunter2')`
- `rails s`

## to do

- [x] posts
  - [x] markdown
  - [x] like
  - [x] excerpts
  - [x] social preview
  - [x] tags
  - [ ] tag tokeniser input
- [x] auth
- [x] design
- [x] deploy
- [ ] drag & drop
  - [x] bear markdown ingest
  - [x] activestorage
  - [ ] textbundle-like formats (nested folders of things, preserve paths as blobs)
- [x] rss
- [ ] webmentions
  - [x] sending
  - [x] receiving
  - [x] display
    - [x] but nice
  - [x] microformats
    - [ ] more microformats?
  - [ ] bridgy publishing
- [x] notes (without title)
- [ ] pull in youtube videos, soundcloud releases, spotify releases
- [ ] featured video/live broadcast
- [ ] pagination/lazy loading

## bugs
- [x] fix home header styles on small screens
- [x] post date time
- [x] safari ugh
- [ ] mobile layout (static position)

# remix rewrite

- [ ] rewrite templates in jsx
- [ ] rewrite stimulus controllers in react
- [ ] how to do authentication
  - [ ] recreate how bcrypt does password signature
- [ ] you basically need to recreate activestorage and activestorage-postgres lol
