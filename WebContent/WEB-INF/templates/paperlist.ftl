<html>
<head>
	<meta charset="utf-8"/>
	<title>Source List</title>
	<script type="text/javascript" src="/hhipsair/jquery-3.3.1.min.js"></script>
	<link href="myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<h1>Source List</h1>
		<#if paperlength != -1>
			<table style="font-size:  x-large;">
					<#list 0..paperlength as i>
						<tr class="edge">
							<td>
								<p>${papers[i].idpaper}---</p>
							</td>
							<td>
								<a href="/hhipsair/Problem?paperid=${papers[i].idpaper}" style="text-decoration: none">
									<p>${papers[i].papername} &nbsp;&nbsp;&nbsp;</p>
								</a>
							</td>
							<td>
								<a href="/hhipsair/Problem?paperid=${papers[i].idpaper}&showanswer=1" style="text-decoration: none">
									<p>${papers[i].papername} Answer &nbsp;&nbsp;&nbsp;</p>
								</a>
							</td>
							<#if papers[i].isactive == 1>
								<td>
									<button type="button" class="right largeFont" onclick="changePaperStatus(${papers[i].idpaper},1)">In Edit</button>
								</td>
							<#else>
								<td>
									<button type="button" class="largeFont" onclick="changePaperStatus(${papers[i].idpaper},1)">In Edit</button>
								</td>
							</#if>
							<td>&nbsp;&nbsp;</td>
							<#if papers[i].isactive == 2>
								<td>
									<button type="button" class="right largeFont" onclick="changePaperStatus(${papers[i].idpaper},2)">Active</button>
								</td>
							<#else>
								<td>
									<button type="button" class="largeFont" onclick="changePaperStatus(${papers[i].idpaper},2)">Active</button>
								</td>
							</#if>
							<td>&nbsp;&nbsp;</td>
							<#if papers[i].isactive == 3>
								<td>
									<button type="button" class="right largeFont" onclick="changePaperStatus(${papers[i].idpaper},3)">Done</button>
								</td>
							<#else>
								<td>
									<button type="button" class="largeFont" onclick="changePaperStatus(${papers[i].idpaper},3)">Done</button>
								</td>
							</#if>
						</tr>	
					</#list>
			</table>
		</#if>
		
	</body>
	<script>
		function changePaperStatus(idpaper, isactive) {
			var pData = {};
			pData.idpaper = idpaper;
			pData.isactive = isactive;
			
			console.log(JSON.stringify(pData));
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: "/hhipsair/Paper",
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: JSON.stringify(pData),
				success: function(msg) {
					console.log('success');
			    	console.log(msg);
			    	window.location.reload();
				},
				fail: function(msg) {
					console.log('failed');
			    	console.log(msg);
			    }
			})
		}
	</script>
</html>