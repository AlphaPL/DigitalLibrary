class Copy < ActiveRecord::Base
  belongs_to :book
  validates :book_id,  presence: true
  validates :ISBN,   :isbn_format => true
  validates :year_of_print, presence: true
  validates :edition, presence: true
  validate :year_of_print_not_in_future?
  has_many  :borrowed_relationships, class_name:  "Possession",
                                    foreign_key: "borrowed_id",
                                    dependent:   :destroy
  has_many :borrowers, through: :borrowed_relationships, source: :borrower

  private

  def year_of_print_not_in_future?
    if year_of_print > Date.today.year
      errors.add(:year_of_print, 'Wrong year of print') 
    end
  end

end
