class Participant < ApplicationRecord
  belongs_to :profile
  belongs_to :room

end
