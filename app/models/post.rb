class Post < ActiveRecord::Base

  include PgSearch
  #agregar los parametros de busqueda segun 1 o n campos o parametros
  multisearchable against: [:title, :content]
  
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :votes, as: :votable
  has_many :user_votes, through: :votes, source: :user

  def voted_by?(user)
    self.user_votes.include? user
  end
end
