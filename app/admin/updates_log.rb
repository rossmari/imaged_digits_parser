ActiveAdmin.register UpdatesLog do

  actions :index

  menu priority: 2

  config.sort_order = 'created_at_desc'

  index do
    column :id do |log|
      raw("<div class='#{log.status}'>#{log.id}</div>")
    end
    column :created_at
    column :category
    column :rows_count do |log|
      raw("<div id='#{log.id}_rows_count'>#{log.rows_count}</div>")
    end
    column :status do |log|
      raw("<div class='#{log.status}_color' id='#{log.id}_status'>#{log.status.capitalize}</div>")
    end
  end

end