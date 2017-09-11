class AssetsController < ApplicationController
  before_action :autheticate_use!

  def create
    asset = @card.assets.build(asset_params)
    if asset.save
    else
    end
  end

  private
    def asset_params
      params.permit(:file_name, :file_type, :file_link, :file_source)
    end
end
