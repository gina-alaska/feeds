class Layer
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :owner_id, type: Integer
  field :properties, type: Array, default: []
  
  has_one :geojson, class_name: 'GeoJson', dependent: :delete, autosave: true
  
  def as_json(*args)
    { name: self.name, geojson: self.geojson }
  end
  
  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
  
  def from_geojson(json)
    json = JSON.parse(json) if json.kind_of? String
    self.geojson = GeoJson.from_geojson(json)
    
    self
  end
end
