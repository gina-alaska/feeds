class FeatureCollection < GeoJson
  field :type, type: String, default: 'FeatureCollection'
  
  has_many :features, autosave: true
  
  def as_json(*args)
    { type: self.type, features: self.features }
  end
  
  def self.from_geojson(json)
    json = JSON.parse(json) if json.kind_of? String
    
    collection = self.new
    
    json['features'].collect { |f| collection.features << Feature.from_geojson(f) }
    
    collection
  end
end
