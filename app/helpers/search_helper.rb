module SearchHelper
  
  def get_genres
    Genre.all.append(Genre.new(id: 0, name: "Any"))
  end

end
