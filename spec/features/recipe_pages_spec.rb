require 'spec_helper'

describe 'Recipe Pages' do
  subject { page }

  describe "Index page" do
    before { visit root_path }

    it { should have_selector('#logo', text: 'Evernote Recipe') }
    it { should have_selector('#sign_in_header', text: 'Sign In') }
    it { should have_selector('a.btn', text: 'Sign In') }

    describe "when signed in" do
      no_notes = { cassette_name: 'recipe_pages/index/signed_in/no_notes' }

      it "should show a notice when no notes", vcr: no_notes do
        EvernoteOAuth::NoteStore.any_instance.stub_chain(:findNotesMetadata, :notes).and_return([])
        sign_in
        should have_content "Uh-Oh."
      end

      describe 'with notes' do
        notes = { cassette_name: 'recipe_pages/index/signed_in/notes' }
        before { sign_in }

        it "should have \"Sign Out\" link in header", vcr: notes do
          should have_selector('#sign_out_header', text: 'Sign Out')
        end

        it "should have \"Signed in!\" notice", vcr: notes do
          should have_content "Signed in!"
        end

        it "should show the user's name in the header", vcr: notes do
          should have_content "recipe-test"
        end

        it "should show all recipes", vcr: notes do
          should have_content "French Onion"
        end

        it "should not show non-recipe notes", vcr: notes do
          should_not have_content "Getting Started"
        end
      end
    end
  end
end