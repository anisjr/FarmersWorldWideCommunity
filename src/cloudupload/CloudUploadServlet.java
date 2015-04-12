package cloudupload;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.blobstore.*;
import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class CloudUploadServlet extends HttpServlet {
    static {
        ObjectifyService.register(Upload.class);
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

        // R�cup�re les derniers uploads
        List<Upload> uploads = ofy().load().type(Upload.class).order("-date").limit(9).list();
        req.setAttribute("uploads", uploads);


        this.getServletContext().getRequestDispatcher("/WEB-INF/formUpload.jsp").forward(req, resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        List<BlobKey> blobKeys = blobs.get("uploadedFile");

        Upload upload = new Upload(blobKeys.get(0), req.getParameter("description"),req.getParameter("location"),req.getParameter("areaAffected"));

        ofy().save().entity(upload).now();

        resp.sendRedirect("/");

    }
}
