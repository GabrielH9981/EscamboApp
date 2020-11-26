class Ad < ActiveRecord::Base

  # Callbacks
  before_save :md_to_html

  # Associations
  belongs_to :member
  belongs_to :category

  validates :title, :category, presence: true
  validates :title, :description_md, :description_short, :category, presence: true
  validates :picture, :finish_date, presence:true
  validates :price, numericality: { greater_than: 0 }
  
  scope :descending_order, -> (quantity = 10) {limit(quantity).order(created_at: :desc)}
  scope :to_the, -> (member) {where(member: member)}

  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  monetize :price_cents

  private
  def md_to_html
    options = {
      filter_html: true,
      link_attributes: {
        rel: "nofollow",
        target: "_blank"
      }
    }

    extensions = {
      space_after_headers: true,
      autolink: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    self.description = markdown.render(self.description_md)
  end
  
end