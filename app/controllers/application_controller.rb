class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # todo: these don't go here but it'll do for now
  def note_store
    @note_store ||= client.note_store
  end

  def notebooks
    @notebooks ||= note_store.listNotebooks(auth_token)
  end

  def total_note_count
    filter = Evernote::EDAM::NoteStore::NoteFilter.new
    counts = note_store.findNoteCounts(auth_token, filter, false)
    notebooks.inject(0) do |total_count, notebook|
      total_count + (counts.notebookCounts[notebook.guid] || 0)
    end
  end
end
