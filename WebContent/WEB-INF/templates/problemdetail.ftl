<html>
<head>
	<meta charset="utf-8"/>
	<title>Chapter View</title>
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
		<h1>Problem View</h1>
		<table>
			<tr class="edge">
				<td>
					<p>${problemdetail.problemindex}</p>
				</td>
				<td>
					<img id="myImage" class="center-fit" src=${problemdetail.problemdetail} />
				</td>
			</tr>	
		</table>
		<table>
			<tr class="edge">
				<td>
					<p>${problemdetail.problemlevel}</p>
				</td>
				<td>
					<img id="myImage" class="center-fit" src=${problemdetail.problemanswerdetail} />
				</td>
			</tr>	
		</table>
		<#if worklength != -1>
			<table>
					<#list 0..worklength as i>
						<tr class="edge">
							<td>
								<p>${works[i].workdate?string("yyyy_MM_dd")} &nbsp;  [${works[i].usedtime/60}]</p>
							</td>
							<td>
								<img id="myImage" class="center-fit" src=${works[i].workdetail} />
							</td>
						</tr>
					</#list>
			</table>
		</#if>
	</body>
</html>