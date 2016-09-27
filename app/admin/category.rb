ActiveAdmin.register Category do

  menu priority: 5

  permit_params :name, :value

  config.sort_order = 'id_asc'

  actions :index, :new, :create, :update, :edit

  filter :name
  filter :value
  filter :created_at

  index do
    column :id
    column :name do |category|
      link_to category.name, admin_rows_by_categories_path(category_id: category.id)
    end
    column :value
    # column :rows_count
    column 'Update', defaults: false do |category|
      link_to('Update', "/admin/categories/#{category.id}/update_category")
    end
    actions
  end

  member_action :update_category, method: :get do
    category = Category.find(params[:id])

    log = UpdatesLog.create(category: category, status: :process)

    # is this need or what ?
    Row.where(category: category).delete_all

    Thread.new {
      result = Parser.parse(category)
      log.update(rows_count: Row.where(category: category).count)
      result ? log.success! : log.failed!
    }

    redirect_to admin_updates_logs_path
  end

  member_action :status, method: :get do
    log = UpdatesLog.find(params[:id])
    render json: {rows: Row.where(category: log.category).count, status: log.status}
  end

end