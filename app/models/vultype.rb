class Vultype < ApplicationRecord
	has_many :vuls, class_name: "Vul", foreign_key: "type_id"
end
