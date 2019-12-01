crumb :root do
#topページ
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", mypage_index_path
end

crumb :creditcards do
  link "支払い方法", creditcards_path
  parent :mypage
end

crumb :confirm do
  link "本人情報の登録", confirm_index_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", users_path
  parent :mypage
end
# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).