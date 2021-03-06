class PhysicalRack
  include Mongoid::Document
  include Mongoid::Denormalize

  field :name, type: String
  field :site_name, type: String
  field :status, type: Integer
  #associations
  belongs_to :site
  has_many :servers, dependent: :nullify
  #denormalized fields
  denormalize :name, from: :site
  denormalize :full_name, to: :servers

  before_destroy :nullify_denormalized_fields

  STATUS_PROD = 1
  STATUS_STOCK = 2

  def full_name
    [site_name, name].compact.join(" - ")
  end
  alias :to_s :full_name

  def stock?
    status == STATUS_STOCK
  end

  protected
  #TODO: remove it when https://github.com/logandk/mongoid_denormalize/pull/10 is merged and released
  def nullify_denormalized_fields
    servers.each do |server|
      server.update_attribute(:physical_rack_id, nil)
    end
  end
end
