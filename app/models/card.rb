class Card < ApplicationRecord
  include AlgoliaSearch
  extend FriendlyId

  after_create :increment_cards_count_of_current_user
  after_destroy :decrement_cards_count_of_current_user

  belongs_to :project
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :assets, dependent: :destroy

  acts_as_taggable_on :tags
  before_validation :set_unique_public_share_token, on: :create


  algoliasearch index_name: "Card" do
    attributes :title, :description, :tag_list
    searchableAttributes ['title']
  end

  friendly_id :public_share_token, use: :slugged

  def public_share_url
    subdomain, host = case Rails.env
                      when 'development' then ['share',         'timblee.dev']
                      when 'staging'     then ['share-staging', 'timblee.io']
                      when 'prep'        then ['share-prep',    'timblee.io']
                      when 'production'  then ['share',         'timblee.io']
                      end

    options = { subdomain: subdomain, host: host }

    options.merge!(port: '3000')      if Rails.env.development?
    options.merge!(protocol: 'https') if Rails.env.production?
    Rails.application.routes.url_helpers.card_public_share_url(public_share_token, options)
  end

  def set_unique_public_share_token
    self.public_share_token = Digest::SHA1.hexdigest([Time.now, rand].join)[0,10]
  end

  private
    def increment_cards_count_of_current_user
      User.current_user.increment!(:cards_created)
    end

    def decrement_cards_count_of_current_user
      User.current_user.decrement!(:cards_created)
    end
end
