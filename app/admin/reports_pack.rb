ActiveAdmin.register ReportsPack do

  menu priority: 0

  permit_params :name, chemical_reports_attributes: [:id, :file]

  config.sort_order = 'created_at_desc'

  actions :index, :new, :create, :update, :edit, :show

  filter :name
  filter :input_file
  filter :created_at

  index do
    column :name
    column :files do |record|
      record.chemical_reports.map do |report|
        report.file.file.filename
      end.join('<br>').html_safe
    end
    column 'Upload all' do
      'TODO : UPLOAD ALL LINK'
    end
    column :status
    column :created_at
    actions defaults: true do |pack|
      link_to 'Separate', separate_admin_reports_pack_path(pack)
    end
  end

  member_action :separate, method: :get do
    redirect_to collection_path, notice: "Start separation of #{resource.id} pack!"
  end

  show do
    attributes_table do
      row :name
      row :files do |record|
        record.chemical_reports.map do |report|
          report.file.file.filename
        end.join('<br>').html_safe
      end
      row 'Upload all' do
        'TODO : UPLOAD ALL LINK'
      end
      row :created_at
    end
  end

  form html: { multipart: true } do |f|
    f.inputs 'Files upload' do
      f.input :name, input_html: {value: "ReportsPack_#{DateTime.now.strftime('%d_%m_%Y_%H_%M')}"}
      f.has_many :chemical_reports do |p|
        p.input :file, hint: (p.object.file.file.present? ? p.object.file.file.filename : 'no file')
      end
    end
    f.actions
  end


end