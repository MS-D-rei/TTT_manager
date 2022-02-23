module LoginHelper
  def admin_user_log_in
    fill_in 'user[email]', with: admin_user.email
    fill_in 'user[password]', with: admin_user.password
    click_on 'ログイン'
  end

  def normal_user_log_in
    fill_in 'user[email]', with: normal_user.email
    fill_in 'user[password]', with: normal_user.password
    click_on 'ログイン'
  end

  def log_out
    click_on 'ログアウト'
  end
end
