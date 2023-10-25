# You can use a global variable, DB, which is an instance of SQLite3::Database
# No need to create it, you can just use it!
class Post
  attr_accessor :id
  attr_reader :url, :votes, :title

  def initialize(attributes = {})
    @id  = attributes[:id]
    @title = attributes[:title]
    @url = attributes[:url]
    @votes = attributes[:votes] || 0
  end

  # Méthode de classe => doit retourner une instance de Post selon un id
  def self.find(id)
    DB.results_as_hash = true
    # Rechercher un post dans DB via l'id passé en paramètre
    post = DB.execute("SELECT * FROM posts WHERE id = ?", id).first
    # Si aucun post n'est trouvé, retourner nil
    return if post.nil?
    # Créer une nouvelle instance de Post
    Post.new(id: post["id"], title: post["title"], url: post["url"], votes: post["votes"])
    # Instance de post
    # <Post: id title url votes>
  end

  # Méthode de classe => doit retourner toutes les instances de Post
  def self.all
    DB.results_as_hash = true
    # Rechercher tous les posts en base de donnée
    posts = DB.execute("SELECT * FROM posts")
    # Pour chacun des posts (un post est un hash)
    posts.map do |post|
      # Créer une instance de Post avec les valeurs du hash récupérées depuis la DB
      Post.new(id: post["id"], title: post["title"], url: post["url"], votes: post["votes"])
    end
  end
end
