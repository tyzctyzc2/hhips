<html>
<head>
	<meta charset="utf-8"/>
	<title>Chapter List</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<table>
            <tr>
                <td>
                    <a href="./Source" style="text-decoration: none">
                        <h1>题源目录&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </h1>
                </td>
                <td>
                    <a href="./Problem?paperid=-1" style="text-decoration: none">
                        <h1>卷卷目录&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </h1>
                </td>
                <td>
                    <a href="./" style="text-decoration: none">
                        <h1>首页</h1>
                </td>
            </tr>
        </table>
		<h1>章节列表---${sourcename}</h1>
		<#if chapterlength != -1>
			<table style="font-size:  x-large;">
					<#list 0..chapterlength as i>
						<tr class="edge">
							<td>
								<p>${chapters[i].sourcechapterindex}---</p>
							</td>
							<td>
								<a href="./Chapter?chapterid=${chapters[i].idsourcechapter?c}" style="text-decoration: none">
									<p>${chapters[i].sourcechaptername}</p>
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
			    	console.log('dddddddddd');
				},
				fail: function(msg) {
			    	console.log(msg);
			    }
			})
		}
	</script>
</html>