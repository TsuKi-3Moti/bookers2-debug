class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "active_follow_id", dependent: :destroy
  has_many :active_follows, through: :active_relationships, source: :passive_follow

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "passive_follow_id", dependent: :destroy
  has_many :passive_follows, through: :passive_relationships, source: :active_follow

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def followed_by?(user)
    passive_relationships.find_by(active_follow_id: user.id).present?
  end

  def self.search_for(search_word, method)
    if method == "perfect"
      User.where(name: search_word)
    elsif method == "forward"
      User.where("name LIKE ?", search_word + "%")
    elsif method == "backward"
      User.where("name LIKE ?", "%" + search_word)
    else
      User.where("name LIKE ?", "%" + search_word + "%")
    end
  end

end
