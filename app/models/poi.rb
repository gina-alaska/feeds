class Poi < ActiveRecord::Base
  establish_connection :portal
  
  set_rgeo_factory_for_column(:geom,
      RGeo::Geographic.spherical_factory(:srid => 4326))

  scope :active, where(:active => true)

  def latitude
    geom.lat
  end

  def longitude
    geom.lon
  end
  
  def as_json(*args)
    {
      name: self.name,
      category: self.category,
      url: "<a href=\"#{self.url}\">#{truncated_url}</a>",
      description: self.try(:description)
    }
  end
  
  def truncated_url
    if self.url.length > 180
      self.url[0..177] + '...'
    else
      self.url
    end
  end
end
