class MypageController < ApplicationController
  # マイページの表示
  def show
    @user = current_user
    @book = Bookmark.where(user_id: @user.id)
    puts @book.inspect
  end

  # ブックマークの登録
  def new
    @bookmark = Bookmark.new(user_id: current_user.id, shop_id: params[:shop_id], shop_name: params[:shop_name])
    if @bookmark.save
      flash[:notice] = "ブックマークが正常に登録されました。"
    else
      flash[:alert] = "ブックマークの登録に失敗しました。"
    end
    redirect_back(fallback_location: root_path)
  end

  # ブックマークの削除

  def destroy
    @bookmark = Bookmark.find(params[:bookmark])
    @bookmark.destroy
    flash[:notice] = "ブックマークが正常に削除されました。"
    redirect_to mypage_path
  end

  # レビューの作成
  def create
    @review = Review.find_or_create_by(shop_id: params[:shop_id], user_id: current_user.id)
    @review.good = (@review.good || 0) + params[:good].to_i
    @review.bad = (@review.bad || 0) + params[:bad].to_i

    # ユーザーの所持ポイントからレビューに付けるポイントを引く（今回はテストアカウントが無いため、ゼロ以下でも無視して付与できる）
    current_user.points -= params[:good].to_i + params[:bad].to_i

    if @review.save && current_user.save
      redirect_back(fallback_location: mypage_path, notice: 'ポイントを付けました')
    else
      render :new
    end
  end

  # テスト用、ポイントを一万点増やす
  def increase_points
    current_user.points += 10000
    current_user.save
    redirect_to mypage_path, notice: 'ポイントが一万点増えました！'
  end


  private

  def review_params
    params.require(:review).permit(:good, :bad)
  end
end
