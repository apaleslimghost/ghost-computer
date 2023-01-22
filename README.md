# [ghost.computer](https://ghost.computer)

## getting it running

- `brew services start postgresql`
- `bundle`
- `npm install`
- `rails db:create`
- `rails db:migrate`
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
