git = require 'gitteh-promisified'
{resolve} = require 'kew'

treeEntry = (tree, path) ->
  unless Array.isArray(path)
    path = path.split('/')
      .map((v) -> if v == '.' then '' else v)
      .filter(Boolean)

  return tree if path.length == 0

  for entry in tree.entries when entry.name == path[0]
    if path.length == 1
      if entry.type == 'blob'
        return resolve(entry)

      else if entry.type == 'tree'
        tree.repository.tree(entry.id)

    else if path.length > 1 and entry.type == 'tree'
      return tree.repository.tree(entry.id)
        .then (tree) -> treeEntry(tree, path.slice(1))

  resolve(undefined)

commitTreeEntry = (commit, path) ->
  commit.tree().then (tree) -> treeEntry(tree, path)

refTreeEntry = (ref, path) ->
  ref.repository.commit

module.exports = {treeEntry, refTreeEntry}
