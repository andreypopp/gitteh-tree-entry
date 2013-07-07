{ok, equal} = require 'assert'
path = require 'path'
git = require 'gitteh-promisified'
{treeEntry} = require '../index'

describe 'gitteh-tree-entry', ->

  tree = git.openRepository(path.join(__dirname, '..', '.git'))
    .then (repo) ->
      repo.commit('6bba6341673fcf5c4cf7fee3fa29b6ce2394d521')
    .then (commit) ->
      commit.tree()

  it 'resolves .', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, '.')
      .then (entry) ->
        ok entry
        equal entry.id, 'ae13b6e67599a4786f3f1d841b4b5aab5630fbbd'
      .fin(done)
      .end()

  it 'resolves /', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, '/')
      .then (entry) ->
        ok entry
        equal entry.id, 'ae13b6e67599a4786f3f1d841b4b5aab5630fbbd'
      .fin(done)
      .end()

  it 'resolves empty', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, '')
      .then (entry) ->
        ok entry
        equal entry.id, 'ae13b6e67599a4786f3f1d841b4b5aab5630fbbd'
      .fin(done)
      .end()

  it 'resolves file', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, 'package.json')
      .then (entry) ->
        ok entry
        equal entry.name, 'package.json'
      .fin(done)
      .end()

  it 'resolves file prefixed with .', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, './package.json')
      .then (entry) ->
        ok entry
        equal entry.name, 'package.json'
      .fin(done)
      .end()

  it 'resolves file prefixed with /', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, '/package.json')
      .then (entry) ->
        ok entry
        equal entry.name, 'package.json'
      .fin(done)
      .end()

  it 'resolves dir', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, 'specs')
      .then (entry) ->
        ok entry
        equal entry.name, 'specs'
      .fin(done)
      .end()

  it 'resolves dir prefixed with .', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, './specs')
      .then (entry) ->
        ok entry
        equal entry.name, 'specs'
      .fin(done)
      .end()

  it 'resolves dir prefixed with /', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, '/specs')
      .then (entry) ->
        ok entry
        equal entry.name, 'specs'
      .fin(done)
      .end()
