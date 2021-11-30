class Article < ApplicationRecord
has_many :launch, dependent: :destroy
has_many :event, dependent: :destroy

end
