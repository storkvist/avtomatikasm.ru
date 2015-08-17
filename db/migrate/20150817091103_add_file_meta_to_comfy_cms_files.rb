class AddFileMetaToComfyCmsFiles < ActiveRecord::Migration
  def change
    add_column :comfy_cms_files, :file_meta, :text
  end
end
