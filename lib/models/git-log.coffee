git = require '../git'
LogListView = require '../views/log-list-view'
LogViewURI = 'atom://git-plus:log'

amountOfCommitsToShow = ->
  atom.config.get('git-plus.amountOfCommitsToShow')

module.exports = (repo, {onlyCurrentFile}={}) ->
  atom.workspace.addOpener (uri) ->
    return new LogListView if uri is LogViewURI

  atom.workspace.open(LogViewURI).then (view) ->
    if onlyCurrentFile
      currentFile = repo.relativize(atom.workspace.getActiveTextEditor()?.getPath())
      view.currentFileLog(repo, currentFile)
    else
      view.branchLog repo
