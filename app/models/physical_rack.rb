class PhysicalRack
  include Mongoid::Document

  field :name, type: String
  field :site_name, type: String
  field :status, type: Integer
  belongs_to :site

  before_save :fill_in_site_name

  attr_accessible :name, :site_id, :status

  STATUS_PROD = 1
  STATUS_STOCK = 2

  def servers
    Server.where(physical_rack_mongo_id: self.id.to_s)
  end

  def to_s
    [site_name, name].compact.join(" - ")
  end

  def stock?
    status == STATUS_STOCK
  end

  protected
  def fill_in_site_name
    self.site_name = self.site.try(:name)
  end
end
