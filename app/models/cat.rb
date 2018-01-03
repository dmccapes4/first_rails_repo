# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string
#  name        :string
#  sex         :string(1)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'


class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  validates :birth_date, presence: true
  validate :m_or_f
  validate :colors

  has_many :cat_rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: 'CatRentalRequest',
    dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end

  private
  def m_or_f
    if sex != 'M' && sex != 'F'
      errors[:sex] << 'must be male or female'
    end
  end

  def colors
    unless ["black", "white", "tan", "brown", "indigo"].include? color
      errors[:color] << 'must be black, white, tan, brown or indigo'
    end
  end
end
