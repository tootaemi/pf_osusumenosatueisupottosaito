class Post < ApplicationRecord
  belongs_to :customer
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  
  attribute :hash_tags
  attribute :sent_tags
  
  validates :address, presence: true, length: { maximum: 255 }
  validates :introduction, presence: true, length: { maximum: 2000 }





  #   def bookmarked_by?(user)
  #   bookmarks.where(user_id: user).exists?
  # end


  # def bookmarkd_by?(customer)
  #   bookmarks.exists?(customer_id: customer.id)
  # end
  
  
# def bookmarkd?(customer)
#   bookmarks.where(customer_id: customer.id).exists?
# end


  has_one_attached :image
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_images.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image
  end
  
  after_initialize :to_hash_tags
  after_validation :to_sent_tags
  after_save :save_tag
  
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  def to_hash_tags
    if self.tags.any?
      self.hash_tags = self.tags.map{|o| "#" + o.tag_name }.join(" ")
    end
  end
  
  def to_sent_tags
    if self.hash_tags.present? 
      self.sent_tags = self.hash_tags.gsub(/[[:space:]]/, '').split("#").select{|s| s.present? }
    else
      self.sent_tags = []
    end
  end

  
  def save_tag
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    old_tags.each do |old|
      tag = Tag.find_by(tag_name: old)
      post_tags = tag.post_tags
      if post_tags.size == 1
        post_tags.destroy_all
        tag.destroy
      elsif post_tags.size >= 2
        post_tags.find_by(post_id: self.id)&.destroy
      end
    end
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

  def bookmarked_by?(post)
  bookmarks.where(post_id: post_tag_ids).exists?
  #bookmarks.exists?(post_id: post.id)
  # bookmarks.where(customer_id: customer.id).exists?
  end
  #has_many :comments, dependent: :destroy
  #has_many :favorits, dependent: :destroy
end


  def bookmarked_by?(current_customer)
     bookmarks.where(customer_id: current_customer.id).exists?
  end
  
  
  def self.search(search)
    if search != ""
      Post.where('title LIKE(?)', "%#{search}%")
    else
      Post.includes(:customer)
    end
  end