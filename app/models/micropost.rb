class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) } # 13.17
  mount_uploader :picture, PictureUploader # 13.59
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  validate  :picture_size  ########### 13.65 de aqui hacia abajo

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "Debe ser menora a 5MB")
      end
    end
end
