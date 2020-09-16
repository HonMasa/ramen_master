module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_post = link_to 'あなたの投稿', posts_show_path(notification), style: 'font-weight: bold;'
    @visiter_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentか
    case notification.action
    when 'follow'
      tag.a(notification.visiter.name, href: user_path(@visiter), style: 'font-weight: bold;') + 'があなたをフォローしました'
    when 'like'
      tag.a(notification.visiter.name, href: user_path(@visiter), style: 'font-weight: bold;') + 'が' + tag.a('あなたの投稿', href: posts_show_path(notification.post_id), style: 'font-weight: bold;') + 'にいいねしました'
    when 'comment' then
      @comment = Comment.find_by(id: @visiter_comment)&.content
      tag.a(@visiter.name, href: user_path(@visiter), style: 'font-weight: bold;') + 'が' + tag.a('あなたの投稿', href: posts_show_path(notification.post_id), style: 'font-weight: bold;') + 'にコメントしました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
