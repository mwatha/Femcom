class DocumentCategory < ActiveRecord::Base
  set_table_name :document_categories
  has_many :documents,:class_name => 'Document',:foreign_key => :category 

end
