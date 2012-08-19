class Area < Dictionary
  has_many :families, dependent: :nullify
end
