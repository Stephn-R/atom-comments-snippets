AtomCommentSnippetsView = require './atom-comment-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomCommentSnippets =
  atomCommentSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomCommentSnippetsView = new AtomCommentSnippetsView(state.atomCommentSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomCommentSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-comment-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomCommentSnippetsView.destroy()

  serialize: ->
    atomCommentSnippetsViewState: @atomCommentSnippetsView.serialize()

  toggle: ->
    console.log 'AtomCommentSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
