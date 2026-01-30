class TagsController < ApplicationController
  before_action :authenticate_user!

  def new
    Tag.ensure_defaults!
    @tag = Tag.new
    @tags = Tag.for_user(current_user)
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.created_by_user = current_user

    if @tag.save
      redirect_to new_thank_path, notice: "タグを追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def toggle_visibility
    tag = Tag.for_user(current_user).find(params[:id])

    hidden = current_user.user_hidden_tags.find_by(tag:)
    if hidden
      hidden.destroy
    else
      current_user.user_hidden_tags.create!(tag:)
    end

    redirect_to new_tag_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
