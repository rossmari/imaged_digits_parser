ActiveAdmin.register Row do

  actions :index

  menu priority: 1

  config.per_page = 30
  config.sort_order = 'id_asc'

  filter :category
  filter :name
  filter :created_at

  index do
    column :id
    column :name
    column :category
    column 'Mana' do |row|
      multi_row(row, :mana)
    end
    column 'Type' do |row|
      multi_row(row, :type)
    end
    column 'P/T' do |row|
      multi_row(row, :pt)
    end
    column 'Rarity' do |row|
      multi_row(row, :rarity)
    end
    column 'Condition' do |row|
      multi_row(row, :condition)
    end
    column 'Stock' do |row|
      multi_row(row, :stock)
    end
    column 'Price' do |row|
      multi_row(row, :price)
    end
  end

end
