class RecipesController < ApplicationController
  def show
  end

  def index
    #todo: this belongs in a model or lib or anywhere but here
    if signed_in?
      filter = Evernote::EDAM::NoteStore::NoteFilter.new
      constants = Evernote::EDAM::Type
      filter.order = constants::NoteSortOrder::UPDATED
      filter.words = "any: classifications_recipe:#{constants::CLASSIFICATION_RECIPE_SERVICE_RECIPE}" +
          "classifications_recipe:#{constants::CLASSIFICATION_RECIPE_USER_RECIPE}"
      spec = Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
      spec.includeTitle = true

      @recipes = note_store.findNotesMetadata(auth_token, filter, 0, 100, spec).notes
    end
  end
end
