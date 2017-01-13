class CommentMailer < ApplicationMailer
  default from: "from@example.com"

  def comment_email(user, post)
   mail to: user.email, subject: "あなたの投稿にコメントがつきました。"
 end
 
end
