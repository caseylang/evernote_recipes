class RecipesController < ApplicationController
  def show
  end

  def index
    #todo: this belongs in a model or lib or anywhere but here
    if signed_in?
      filter = Evernote::EDAM::NoteStore::NoteFilter.new
      constants = Evernote::EDAM::Type
      filter.order = constants::NoteSortOrder::UPDATED
      filter.words = "any: classifications_recipe:#{constants::CLASSIFICATION_RECIPE_SERVICE_RECIPE} " +
          "classifications_recipe:#{constants::CLASSIFICATION_RECIPE_USER_RECIPE}"
      spec = Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
      spec.includeTitle = true

      notes = note_store.findNotesMetadata(auth_token, filter, 0, 100, spec).notes

      @recipes = []
      notes.each do |note|
        @recipes << note_store.getNote(auth_token, note.guid, true, true, false, false)
      end
    end
  end
end
