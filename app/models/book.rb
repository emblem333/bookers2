class Book < ApplicationRecord
   belongs_to :user

    #空でないように設定してください。
  validates:title,presence:true
  validates:body,presence:true,
   length:{maximum:200}#最大200文字まで
end
