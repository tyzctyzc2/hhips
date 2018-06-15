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
		<#if sourcelength != -1>
			<table style="font-size:  x-large;">
					<#list 0..sourcelength as i>
						<tr class="edge">
							<td>
								<p>${sources[i].idsource}---</p>
							</td>
							<td>
								<a href="/hhipsair/Chapter?sourceid=${sources[i].idsource}" style="text-decoration: none">
									<p>${sources[i].sourcename}</p>
								</a>
							</td>
						</tr>	
					</#list>
			</table>
		</#if>
		
		<div>
			<a href="/hhipsair/Problem?paperid=-1" style="text-decoration: none">
				<p>All Active Paper</p>
		</div>
	</body>
</html>