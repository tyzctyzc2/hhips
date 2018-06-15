<html>
<head>
	<meta charset="utf-8"/>
	<title>Source List</title>
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
	</style>
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
									<p>${papers[i].papername} Answer </p>
								</a>
							</td>
						</tr>	
					</#list>
			</table>
		</#if>
		
	</body>
</html>