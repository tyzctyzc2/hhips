<html>
<head>
	<meta charset="utf-8"/>
	<title>${sourcename}</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<#include "/header.ftl">
		<h1><a href="./Chapter?sourceid=${sourceid}" style="text-decoration: none">${sourcename}</a></h1>
		<#if chapterlength != -1>
			<table class="dmmtable" style="font-size:  x-large;">
					<#list 0..chapterlength as i>
						<tr>
							<td>
								<p>${chapters[i].sourcechapterindex}</p>
							</td>
							<td>
								<a href="./Chapter?chapterid=${chapters[i].idsourcechapter?c}" style="text-decoration: none">
									<p>${chapters[i].sourcechaptername}</p>
								</a>
							</td>
							<td>
                                <a href="./note?chapterid=${chapters[i].idsourcechapter?c}" style="text-decoration: none">
                                    <p>笔记(${chapters[i].chapternotecount})</p>
                                </a>
                            </td>
							<td>
                                <p>${chapters[i].chapterproblemcount}</p>
                            </td>
						</tr>	
					</#list>
			</table>
		</#if>
		<p>New Chapter:</p>
		<input class="bigFont" type="text" id="newchaptername" />
		<button class="bigFont" type="button" onclick="postChapter()">Create Chapter</button>
	</body>
	<script>
		var sourceID = ${sourceid?c};
		var newchapterindex=${newchapterindex?c}
		function postChapter() {
			var pData = {};
			pData.sourcechaptername = $( "#newchaptername" ).val();
			pData.sourcechapterindex = newchapterindex;
			pData.sourceid = sourceID;
			
			console.log(JSON.stringify(pData));
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: "./Chapter",
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: JSON.stringify(pData),
				success: function(msg) {
			    	console.log(msg);
			    	window.location.reload();
				},
				fail: function(msg) {
			    	console.log(msg);
			    }
			})
		}
	</script>
</html>