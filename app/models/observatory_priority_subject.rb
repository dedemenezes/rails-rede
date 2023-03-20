class ObservatoryPrioritySubject < ApplicationRecord
  belongs_to :priority_type
  belongs_to :observatory
  validates :priority_type, uniqueness: { scope: :observatory, message: 'Sujeito prioritário já atribuido' }
end
