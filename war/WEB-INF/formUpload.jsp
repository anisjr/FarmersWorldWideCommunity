<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.blobstore.*"%>
<%@ page import="cloudupload.Upload"%>

<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory
            .getBlobstoreService();
%>

<!DOCTYPE html>
<html>
<head>
<title>Crop Alert</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/style.css" rel="stylesheet" media="screen">
</head>
<body>

	<div class="container-narrow">

		<div class="masthead">
			<ul class="nav nav-pills pull-right">
				<li class="active"><a href="/">Welcome</a></li>
				<li><a href="#list">Crop diseases</a></li>
				<li><a href="#upload">Upload</a></li>
			</ul>
			<h3 class="muted">Crop Alert</h3>
		</div>

		<hr />

		<div class="jumbotron">
			<h1>
				
			</h1>
			<p class="lead">help to mitigate the spread of epidemics  <br />
			With one click, upload your crop diseases and Learn from growers! !</p>
			<a class="btn btn-large btn-success" href="#upload">Upload crop picture</a>
		</div>

		<hr />

		<div class="row-fluid iconlist" id="list">

			<h2>diseases list</h2>

			<p>
				<span class="label">Note</span> Only the last 9 diseases
uploaded are presented here.
			</p>

			<%
			    List<Upload> uploads = (List<Upload>) request.getAttribute("uploads");
				if (uploads.size() == 0) {
				    %>

			<p>
				<em>No uploaded disease </em>
			</p>

			<%
				}
				else {
				int i = 0;
			    for (Upload upload : uploads) {
			        if ((i % 3) == 0) {
			%>
			<div class="row">
				<% } %>

				<div class="span4">
					<figure>
						<img src="<%=upload.getUrl()%>" alt="Image utilisateur"
							class="img-polaroid" style="width: 150px;height: 150px;" />
						<figcaption><%=upload.getDescription()%></figcaption>
					</figure>
				</div>

				<%
			if ((i % 3) == 2 || i == uploads.size() - 1) {
				%>
			</div>
			<%			}
						i++;
					}
			    }%>

		</div>

		<hr />

		<div class="row-fluid iconlist" id="upload">

			<h2>Upload a photo</h2>

			<form
				action="<%= blobstoreService.createUploadUrl("/") %>"
				method="post" enctype="multipart/form-data">
				<p>
					<label>Photo : <input type="file"
						name="uploadedFile" /></label>
				</p>
				
				<p>
					<label>Description  : <input type="text"
						name="description" /></label>
				</p>
			<p>
					<label>% area currently affected : <input type="text"
						name="areaAffected" /></label>
				</p>
				<p>
					<label>Location : <input type="text"
						name="location" /></label>
				</p>
				
				<div class="form-actions">
					<input type="submit" class="btn" />
				</div>
			</form>
		</div>

	</div>
	<script src="http://code.jquery.com/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
