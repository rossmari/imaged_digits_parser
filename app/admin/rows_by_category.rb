ActiveAdmin.register Row, as: 'RowsByCategory' do

  actions :index

  menu false

  config.per_page = 30
  config.sort_order = 'id_asc'

  filter :name

  index download_links: [:xlsx] do
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

  controller do

    def scoped_collection
      super.where(category_id: params[:category_id])
    end

    def index
      index! do |format|
        format.html
        format.xlsx {
          package = RowsExcelBuilder.generate_xlsx(params[:category_id])
          send_data package.to_stream.read, type: 'application/xlsx', filename: "download-#{DateTime.now.to_i}.xlsx"
        }
      end
    end

  end

end
