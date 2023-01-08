class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update]
  before_action :set_group_by_group_id, only: %i[join leave]
  before_action :ensure_correct_user, only: %i[edit update]

  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @book = Book.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id

    if @group.save
      GroupUser.create(group: @group, user: current_user)
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @group.assign_attributes(group_params)
    if @group.save
      redirect_to groups_path
    else
      render :edit
    end
  end

  def join
    if GroupUser.create(group: @group, user: current_user)
      redirect_to group_path(@group)
    else
      redirect_to groups_path, notice: 'グループの参加に失敗しました'
    end
  end

  def leave
    group_user = GroupUser.find_by(group: @group, user: current_user)
    if group_user.destroy
      redirect_to groups_path
    else
      redirect_to groups_path, notice: 'グループの退会に失敗しました'
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_group_by_group_id
    @group = Group.find(params[:group_id])
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    redirect_to groups_path if @group.blank?
    redirect_to groups_path if current_user != @group.owner
  end
end
