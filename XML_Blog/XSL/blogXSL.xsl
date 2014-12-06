<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:auth="www.josephborgcmt3313.wordpress.com/author" 
xmlns:pg="www.josephborgcmt3313.wordpress.com/page" 
xmlns:pst="www.josephborgcmt3313.wordpress.com/post"
xmlns:pgcmt="www.josephborgcmt3313.wordpress.com/pagecomment" 
xmlns:pstcmt="www.josephborgcmt3313.wordpress.com/postcomment" > 
    <xsl:template match="/"> 
		<html>
			<head>
				<title> Blog </title>
				<link rel="stylesheet" type="text/css" href="CSS/blog.css" />
				<script src="javascript/jquery-git.js" />
				<script>
					function getInput() {
						var el = document.getElementById("txbSearch").value;
						document.getElementById("random").innerHTML = el;
					}
					$(document).ready(function () {	
						$('.commentButton').click(function() {
							var state = $(this).next('.allComments').hasClass('check');
							if(state) {
								$(this).next('.allComments').removeClass('check');
							} else {
								$(this).next('.allComments').addClass('check');
							}
						});
					});
				</script>
				
			</head>
			
			<body>
				<header>
					<h1> Blog </h1>
				</header>
				
				<section>
					<div id="content2">
						<input type="text" class="txbSearch" id="txbSearch" name="txbSearch" size="21" maxlength="120" placeholder="Search Authors" onkeyup="getInput()"/>
						<br />
						<h3> List Of Authors </h3>
						<table>
							<tr>
								<th id="authors"> User </th>
								<th id="listDate"> Date Joined </th>
								<th> Posts </th>
							</tr>
							<xsl:apply-templates select="blog/blog_authors/auth:author" />
						</table>
						<br/>
						<span id="random"> </span>
					</div>
					<div id="content1">
						<xsl:for-each select="blog/blog_pages/pg:page">
							<xsl:variable name="getPageID" select="@pgID"/>
							<xsl:variable name="getAuthID" select="@created_by"/>
							<xsl:for-each select="pst:post">
								<xsl:variable name="getPostID" select="@pstID"/>
								<div id="post">
									<div id="title"> 
										<h2> <xsl:value-of select="pst:title"/> </h2> 
									</div>
									<div id="postHeader"> 
										<table class="table">
											<tr>
												<td> By </td>
												<td> <xsl:value-of select="//blog/blog_authors/auth:author[@authID=$getAuthID]/auth:name"/> </td>
												<td> <xsl:value-of select="//blog/blog_authors/auth:author[@authID=$getAuthID]/auth:surname"/> </td>
											</tr>
										</table>
										<table class="table">
											<tr>
												<td> Posted On </td>
												<td> <xsl:value-of select="pst:date"/> </td>
												<td class="whitespace"></td>
												<td> Updated On </td>
												<td> <xsl:value-of select="pst:update"/> </td>
											</tr>
										</table>
										<hr />
									</div>
									<br/>
									<xsl:for-each select="pst:paragraph">
										<p id="paragraph"> <xsl:value-of select="pst:text"/> </p>
										<xsl:for-each select="pst:image">
											<xsl:choose>
												<xsl:when test=". != ''">
													<img class="imgPost" src="images/">
														<xsl:attribute name="src">
															images/<xsl:value-of select="." />
														</xsl:attribute>
													</img>
													<br />
												</xsl:when>
												<xsl:otherwise>
													<br />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
										<xsl:if test="pst:reference != ''">	
											<p class="refPost">
												<xsl:for-each select="pst:reference">
													<br />
													<xsl:if test=". != ''">
														<a>
															<xsl:attribute name="href">
																<xsl:value-of select="." />
															</xsl:attribute>
															<xsl:value-of select="." />
														</a>
													</xsl:if>
												</xsl:for-each>
											</p>
										</xsl:if>
									</xsl:for-each>
									<br/>
									<br/>
									<!-- Post Comments -->
									<div id="comments">
										<hr id="hrComment"/>
										<input class="commentButton" type="submit" >
											<xsl:attribute name="value">
												<xsl:value-of select="count(//blog/all_comments/pstcmt:comment [@comment_post = $getPostID])" /> Comments
											</xsl:attribute>
										</input>
										<div class="allComments">	
											<xsl:for-each select="//blog/all_comments/pstcmt:comment [@comment_post = $getPostID]">
												<div class="eachComment">
													<table>
														<tr> 
															<td> <xsl:value-of select="pstcmt:name"/>  </td> 
															<td> </td>
															<td> <xsl:value-of select="pstcmt:time_stamp"/> </td>
														</tr>
													</table>
													<p class="comment"> <xsl:value-of select="pstcmt:message"/> </p>
													<br/>
												</div>
											</xsl:for-each>
											
										</div>
										<hr id="hrComment"/>
									</div>
								</div>
							</xsl:for-each>
						</xsl:for-each>
					</div>
				</section>
				
				<footer>
					<p> Designed and Made By Joseph Borg © </p>
				</footer>				
			</body>
		</html>
    </xsl:template>
	
	<xsl:template match="blog/blog_authors/auth:author" >
		<xsl:variable name="myInput" select="@authID"/>
		<xsl:variable name="athID" select="@authID"/>
		<tr>
			<td id="authors">
				<xsl:value-of select="auth:name"/>
				&#160;
				<xsl:value-of select="auth:surname"/>
			</td>
			<td id="listDate">
				<xsl:value-of select="auth:date_joined"/>
			</td>
			<td>
				<xsl:value-of select="count(//blog/blog_pages/pg:page[@created_by=$athID]/pst:post)" />
			</td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>
