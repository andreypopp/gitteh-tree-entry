{ok, equal} = require 'assert'
path = require 'path'
git = require 'gitteh-promisified'
{treeEntry} = require '../index'

describe 'gitteh-tree-entry', ->

  tree = git.openRepository(path.join(__dirname, '..', '.git'))
    .then (repo) ->
      repo.commit('34ee62d4b862d28a3681550275cc77675989daf7')
    .then (commit) ->
      commit.tree()

  it 'resolves .', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, '.')
      .then (entry) ->
        ok entry
        equal entry.id, 'e157dc65f02f6041c8f042b24874b044dbb63bde'
      .fin(done)
      .end()

  it 'resolves empty', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, '')
      .then (entry) ->
        ok entry
        equal entry.id, 'e157dc65f02f6041c8f042b24874b044dbb63bde'
      .fin(done)
      .end()

  it 'resolves file', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, 'package.json')
      .then (entry) ->
        equal entry.name, 'package.json'
        ok entry
      .fin(done)
      .end()

  it 'resolves file prefixed with .', (done) ->
    tree
      .then (tree) ->
        treeEntry(tree, './package.json')
      .then (entry) ->
        equal entry.name, 'package.json'
        ok entry
      .fin(done)
      .end()
