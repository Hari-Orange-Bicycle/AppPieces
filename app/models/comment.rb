class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :commenter, polymorphic: true

  strip_attributes :only => [:message]

  scope :order_by_created_at, -> { order('created_at ASC') }
  scope :by_commentable_type, -> (type) { where(commentable_type: type) }
  scope :by_commentable_id, -> (id) { includes(:commenter).where(commentable_id: id) }
end
