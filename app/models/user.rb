class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :links, dependent: :destroy

  after_create :create_default_links
  after_update :create_default_links

  validates :full_name, length: { maximum: 40 }
  validates :body, length: { maximum: 80 }
  validate :valid_username

  def valid_username
    errors.add(:username, "is already taken") if User.where(username:).where.not(id:).exists?

    restricted_username_list = %[admin root dashboard analytics appearance settings preferences calendar]

    errors.add(:username, "is restricted") if restricted_username_list.include?(username)
  end

  def get_daily_profile_views
    daily_views = Ahoy::Event.where("json_extract(properties, '$.user.id') LIKE '#{id}'")
                             .where(name: 'Viewed Dashboard')
    daily_views.group_by_day(:time).count
  end

  private

  def create_default_links
    Link.create(user: self, title: '', url: '') while links.count < 5
  end
end
