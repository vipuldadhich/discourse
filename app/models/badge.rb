class Badge < ActiveRecord::Base
  belongs_to :badge_type
  has_many :user_badges, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :badge_type, presence: true
  validates :allow_title, inclusion: [true, false]
  validates :multiple_grant, inclusion: [true, false]

  Welcome = 5
  NicePost = 6
  GoodPost = 7
  GreatPost = 8

  def self.trust_level_badge_ids
    (1..4).to_a
  end

  def reset_grant_count!
    self.grant_count = UserBadge.where(badge_id: id).count
    save!
  end

  def single_grant?
    !self.multiple_grant?
  end

  def self.like_badge_info
    [
      {id: NicePost, count: 10},
      {id: GoodPost, count: 25},
      {id: GreatPost, count: 100}
    ]
  end

end

# == Schema Information
#
# Table name: badges
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  description       :text
#  badge_type_id     :integer          not null
#  grant_count       :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  allow_title       :boolean          default(FALSE), not null
#  multiple_grant    :boolean          default(FALSE), not null
#  icon              :string(255)      default("fa-certificate")
#  listable          :boolean          default(TRUE)
#  target_posts      :boolean          default(FALSE)
#  query             :text
#  enabled           :boolean          default(TRUE), not null
#  auto_revoke       :boolean          default(TRUE), not null
#  badge_grouping_id :integer          default(5), not null
#  trigger           :integer
#  show_posts        :boolean          default(FALSE), not null
#  system            :boolean          default(FALSE), not null
#  image             :string(255)
#
# Indexes
#
#  index_badges_on_name  (name) UNIQUE
#
