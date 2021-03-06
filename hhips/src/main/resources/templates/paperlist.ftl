<html>
<head>
	<meta charset="utf-8"/>
	<title>卷卷列表</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="./js/common.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<#include "/header.ftl">
		<#if paperlength != -1>
			<table class="dmmtable" style="font-size:  x-large;">
					<#list 0..paperlength as i>
						<tr>
							<td>
								<p>${papers[i].idpaper?c}</p>
							</td>
							<td>
								<a href="./Problem?paperid=${papers[i].idpaper?c}" style="text-decoration: none">
									<p>打印版</p>
								</a>
							</td>
							<td>
								<a href="./Problem?paperid=${papers[i].idpaper?c}&showanswer=1" style="text-decoration: none">
									<p>${papers[i].papername}分析版 &nbsp;&nbsp;&nbsp;</p>
								</a>
							</td>
							<#if papers[i].isactive == 1>
								<td>
									<button type="button" class="picked right largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},1)">In Edit</button>
								</td>
							<#else>
								<td>
									<button type="button" class="picked largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},1)">In Edit</button>
								</td>
							</#if>
							<#if papers[i].isactive == 2>
								<td>
									<button type="button" class="right largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},2)">Active</button>
								</td>
							<#else>
								<td>
									<button type="button" class="largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},2)">Active</button>
								</td>
							</#if>
							<#if papers[i].isactive == 3>
								<td>
									<button type="button" class="right largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},3)">Done</button>
								</td>
							<#else>
								<td>
									<button type="button" class="largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},3)">Done</button>
								</td>
							</#if>
							<#if papers[i].isactive == 4>
								<td>
									<button type="button" class="right largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},4)">Hold</button>
								</td>
							<#else>
								<td>
									<button type="button" class="largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},4)">Hold</button>
								</td>
							</#if>
							<#if papers[i].isactive == 5>
								<td>
									<button type="button" class="right largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},5)">Archive</button>
								</td>
							<#else>
								<td>
									<button type="button" class="largeFont" onclick="changePaperStatus(${papers[i].idpaper?c},5)">Archive</button>
								</td>
							</#if>
						</tr>	
					</#list>
			</table>
		</#if>
		<div align="right">
            <a href="./Problem?paperid=-2" style="text-decoration: none">
                <p>历史卷</p>
            </a>
        </div>
		<br>
		</br>
		<p>New Paper:</p>
		<input class="bigFont" type="text" id="papername" />
		<button class="bigFont" type="button" onclick="postPaper()">Create Paper</button>

	</body>
	<script>
		function postPaper() {
			var pData = {};
			pData.papername = $( "#papername" ).val();
			
			console.log(JSON.stringify(pData));
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: "./Paper",
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