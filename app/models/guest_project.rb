class GuestProject < ApplicationRecord
  belongs_to :guest
  belongs_to :project

  validates :guest, :project, presence: true
  validates :guest, uniqueness: { scope: :project }
end
