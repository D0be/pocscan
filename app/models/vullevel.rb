class Vullevel < ApplicationRecord
	has_many :vuls, class_name: "Vul", foreign_key: "level_id"
end
