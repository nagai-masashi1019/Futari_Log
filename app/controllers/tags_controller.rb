class TagsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tag = Tag.new
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

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
