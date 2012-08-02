class FeedsController < ApplicationController  
  def firepoints
    @feed = Firepoint.detected(6.days.ago)
    
    respond_to do |format|
      format.geojson do
        render :json => { 
          type: "FeatureCollection", 
          features: @feed.collect do |f|
            {
              type: "Feature",
              geometry: RGeo::GeoJSON.encode(f.the_geom),
              properties: f.as_json
            }
          end
        }    
      end
    end
  end
  
  def modis
    @feed = RealtimeTile.desc('properties.id').limit(params[:limit] || 20).all
    
    respond_to do |format|
      format.geojson do
        index = 0
        render :json => {
          type: "FeatureCollection", 
          features: @feed
        }
      end
    end
  end
  
  caches_page :census_county
  def census_county
    @feed = CensusCounty.all
    
    respond_to do |format|
      format.geojson do
        render :json => {
          type: 'FeatureCollection',
          features: @feed.collect do |f|
            {
              type: 'Feature',
              geometry: f.geometry.as_json,
              properties: CensusApi.where(:state => f.state, :county => f.county).first
            }
          end
        }
      end
    end
  end
  
  def poi
    @feed = Poi.active
    if params[:category]
      @feed = @feed.where(category: params[:category])
    end
    
    respond_to do |format|
      format.geojson do
        render :json => { 
          type: "FeatureCollection", 
          features: @feed.collect do |f|
            {
              type: "Feature",
              geometry: RGeo::GeoJSON.encode(f.geom),
              properties: f.as_json
            }
          end
        }
      end
    end
  end
end
