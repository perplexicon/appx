class GroupsController < ApplicationController
  def index
    @groups = Group.all
    @sources = current_user.sources.where(group_id: nil)
  end

  def show
    @group = Group.find(params[:id])
    @sources = current_user.sources.where(group_id: @group.id)
  end
end
