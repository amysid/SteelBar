class HomesController < ApplicationController
  before_action :authenticated_user
  layout 'admin_lte_2'
  def index
  end
end
