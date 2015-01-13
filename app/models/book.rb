class Book < ActiveRecord::Base

	  	include Tire::Model::Search
	  	include Tire::Model::Callbacks
		mount_uploader :picture, PictureUploader
		has_many :copy, dependent: :destroy
		belongs_to :genre
		validates :title,  presence: true, length: { maximum: 50 }
		validates :author,  presence: true, length: { maximum: 50 }
		validates :synopsis, presence:true
		validates :genre_id, presence:true

end
Book.import