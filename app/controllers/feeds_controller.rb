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
