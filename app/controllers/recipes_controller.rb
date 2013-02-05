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
      spec.includeTitle = false

      notes = note_store.findNotesMetadata(auth_token, filter, 0, 100, spec).notes

      @recipes = notes.collect { |note| note_store.getNote(auth_token, note.guid, true, true, false, false) }
    end
  end
end

#["access_token",
#<OAuth::AccessToken:0x007fe562b7be30
#  @token="S=s1:U=43ef0:E=143fa66a880:C=13ca2b57c84:P=185:A=clang1234:H=401840d45d28847d45c646370fb0e808",
#  @secret="",
#  @consumer=<OAuth::Consumer:0x007fe562b7d320 @key="clang1234",
#    @secret="3eb26a0aabe8e186",
#    @options={
#      :signature_method=>"HMAC-SHA1",
#      :request_token_path=>"/oauth",
#      :authorize_path=>"/OAuth.action",
#      :access_token_path=>"/oauth",
#      :proxy=>nil, :scheme=>:header,
#      :http_method=>:post,
#      :oauth_version=>"1.0",
#      :site=>"https://sandbox.evernote.com"}>,
#  @params={
#    :oauth_token=>"S=s1:U=43ef0:E=143fa66a880:C=13ca2b57c84:P=185:A=clang1234:H=401840d45d28847d45c646370fb0e808",
#    "oauth_token"=>"S=s1:U=43ef0:E=143fa66a880:C=13ca2b57c84:P=185:A=clang1234:H=401840d45d28847d45c646370fb0e808",
#    :oauth_token_secret=>"",
#    "oauth_token_secret"=>"",
#    :edam_shard=>"s1",
#    "edam_shard"=>"s1",
#    :edam_userId=>"278256",
#    "edam_userId"=>"278256",
#    :edam_expires=>"1391475468416",
#    "edam_expires"=>"1391475468416",
#    :edam_noteStoreUrl=>"https://sandbox.evernote.com/shard/s1/notestore",
#    "edam_noteStoreUrl"=>"https://sandbox.evernote.com/shard/s1/notestore",
#    :edam_webApiUrlPrefix=>"https://sandbox.evernote.com/shard/s1/",
#    "edam_webApiUrlPrefix"=>"https://sandbox.evernote.com/shard/s1/"}>
#]