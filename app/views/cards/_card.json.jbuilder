json.extract! card, :id, :title, :description, :project_id, :created_at, :updated_at
json.url card_url(card, format: :json)
