ActiveAdmin.register ErrorCase do

  config.per_page = 10

  filter :category

  index do
    column :id
    column :text
    column :category
  end


end
