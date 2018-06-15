<html>
<head>
	<meta charset="utf-8"/>
	<title>Chapter List</title>
	<style>
		* {
			margin: 0;
			padding: 0;
		}
		.imgbox {
			display: grid;
			height: 100%;
		}
		.center-fit {
			max-width: 100%;
			max-height: 100vh;
			margin: auto;
		}
		.edge {
			box-shadow: 0px 0px 2px 2px rgba(0,0,255,.4);
		}
		.bigFont {
			font-size: xx-large;
		}
	</style>
	<script type="text/javascript" src="/hhipsair/jquery-3.3.1.min.js"></script>
</head>
	<body>
		<h1>Chapter List</h1>
		<p>${sourcename}</p>
		<#if chapterlength != -1>
			<table style="font-size:  x-large;">
					<#list 0..chapterlength as i>
						<tr class="edge">
							<td>
								<p>${chapters[i].sourcechapterindex}---</p>
							</td>
							<td>
								<a href="/hhipsair/Chapter?chapterid=${chapters[i].idsourcechapter}" style="text-decoration: none">
									<p>${chapters[i].sourcechaptername}</p>
								</a>
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
		var newchapterindex=${newchapterindex}
		function postChapter() {
			var pData = {};
			pData.sourcechaptername = $( "#newchaptername" ).val();
			pData.sourcechapterindex = newchapterindex;
			pData.sourceid = sourceID;
			
			console.log(JSON.stringify(pData));
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: "/hhipsair/Chapter",
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