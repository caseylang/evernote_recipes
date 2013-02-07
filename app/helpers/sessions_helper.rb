module SessionsHelper
  # todo: there is an uncomfortable amount of stuff here. Move it.
  def get_note_image(recipe, options= { })
    accepted_formats = [:jpg, :gif, :bmp, :png]
    img_url = 'rails.png'
    if signed_in?
      img_url = "#{current_user.web_api_url}/thm/note/#{recipe.guid}"
      if options[:format] && accepted_formats.find_index(options[:format].downcase)
        img_url << ".#{options[:format].downcase}"
      end
      img_url << "?size=#{options[:size]}" if options[:size]
    end
    img_url
  end
end