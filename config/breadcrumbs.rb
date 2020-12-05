# crumb "現在のページ名（表示させるビューにもページ名記述）" do
#   link "パンくずリストでの表示名", "アクセスしたいページのパス"
#   parent :親要素のページ名(前のページ)
# end

crumb :root do
  link "Home", root_path
end

crumb :new_item do
  link "商品出品", new_item_path
  parent :root
end

crumb :show_item do |item|
  link "商品詳細情報[#{item.name}]", item_path(item)
  parent :root
end

crumb :edit_item do |item|
  link "商品詳細編集[#{item.name}]", item_path(item)
  parent :show_item, item
end

crumb :index_order do |item|
  link "商品購入[#{item.name}]", item_orders_path(item)
  parent :show_item, item
end

crumb :new_session do |user|
  link "ログイン", new_user_session_path
  parent :root
end

crumb :new_registration do |user|
  link "新規登録", new_user_registration_path
  parent :root
end

# crumb :users do
#   link "ログインページ", new_user_session_path
#   parent :root
# end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).