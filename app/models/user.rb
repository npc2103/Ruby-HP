class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_points

  private

  # ユーザー登録時にポイントを付与する（テスト用）
  def assign_default_points
    self.update(points: 10000)
  end
end
