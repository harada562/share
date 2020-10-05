class Admin::GroupsController < ApplicationController
  before_action :authenticate
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    # binding.pry
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end

  def group_params
    params.require(:group).permit(:name, :is_closed, :key_word, :customer_id)
  end
  # 管理者ページはログインしていないと操作できない

  private

  def authenticate
    redirect_to admin_session_path unless admin_signed_in?
  end
end
