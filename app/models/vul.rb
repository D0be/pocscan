class Vul < ApplicationRecord
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	index_name 'dscan'
	document_type 'vuls'

	mount_uploader :file, PocUploader
	belongs_to :user
	validates :user_id, presence: true
	belongs_to :type, class_name: "Vultype"
	#validates :type_id, presence: true
	belongs_to :level, class_name: "Vullevel"
	#validates :level_id, presence: true

	default_scope { order(created_at: :desc) }

	mapping do
		indexes :name, type: 'string'
		indexes :description, type: 'string'
		indexes :search_key, type: 'string'
	end

	def as_indexed_json(_options = {})
	{
		name: self.name,
		description: self.description,
		search_key: self.search_key,
	}
	end
	
end
