package cloudupload;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.images.ServingUrlOptions;

import java.util.Date;

import com.googlecode.objectify.annotation.*;


@Entity
@Cache
public class Upload {
    @Id Long id;
    @Index Date date;
    String url;
    @Index BlobKey key;
    String description;
    String location;
    String areaAffected;
    
    
    private Upload() {}
    public Upload(BlobKey key, String description,String location,String areaAffected) {
        ImagesService imagesService = ImagesServiceFactory.getImagesService();
        
        this.date = new Date();
        this.key = key;
        this.url = imagesService.getServingUrl(ServingUrlOptions.Builder.withBlobKey(key));
        this.description = description;
        this.location=location;
        this.areaAffected=areaAffected;
    }
    

    public String getUrl() {
        return url;
    }
    public BlobKey getKey() {
        return key;
    }
    public String getKeyString() {
        return key.getKeyString();
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getLocation(){
    	return location;
    }
    public String getAreaAffected(){
    	return areaAffected;
    }


}
