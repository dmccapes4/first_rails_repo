# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date
#  end_date   :date
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'action_view'

class CatRentalRequest < ApplicationRecord
    validates :cat_id, presence: true
    validates :status, presence: true
    # validate :does_not_overlap_approved_request

    belongs_to :cat,
      primary_key: :id,
      foreign_key: :cat_id,
      class_name: 'Cat'


  def overlapping_requests
    CatRentalRequest.where('cat_id = ?', cat_id)
    .where.not('id = ?', id)
    .where('? < start_date OR ? < end_date', start_date, start_date)
    .where('? < start_date OR ? < end_date', end_date, end_date)
  end

  def overlapping_approved_requests

  end
end
