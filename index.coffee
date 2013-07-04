git = require 'gitteh-promisified'
{resolve} = require 'kew'

treeEntry = (tree, path) ->
  path = path.split('/').filter(Boolean) unless Array.isArray(path)

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

refTreeEntry = (ref, path) ->
  ref.tree().then (tree) -> treeEntry(tree, path)

module.exports = {treeEntry, refTreeEntry}
