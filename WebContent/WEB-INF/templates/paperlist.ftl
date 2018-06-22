<html>
<head>
	<meta charset="utf-8"/>
	<title>Source List</title>
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
							<#if papers[i].isactive == 2>
								<td>
									<button type="button" class="right largeFont" onclick="changePaperStatus(${papers[i].idpaper},2)">Active</button>
								</td>
							<#else>
								<td>
									<button type="button" class="largeFont" onclick="changePaperStatus(${papers[i].idpaper},2)">Active</button>
								</td>
							</#if>
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
</html>